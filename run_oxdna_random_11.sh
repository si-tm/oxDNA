#!/bin/bash
# #!/usr/bin/bash

# input strands [1, 0, ... ] then make their req
# 温度の変更を可能にする

return_input () {
    target_dir=$1"/input_L*"
    echo `ls $1`
}

make_seq () {
    python3 make_seq/read_requirement.py $1
}

make_top_conf () {
    # BOX_SIZE=100
    BOX_SIZE=500
    SEQ=$1
    python3 utils/generate-sa-soturon.py $BOX_SIZE $SEQ
}

make_input () {
    # dir_path /　なし
    dir_path=$1
    target=$2
    temperature=$3

    echo "wow"
    echo $dir_path
    echo $target
    echo $temperature
    echo "wow"

    # テンプレートの用意
    # dir_path : temperature
    # target : " " 
    INPUTFILE="${dir_path}/input_${target}"
    SEQDEPFILE="${dir_path}/input_seq_dep_${target}"
    TRAPFILE="${dir_path}/input_trap_${target}"
    FORCESFILE="${dir_path}/forces_${target}.dat"

    cp template/sub_input $INPUTFILE
    cp template/sub_input_seq_dep $SEQDEPFILE
    cp template/sub_input_trap $TRAPFILE
    cp template/forces.dat $FORCESFILE

    # inputファイル書き換え

    TOPFILE="${dir_path}/generated_${target}.top"
    CONFFILE="${dir_path}/generated_${target}.dat"

    # echo "$INPUTFILE fix"

    sed -i -e "s|TOP|$TOPFILE|" $INPUTFILE

    sed -i -e "s|energy.dat|${dir_path}/energy_${target}.dat|" $INPUTFILE
    sed -i -e "s|hb.dat|${dir_path}/hb_${target}.dat|" $INPUTFILE
    sed -i -e "s|log.dat|${dir_path}/log_${target}.dat|" $INPUTFILE
    sed -i -e "s|trajectory.dat|${dir_path}/trajectory_${target}.dat|" $INPUTFILE
    sed -i -e "s|last_conf|${dir_path}/last_conf_${target}.dat|" $INPUTFILE

    sed -i -e "s|CONF|$CONFFILE|" $INPUTFILE
    # sed -i -e 's|STEPS|200000|' $INPUTFILE
    # sed -i -e 's|STEPS|2000000|' $INPUTFILE
    # sed -i -e 's|STEPS|100000000|' $INPUTFILE
    sed -i -e 's|STEPS|10|' $INPUTFILE
    sed -i -e "s|TEMP|$temperature|" $INPUTFILE
    

    # echo "$SEQDEPFILE fix"

    sed -i -e "s|TOP|$TOPFILE|" $SEQDEPFILE

    sed -i -e "s|last_conf_seq_dep.dat|${dir_path}/last_conf_seq_dep_${target}.dat|" $SEQDEPFILE
    sed -i -e "s|trajectory_seq_dep.dat|${dir_path}/trajectory_seq_dep_${target}.dat|" $SEQDEPFILE
    sed -i -e "s|log_seq_dep.dat|${dir_path}/log_seq_dep_${target}.dat|" $SEQDEPFILE
    sed -i -e "s|energy_seq_dep.dat|${dir_path}/energy_seq_dep_${target}.dat|" $SEQDEPFILE
    sed -i -e "s|hb_seq_dep.dat|${dir_path}/hb_energy_seq_dep_${target}.dat|" $SEQDEPFILE

    sed -i -e "s|CONF|$CONFFILE|" $SEQDEPFILE
    sed -i -e 's|seq_dep_file = ../oxDNA1_sequence_dependent_parameters.txt|seq_dep_file = oxDNA1_sequence_dependent_parameters.txt' $SEQDEPFILE
    # sed -i -e 's|STEPS|200000|' $SEQDEPFILE
    # sed -i -e 's|STEPS|2000000|' $SEQDEPFILE
    # sed -i -e 's|STEPS|100000000|' $SEQDEPFILE
    sed -i -e 's|STEPS|10|' $SEQDEPFILE
    sed -i -e "s|TEMP|$temperature|" $SEQDEPFILE


    # echo "$TRAPFILE fix"

    sed -i -e "s|TOP|$TOPFILE|" $TRAPFILE

    sed -i -e "s|last_conf_trap.dat|${dir_path}/last_conf_trap_${target}.dat|" $TRAPFILE
    sed -i -e "s|trajectory_trap.dat|${dir_path}/trajectory_trap_${target}.dat|" $TRAPFILE
    sed -i -e "s|log_trap.dat|${dir_path}/log_trap_${target}.dat|" $TRAPFILE
    sed -i -e "s|energy_trap.dat|${dir_path}/energy_trap_${target}.dat|" $TRAPFILE
    sed -i -e "s|hb_trap.dat|${dir_path}/hb_energy_trap_${target}.dat|" $TRAPFILE

    sed -i -e "s|CONF|$CONFFILE|" $TRAPFILE
    sed -i -e "s|FORCE|${FORCESFILE}|" $TRAPFILE
    sed -i -e 's|external_forces = 1|external_forces = 0|' $TRAPFILE # forceファイルを使わない設定
    # sed -i -e 's|STEPS|200000|' $TRAPFILE
    # sed -i -e 's|STEPS|2000000|' $TRAPFILE
    # sed -i -e 's|STEPS|100000000|' $SEQDEPFILE
    sed -i -e 's|STEPS|10|' $SEQDEPFILE
    sed -i -e "s|TEMP|$temperature|" $TRAPFILE

}

run_oxdna () {
    OXDNA_BIN=build/bin/oxDNA
    INPUTFILE=$1
    SEQDEPFILE=$2
    TRAPFILE=$3

    if [ -e $OXDNA_BIN ]
    then
        # run the samples
        echo "Starting VMMC simulation with the sequence-averaged version of the model"
        echo $INPUTFILE
        $OXDNA_BIN $INPUTFILE
        
        echo "Starting VMMC simulation with the sequence-dependent version of the model"
        echo $SEQDEPFILE
        cat $SEQDEPFILE
        $OXDNA_BIN $SEQDEPFILE

        echo "Starting VMMC simulation with the sequence-averaged version of the model and traps acting between nucleotides (see hairpin_forces.dat for details of the traps)"
        echo $TRAPFILE
        $OXDNA_BIN $TRAPFILE
    else
        echo "Can't find $OXDNA_BIN, did you compile oxDNA?"
        exit

    fi
}

# requirement temperatureを引数とする

req_name=$1
temperature=$2
echo "req_name : "
echo $req_name
seq_name=`make_seq $req_name`
echo "seq_name : "
echo $seq_name
make_top_conf $seq_name
dir_path=`dirname $seq_name`
target=`basename $dir_path`
echo "wow"
echo $dir_path
echo $target
echo $temperature
echo "wow"
make_input $dir_path $target $temperature
echo $INPUTFILE
run_oxdna $INPUTFILE $SEQDEPFILE $TRAPFILE

if [ -e {results/} ]; then
    echo "results directory exit"
else
    mkdir results/
fi

if [ -e {"results/"$dir_path} ]; then
    echo "results directory exit"
else
    echo "results/"$dir_path
    mkdir -p "results/"$dir_path
fi

echo $dir_path
echo "results/"$target"_t"$temperature
echo $temperature


cp -r $dir_path"/"$target "results/"$target"_t"$temperature
cp -r $dir_path "results/"$target"_t"$temperature"/"
cp -r $dir_path "results/"$dir_path"/"
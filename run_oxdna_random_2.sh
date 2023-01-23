#!/usr/bin/bash

# make_reqs () {
#     for i in `seq 0 1`
#     do
#         python3 make_seq/make_requirement_seq.py
#     done
# }

# make_seqs () {
#     reqlst=`ls results_soturon/*/*/*/*`
#     for l in $reqlst
#     do
#     echo $l
#     python make_seq/read_requirement.py $l
#     done
# }

return_input () {
    target_dir=$1"/input_L*"
    echo `ls $1`
}

make_req1 () {
    req_path=`python3 make_seq/make_requirement_seq.py L1`
    echo $req_path
}
make_req2 () {
    req_path=`python3 make_seq/make_requirement_seq.py L2`
    echo $req_path
}
make_req3 () {
    req_path=`python3 make_seq/make_requirement_seq.py L3`
    echo $req_path
}

make_seq () {
    python make_seq/read_requirement.py $1
}

make_top_conf () {
    BOX_SIZE=100
    SEQ=$1
    python3 utils/generate-sa-soturon.py $BOX_SIZE $SEQ
}

make_input () {
    # dir_path /　なし
    dir_path=$1
    target=$2
    # テンプレートの用意
    INPUTFILE="${dir_path}/input_${target}"
    SEQDEPFILE="${dir_path}/input_seq_dep_${target}"
    TRAPFILE="${dir_path}/input_trap_${target}"
    FORCESFILE="${dir_path}/forces_${target}.dat"

    cp template/input $INPUTFILE
    cp template/input_seq_dep $SEQDEPFILE
    cp template/input_trap $TRAPFILE
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
    sed -i -e 's|STEPS|20|' $INPUTFILE

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
    sed -i -e 's|STEPS|20|' $SEQDEPFILE

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
    sed -i -e 's|STEPS|20|' $TRAPFILE

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

echo $1

if [ $1 = "L1" ]; then
    req_name=`make_req1`
elif [ $1 = "L2" ]; then 
    req_name=`make_req2`
elif [ $1 = "L3" ]; then 
    req_name=`make_req3`
else
    echo "./make_requirement_seq.py L[0-3]"
fi

echo $req_name
seq_name=`make_seq $req_name`
echo $seq_name
make_top_conf $seq_name
dir_path=`dirname $seq_name`
target=`basename $dir_path`
echo $dir_path
echo $target
make_input $dir_path $target
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

cp -r $dir_path "results/"$dir_path

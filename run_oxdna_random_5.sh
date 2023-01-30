#!/usr/bin/bash

extract_req () {
    runfile="common/get_target_file.py"
    python3 $runfile $target_dir "req"
}

make_diff-seq_req () {
    # echo $type_of_l
    runfile="make_seq/make_diff-seq.py"
    python3 $runfile $1
}

make_seq () {
    python3 make_seq/read_requirement.py $1
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


# target_dir=$1
# target_dir="results_soturon/L1/d-0-1/L1_d-0-1_2023-01-27-083608/L1_d-0-1_2023-01-27-083608/"
# req=`extract_req`
# req="reqs/random_5/L1/L1/req_L1_d-0-1-11-15_2023-01-27-054537"
req=$1
# echo $req
new_req=`make_diff-seq_req $req`
# echo $new_req

seq_name=`make_seq $new_req`
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

mv $dir_path"/" "results/"$dir_path"/"$target

# echo $req
# echo $new_req
# echo $dir_path
# echo "results/"$dir_path
cat $INPUTFILE
ls "results/"
ls "results/"$dir_path"/"$target

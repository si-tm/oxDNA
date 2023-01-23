#!/usr/bin/bash

# try_my_sample/下で動かす

# ファイル名の取得
# .datを除く
# now=$1
now="results_soturon/L1/seq_test"
now=${now:0:${#now}-4}
echo ${now}

# 入力ファイルの作成
# seqファイルの用意
# SEQ=$1
SEQ="results_soturon/L1/seq_test"
# seqファイルをtry_my_sampleへ移動する
cp $SEQ_FROM $SEQ 
# make top and conf file
echo $SEQ
BOX_SIZE=100
python3 utils/generate-sa-original.py $BOX_SIZE $SEQ

# テンプレートの用意
# INPUTFILE="try_my_sample/input_${now}"
# SEQDEPFILE="try_my_sample/input_seq_dep_${now}"
# TRAPFILE="try_my_sample/input_trap_${now}"
# FORCESFILE="try_my_sample/forces_${now}.dat"

# cp template/input $INPUTFILE
# cp template/input_seq_dep $SEQDEPFILE
# cp template/input_trap $TRAPFILE
# cp template/forces.dat $FORCESFILE

# # inputファイル書き換え

# TOPFILE="try_my_sample/generated_${now}.top"
# CONFFILE="try_my_sample/generated_${now}.dat"
# mv generated.top $TOPFILE
# mv generated.dat $CONFFILE
# SEQFILE=$1

# #### ここから

# echo "$INPUTFILE fixed"

# sed -i -e "s|TOP|$TOPFILE|" $INPUTFILE
# sed -i -e "s|.dat|_${now}.dat|" $INPUTFILE
# sed -i -e "s|CONF|$CONFFILE|" $INPUTFILE
# sed -i -e 's|STEPS|200000|' $INPUTFILE

# # input_seq_depファイル書き換え

# echo "$SEQDEPFILE fixed"

# sed -i -e "s|TOP|$TOPFILE|" $SEQDEPFILE
# sed -i -e "s|.dat|_${now}.dat|" $SEQDEPFILE
# sed -i -e "s|CONF|$CONFFILE|" $SEQDEPFILE
# sed -i -e 's|seq_dep_file = ../oxDNA1_sequence_dependent_parameters.txt|seq_dep_file = oxDNA1_sequence_dependent_parameters.txt' $SEQDEPFILE
# sed -i -e 's|STEPS|200000|' $SEQDEPFILE

# # input_trapファイル書き換え

# echo "$TRAPFILE fixed"

# sed -i -e "s|TOP|$TOPFILE|" $TRAPFILE
# sed -i -e "s|.dat|_${now}.dat|" $TRAPFILE
# sed -i -e "s|CONF|$CONFFILE|" $TRAPFILE
# sed -i -e "s|FORCE|${FORCESFILE}|" $TRAPFILE
# sed -i -e 's|external_forces = 1|external_forces = 0|' $TRAPFILE # forceファイルを使わない設定
# sed -i -e 's|STEPS|200000|' $TRAPFILE

# echo "tmp2.sh"
# cat tmp2.sh
# echo "input_seq_dep"
# cat $SEQDEPFILE
# echo "input seq_dep"
# cat try_my_sample/input_seq_dep_seqA-GA100000-0.80_final_20200904210434
# ls try_my_sample/

# # 実行
# OXDNA_BIN=build/bin/oxDNA

# if [ -e $OXDNA_BIN ]
# then
#     # run the samples
#     echo "Starting VMMC simulation with the sequence-averaged version of the model"
#     echo $INPUTFILE
#     $OXDNA_BIN $INPUTFILE
    
#     echo "Starting VMMC simulation with the sequence-dependent version of the model"
#     echo $SEQDEPFILE
#     cat $SEQDEPFILE
#     $OXDNA_BIN $SEQDEPFILE

#     echo "Starting VMMC simulation with the sequence-averaged version of the model and traps acting between nucleotides (see hairpin_forces.dat for details of the traps)"
#     echo $TRAPFILE
#     $OXDNA_BIN $TRAPFILE
# else
#     echo "Can't find $OXDNA_BIN, did you compile oxDNA?"
#     exit

# fi

# # ファイルの移動
# # echo "move input and output files to results directory"

# if [ -e {results/} ]; then
#     echo "results directory exit"
# else
#     mkdir results/
# fi

# # cd run_samples/
# mv -f try_my_samples/*.dat results/
# mv -f *.dat results/
# mv -f input* results/

# mv -f "$SEQFILE" results/
# mv -f "$TOPFILE" results/
# mv -f "$CONFFILE" results/

# # inputs move to results directory

# mv -f $INPUTFILE results/
# mv -f $SEQDEPFILE results/
# mv -f $TRAPFILE results/

# ls try_my_sample
# mv -f try_my_sample/* results/

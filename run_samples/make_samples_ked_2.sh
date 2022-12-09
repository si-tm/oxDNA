#!/usr/bin/bash

# try_my_sample/下で動かす

# ファイル名の取得
# .datを除く
now=$1
now=${now:0:${#now}-4}
echo ${now}

# 入力ファイルの作成
# seqファイルの用意
SEQ=$1
SEQ_FROM="try_KakenhiEvolveDNA/${SEQ:0:4}/$SEQ"
SEQ="try_my_sample/$SEQ"
# # seqファイルをtry_my_sampleへ移動する
cp $SEQ_FROM $SEQ 
# make top and conf file
echo $SEQ
BOX_SIZE=100
python3 utils/generate-sa-original.py $BOX_SIZE $SEQ

# テンプレートの用意
INPUTFILE="try_my_sample/input_${now}"
SEQDEPFILE="try_my_sample/input_seq_dep_${now}"
TRAPFILE="try_my_sample/input_trap_${now}"
FORCESFILE="try_my_sample/forces_${now}.dat"

cp template/input $INPUTFILE
cp template/input_seq_dep $SEQDEPFILE
cp template/input_trap $TRAPFILE
cp template/forces.dat $FORCESFILE

# inputファイル書き換え

TOPFILE="try_my_sample/generated_${now}.top"
CONFFILE="try_my_sample/generated_${now}.dat"
mv generated.top $TOPFILE
mv generated.dat $CONFFILE
SEQFILE=$1

echo `expr ls try_my_sample/`

# sed -i -e "s|TOP|$TOPFILE|" $INPUTFILE
# sed -i -e "s|.dat|_${now}.dat|" $INPUTFILE
# sed -i -e "s|CONF|$CONFFILE|" $INPUTFILE

# input_seq_depファイル書き換え

# sed -i -e "s|TOP|$TOPFILE|" $SEQDEPFILE
# sed -i -e "s|.dat|_${now}.dat|" $SEQDEPFILE
# sed -i -e "s|CONF|$CONFFILE|" $SEQDEPFILE

# input_trapファイル書き換え

# sed -i -e "s|TOP|$TOPFILE|" $TRAPFILE
# sed -i -e "s|.dat|_${now}.dat|" $TRAPFILE
# sed -i -e "s|CONF|$CONFFILE|" $TRAPFILE
# sed -i -e "s|FORCE|${FORCESFILE}|" $TRAPFILE
# sed -i -e "/external_forces/c external_forces = 0|" $TRAPFILE # forceファイルを使わない設定

# # # 実行
# OXDNA_BIN=../build/bin/oxDNA

# if [ -e $OXDNA_BIN ]
# then
    # run the samples
#     echo "Starting VMMC simulation with the sequence-averaged version of the model"
#     echo $INPUTFILE
#     $OXDNA_BIN $INPUTFILE
    
#     echo "Starting VMMC simulation with the sequence-dependent version of the model"
#     echo $SEQDEPFILE
#     $OXDNA_BIN $SEQDEPFILE

#     echo "Starting VMMC simulation with the sequence-averaged version of the model and traps acting between nucleotides (see hairpin_forces.dat for details of the traps)"
#     echo $TRAPFILE
#     $OXDNA_BIN $TRAPFILE
# else
#     echo "Can't find $OXDNA_BIN, did you compile oxDNA?"
#     exit

# fi

# # # ファイルの移動
# echo "move input and output files to results directory"

# if [ -e {../results/} ]; then
#     echo "results directory exit"
# else
#     mkdir ../results/
# fi

# # cd run_samples/
# mv -f *.dat ../results/

# mv -f "$SEQFILE" ../results/
# mv -f "$TOPFILE" ../results/
# mv -f "$CONFFILE" ../results/


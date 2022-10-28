# 現在時刻の取得
now=$(date '+%F-%H%M%S')
echo ${now}

# 入力ファイルの作成
# conf, topファイルの作成
if [ -e {../utils/seq/} ]; then
    echo "seq directory exit"
else
    mkdir ../utils/seq/
fi
if [ -e {../utils/testcase/} ]; then
    echo "testcase directory exit"
else
    mkdir ../utils/testcase/
fi
FILENAME=$(python3 ../utils/generate_random_seq.py ${now})
python3 ../utils/generate-sa.py 10 $FILENAME $now

# テンプレートの用意
INPUTFILE="../try_my_sample/input_${now}"
SEQDEPFILE="../try_my_sample/input_seq_dep_${now}"
TRAPFILE="../try_my_sample/input_trap_${now}"
FORCESFILE="../utils/forces_${now}.dat"

echo $FORCESFILE

cp ../template/input $INPUTFILE
cp ../template/input_seq_dep $SEQDEPFILE
cp ../template/input_trap $TRAPFILE
cp ../template/forces.dat $FORCESFILE

# inputファイル書き換え


TOPFILE="../utils/testcase/generated_${now}.top"
CONFFILE="../utils/testcase/generated_${now}.conf"
SEQFILE="../utils/seq/seq_${now}.dat"

sed -i -e "s|TOP|$TOPFILE|" $INPUTFILE
sed -i -e "s|CONF|$CONFFILE|" $INPUTFILE
sed -i -e "s|.dat|_${now}.dat|" $INPUTFILE

# input_seq_depファイル書き換え

sed -i -e "s|TOP|$TOPFILE|" $SEQDEPFILE
sed -i -e "s|CONF|$CONFFILE|" $SEQDEPFILE
sed -i -e "s|.dat|_${now}.dat|" $SEQDEPFILE

# input_trapファイル書き換え

sed -i -e "s|TOP|$TOPFILE|" $TRAPFILE
sed -i -e "s|CONF|$CONFFILE|" $TRAPFILE
sed -i -e "s|.dat|_${now}.dat|" $TRAPFILE
sed -i -e "s|FORCE|${FORCESFILE}|" $TRAPFILE

# 実行
OXDNA_BIN=../build/bin/oxDNA

if [ -e $OXDNA_BIN ]
then
    # run the samples
    echo "Starting VMMC simulation with the sequence-averaged version of the model"
    echo $INPUTFILE
    $OXDNA_BIN $INPUTFILE
    
    echo "Starting VMMC simulation with the sequence-dependent version of the model"
    echo $SEQDEPFILE
    $OXDNA_BIN $SEQDEPFILE

    echo "Starting VMMC simulation with the sequence-averaged version of the model and traps acting between nucleotides (see hairpin_forces.dat for details of the traps)"
    echo $TRAPFILE
    $OXDNA_BIN $TRAPFILE
else
    echo "Can't find $OXDNA_BIN, did you compile oxDNA?"
    exit

fi

# ファイルの移動
echo "move input and output files to results directory"

cd ..
if [ -e {results/} ]; then
    echo "results directory exit"
else
    mkdir results/
fi

cd run_samples/
mv -f *.dat ../results/

mv -f "$SEQFILE" ../results/
mv -f "$TOPFILE" ../results/
mv -f "$CONFFILE" ../results/


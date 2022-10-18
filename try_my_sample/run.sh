#!/bin/bash

# CODEDIR=../build
# OXDNA_BIN=$CODEDIR/bin/oxDNA
CODEDIR=..
OXDNA_BIN=$CODEDIR/build/bin/oxDNA

echo "make input files"
TOPFILE=`find ../utils/testcase/ -name \*.top`
CONFFILE=`find ../utils/testcase/ -name \*.conf`
echo $TOPFILE
echo $CONFFILE

# make input file
sed -i -e "s|TOP|$TOPFILE|" input
sed -i -e "s|CONF|$CONFFILE|" input


if [ -e $OXDNA_BIN ]
then
    # run the samples
    echo "Starting VMMC simulation with the sequence-averaged version of the model"
    $OXDNA_BIN input
    
    echo "Starting VMMC simulation with the sequence-dependent version of the model"
    $OXDNA_BIN input_seq_dep

    echo "Starting VMMC simulation with the sequence-averaged version of the model and traps acting between nucleotides (see hairpin_forces.dat for details of the traps)"
    $OXDNA_BIN input_trap
else
    echo "Can't find $OXDNA_BIN, did you compile oxDNA?"
    exit

fi

echo "move input and output files to results directory"

cd ..
mkdir results/
cd try_my_sample/
mv -f *.dat ../results/

mv -f "$TOPFILE" ../results/
mv -f "$CONFFILE" ../results/

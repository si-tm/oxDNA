#!/usr/bin/bash
RUN_FILE="run_samples/make_samples_ked_2.sh"
echo `expr ls run_samples/`
chmod 755 $RUN_FILE
SEQ_FILE="seqA-GA100000-0.80_final_20200904131038.dat"
./$RUN_FILE $SEQ_FILE
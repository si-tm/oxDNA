#!/bin/bash
cd try_my_sample/
RUN_FILE="../run_samples/make_samples_ked_1.sh"
chmod 755 $RUN_FILE
SEQ_FILE="../try_KakenhiEvolveDNA/seqA/seqA-GA100000-0.80_final_20200904131038.dat"
SEQ_FILE="seqA-GA100000-0.80_final_20200904131038.dat"
./$RUN_FILE $SEQ_FILE
# choose sequence file
SEQ="../try_KakenhiEvolveDNA/seqA/seqA-GA100000-0.80_final_20200904131038.dat"
SEQ="../try_KakenhiEvolveDNA/seqA/seqA-GA100000-0.80_final_20200904154835.dat"
# make top and conf file
echo $SEQ
BOX_SIZE=10
python3 generate-sa-original.py $BOX_SIZE $SEQ
# move input files to execution directory

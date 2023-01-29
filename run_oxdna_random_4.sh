#!/bin/bash

# 同じseqで10個

for i in `seq 1 1`
do
    # ./run_oxdna_random_2.sh $1
    ./run_oxdna_random.sh $1
done

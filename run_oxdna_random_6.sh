#!/usr/bin/bash

echo $1

for i in `seq 1 10`
do
    echo $i
    # ./run_oxdna_random_4.sh "results_soturon/L1/d-0-1/L1_d-0-1_2023-01-27-083608/L1_d-0-1_2023-01-27-083608/"
    # ./run_oxdna_random_4.sh $1
    ./run_oxdna_random_5.sh $1
done

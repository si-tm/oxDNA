#!/bin/bash

# ./run_req_iteration_all.sh conf/req_L1_1 25 1 1000000 100000
# ./run_req_iteration_all.sh conf/req_L2_1 25 1 1000000 100000
# ./run_req_iteration_all.sh conf/req_L3_1 50 1 5000000 500000

target_dir=$1 # "conf/req_L1_1"
box_size=$2 # L1,L2: 25, L3: 50
iteration=$3 # 1-10
step=$4 # L1,L2 1000000, L3 5000000
step=$5 # L1,L2 100000, L3 500000

# ディレクトリ内の全てのファイルに対して処理を実行
for dir in "$target_dir"/*; do
    echo $dir
    file=$(ls $dir)
    echo $file
    name="${file#req_}"     # 先頭の req_ を削除
    name="${name%.txt}"     # 末尾の .txt を削除
    echo $name
    # ./run_req_iteration.sh conf/req_L1_1/r1730373350439-94911 r1730373350439-94911 25 1 10
    echo "./run_req_iteration.sh $dir $name $box_size $iteration $step $iteration_step"
done

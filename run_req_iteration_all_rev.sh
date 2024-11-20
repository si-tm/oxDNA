#!/bin/bash

# ./run_req_iteration_all.sh conf/req_L1_1 25 1 1000000 100000
# ./run_req_iteration_all.sh conf/req_L2_1 25 1 1000000 100000
# ./run_req_iteration_all.sh conf/req_L3_1 50 1 5000000 500000

target_dir=$1 # "conf/req_L1_1"
box_size=$2 # L1,L2: 25, L3: 50
iteration=$3 # 1-10
step=$4 # L1,L2 1000000, L3 5000000
iteration_step=$5 # L1,L2 100000, L3 500000

echo $box_size $iteration $step $iteration_step
# 25 1 1000000 10000

files=("$target_dir"/*)
for ((i=${#files[@]}-1; i>=0; i--)); do
    dir="${files[i]}"
    echo $dir
    file=$(ls "$dir" | grep '\.txt$')
    echo $file
    name="${file#req_}"     # 先頭の req_ を削除
    name="${name%.txt}"     # 末尾の .txt を削除
    echo $name
    echo "./run_req_iteration.sh $dir $name $box_size $iteration $step $iteration_step"
    ./run_req_iteration.sh $dir $name $box_size $iteration $step $iteration_step
done

# ディレクトリ内の全てのファイルに対して処理を実行
# for dir in "$target_dir"/*; do
#     echo $dir
    # file=$(ls "$dir" | grep '\.txt$')
    # echo $file
    # name="${file#req_}"     # 先頭の req_ を削除
    # name="${name%.txt}"     # 末尾の .txt を削除
    # echo $name
    # echo "./run_req_iteration.sh $dir $name $box_size $iteration $step $iteration_step"
    # ./run_req_iteration.sh $dir $name $box_size $iteration $step $iteration_step
# done

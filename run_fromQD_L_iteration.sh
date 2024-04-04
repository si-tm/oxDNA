#!/bin/bash

# ./run_fromQD_L.sh L2_0
# L2_0以下のrから始まるreqのリストを取る
# それぞれのreqに対し、 ./run_fromQD.sh L1_0 r1711781544506-0 25 を実行する

target=$1
box_size=$2
req_lst=`ls conf/$1`
pattern='_[^.]*.'
iteration=$3

for req in $req_lst
do
    if [[ $req == r* ]]; then
        echo $req
        if [[ $req =~ _([^_.]+)\. ]]; then
            extracted_string="${BASH_REMATCH[1]}"
            echo "抽出された文字列は: $extracted_string"
            ./run_fromQD_iteration.sh $target $extracted_string $box_size $iteration
        else
            echo "該当するパターンが見つかりませんでした。"
        fi
    fi
done

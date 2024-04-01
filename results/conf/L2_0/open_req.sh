#!/bin/bash

dir_list=`ls .`

for dir in $dir_list
do 
    echo $dir/req_$dir.txt
    cp $dir/req_$dir.txt ./req_$dir.txt
    if [[ $dir == r* ]]; then
        rm -rf $dir
    else
        echo "変数aは'r'で始まる文字列ではありません。"
    fi
done
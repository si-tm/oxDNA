#!/bin/bash

csv_file="L3_file_list.csv"

for file in *
do
    # echo "$file"
    echo "$file" >> "$csv_file"
done

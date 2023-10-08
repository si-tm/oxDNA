#!/bin/bash
# #!/usr/bin/bash

# ./run_oxdna_random_12.sh reqs/fromQD/L3 r20230830150848 298
# 引数の数をチェック
# if [ $# -ne 3 ]; then
#   echo "Usage: $0 <directory> <prefix> <temperature>"
  
#   exit 1
# fi

# ディレクトリとプレフィックスを引数から取得
# directory="$1/$2"
# prefix="$2"
# temperature=$3
directory="$1/$2"
prefix="$2"
temperature="$3"
echo $directory
echo $prefix
echo $temperature

# ディレクトリが存在するか確認
if [ ! -d "$directory" ]; then
  echo "Directory does not exist: $directory"
  exit 1
fi

# ディレクトリ内のファイルをリストアップ
files=$(find "$directory" -type f)
IFS=$'\n' read -d '' -r -a files_array <<< "$files"

# ファイルが見つかった場合、一覧表示
if [ -n "$files" ]; then
  echo "Files in $directory with prefix '$prefix':"
  for file in "${files_array[@]}"; do
  echo "Processing file: $file"
  # ここにファイルごとの処理を追加
  echo $file
  echo $temperature
  base=`basaename $file`
  echo "./run_oxdna_random_11.sh $file/$base $temperature"
  ./run_oxdna_random_11.sh $file $temperature
done
else
  echo "No files found in $directory with prefix '$prefix'."
fi

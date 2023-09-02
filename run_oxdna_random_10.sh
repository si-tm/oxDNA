#!/usr/bin/bash
# !/bin/bash

# ./run_oxdna_random_10.sh reqs/fromQD/L3 r20230830150848
# 引数の数をチェック
if [ $# -ne 2 ]; then
  echo "Usage: $0 <directory> <prefix>"
  
  exit 1
fi

# ディレクトリとプレフィックスを引数から取得
directory="$1/$2"
prefix="$2"

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
  ./run_oxdna_random_9.sh $file
done
else
  echo "No files found in $directory with prefix '$prefix'."
fi

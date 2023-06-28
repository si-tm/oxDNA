import os
from datetime import datetime
import random
import sys
# ランダムな長さ10のsequenceを作る

def make_filename(date_time_str):
    # now = datetime.now()
    # date_time_str = now.strftime("%Y-%m-%d-%H%M%S")
    path = f'../utils/seq/seq_{date_time_str}.dat'
    return path

def make_file(path):
    f = open(path, 'w')
    return f

def make_random_seq(len):
    seq = ''
    amide = ['A', 'T', 'G', 'C']
    for i in range(len):
        tmp = random.random()*4
        seq += amide[int(tmp)]
    seq += '\n'
    return seq

def main():
    args = sys.argv
    # ファイルを作成
    path = make_filename(args[1])
    print(path)
    f = make_file(path)
    # ランダムな文字列の生成
    # ファイルに書き込む
    for i in range(5):
        sequence = make_random_seq(10)
        f.write(sequence)
    f.close()

if __name__ == '__main__':
    main()
import numpy as np
import csv

def csv2npy(path):
    f = open(path + ".csv", "r")
    f_csv = csv.reader(f)
    lst = []
    for l in f_csv:
        for e in l:
            lst.append(e)
    np.save(path + ".npy", lst)

def load_npy(path):
    print(np.load(path))

def main():
    csv2npy("structure_seq/input_seq_L3")
    load_npy("structure_seq/input_seq_L3" + ".npy")

if __name__ == '__main__':
  main()

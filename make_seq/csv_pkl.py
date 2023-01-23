import numpy as np
import matplotlib.pylab as plt
import pickle
import csv

def pickle_dump(obj, path):
    with open(path, mode='wb') as f:
        pickle.dump(obj,f)

def pickle_load(path):
    with open(path, mode='rb') as f:
        data = pickle.load(f)
        return data


# {a* b : 1 } combination of domains : no
def make_dic(csv_path, dic_path):
    csv_f = open(csv_path, "r")
    csv_f = csv.reader(csv_f)
    dic = {}
    i = 0
    for l in csv_f:
        dic[l[0]] = i
        i += 1
    
    print(dic)
    pickle_dump(dic, dic_path)


def main():
    l1_csv_path = "make_seq/structure_seq/input_seq_L1.csv"
    l2_csv_path = "make_seq/structure_seq/input_seq_L2.csv"
    l3_csv_path = "make_seq/structure_seq/input_seq_L3.csv"

    l1_dic_path = "make_seq/structure_seq/seq_L1.pkl"
    l2_dic_path = "make_seq/structure_seq/seq_L2.pkl"
    l3_dic_path = "make_seq/structure_seq/seq_L3.pkl"

    make_dic(l1_csv_path, l1_dic_path)
    make_dic(l2_csv_path, l2_dic_path)
    make_dic(l3_csv_path, l3_dic_path)

if __name__ == '__main__':
  main()
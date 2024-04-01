import numpy as np
import matplotlib.pylab as plt
import pickle

class structures():
    def __init__(self):
        self.structures_dic = pickle_load('make_seq/structure_seq/log_seq.pickle')
    

def return_num(type_of_l, str_num):
    dic = pickle_load('make_seq/structure_seq/log_seq.pickle')
    new_dic = dic
    if str_num in new_dic[type_of_l]:
        new_dic[type_of_l][str_num] += 1
    else:
        new_dic[type_of_l][str_num] = 0
    
    pickle_dump(new_dic, 'make_seq/structure_seq/log_seq.pickle')

    return new_dic[type_of_l][str_num]


def pickle_dump(obj, path):
    with open(path, mode='wb') as f:
        pickle.dump(obj,f)

def pickle_load(path):
    with open(path, mode='rb') as f:
        data = pickle.load(f)
        return data

def test():
    mydict = {'L1':{}, 'L2':{}, 'L3':{}}
    pickle_dump(mydict, 'make_seq/structure_seq/log_seq.pickle')
    print(pickle_load('make_seq/structure_seq/log_seq.pickle'))


def main():
    test()
if __name__ == '__main__':
  main()
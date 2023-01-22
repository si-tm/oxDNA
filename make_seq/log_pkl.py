import numpy as np
import matplotlib.pylab as plt
import pickle

class structures():
    def __init__(self):
        pickle_load('make_seq/structure_seq/log_seq.pickle')



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
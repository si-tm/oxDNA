import numpy as np
import matplotlib.pylab as plt
import os
import sys

class read_requirement():
    def __init__(self, path):
        f = open(path, "r")
        self.req_dic = {}
        self.req_dic["req_path"] = path
        self.req_dic["structures"] = []
        self.req_dic["length"] = {}
        self.req_dic["domains"] = {}
        for l in f:
            lst = l.split(" ")
            if lst[0] == "type_of_l":
                self.req_dic["type_of_l"] = lst[-1][:-1]
            if lst[0][0] == 's':
                self.req_dic["structures"].append(self.read_structure(lst))
            if lst[0] == "length":
                self.req_dic["length"][lst[1]] = lst[-1][:-1]
            if lst[0] == "domains":
                self.req_dic["domains"][lst[1]] = lst[-1][:-1]
                self.req_dic["domains"][lst[1] + "*"] = self.seq_reverse(lst[-1][:-1])

        # print(self.req_dic)

        f.close()
    
    def read_structure(self, lst):
        return lst[lst.index("=") + 1 : lst.index("@initial")]

    def seq_reverse(self, str):
        new_str = ""
        rev = {'A' : 'T', 'T' : 'A', 'C' : 'G', 'G': 'T'}
        for d in str[::-1]:
            new_str += rev[d]
        return new_str

    def make_seq(self):
        seq_path =  "/".join(self.req_dic["req_path"].split("/")[:-1]) + "/seq_" + "".join(self.req_dic["req_path"].split("/")[-2])
        print(seq_path)
        if os.path.isfile(seq_path) == False:
            num_of_strand = 10
            f = open(seq_path, "w")
            for lst in self.req_dic["structures"]:
                for rep in range(num_of_strand):
                    str = ""
                    for seq in lst:
                        str += self.req_dic["domains"][seq]
                    f.write(str + '\n')
            f.close()
        

def test(path):
    test_req = read_requirement(path)
    test_req.make_seq()

def main():
    if sys.argv[1].split("/")[-1][0] == 'r':
        test(sys.argv[1])

if __name__ == '__main__':
    main()

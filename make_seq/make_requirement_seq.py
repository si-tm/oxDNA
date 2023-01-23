import random
import csv
import numpy as np
import sys
import pickle
sys.path.append("make_seq/")
import log_pkl as lp
import os

# templateの場所を選択する logファイル作る
# results_soturon/L1, L2, L3
# path名決定

def pickle_load(path):
    with open(path, mode='rb') as f:
        data = pickle.load(f)
        return data

class requirement():
    def __init__(self, L, number_of_types, comb_of_domain, sequence_of_domains):
        self.req_dic = {}
        self.req_dic["type_of_l"] = L
        self.req_dic["number_of_types"] = number_of_types
        for i in range(len(comb_of_domain)):
            self.req_dic["s" + str(i)] = comb_of_domain[0] + " @initial 1.0 M"
        if L == "L1":
            self.req_dic["domains"] = ["a", "b"]
            self.req_dic["length a"] = self.req_dic["length b"] = 10
        if L == "L2":
            self.req_dic["domains"] = ["a", "b"]
            self.req_dic["length a"] = self.req_dic["length b"] = 5
        if L == "L3":
            self.req_dic["domains"] = ["a", "b", "c", "d", "e", "f"]
            self.req_dic["length d"] = 15
            self.req_dic["length a"] = self.req_dic["length b"] = self.req_dic["length c"] = self.req_dic["length e"] = self.req_dic["length f"] = 17
        
        for i in range(len(self.req_dic["domains"])):
            self.req_dic["domains " + self.req_dic["domains"][i]] = sequence_of_domains[i]

    def __init__(self, L):
        # number_of_types, comb_of_domain, sequence_of_domains
        number_of_types = self.random_number_of_types(L)
        comb_of_domain = self.random_comb_of_domain(L, number_of_types)
        

        self.req_dic = {}
        self.req_dic["type_of_l"] = L
        self.req_dic["number_of_types"] = number_of_types
        self.req_dic["comb_of_domain"] = comb_of_domain
       
        for i in range(len(comb_of_domain)):
            self.req_dic["s" + str(i)] = comb_of_domain[i] + " @initial 1.0 M"
        if L == "L1":
            self.req_dic["domains"] = ["a", "b"]
            self.req_dic["length a"] = self.req_dic["length b"] = 10
        if L == "L2":
            self.req_dic["domains"] = ["a", "b"]
            self.req_dic["length a"] = self.req_dic["length b"] = 5
        if L == "L3":
            self.req_dic["domains"] = ["a", "b", "c", "d", "e", "f"]
            self.req_dic["length d"] = 15
            self.req_dic["length a"] = self.req_dic["length b"] = self.req_dic["length c"] = self.req_dic["length e"] = self.req_dic["length f"] = 17
        
        sequence_of_domains = self.random_sequence_of_domain(self.req_dic["domains"], self.req_dic)
        
        for i in range(len(self.req_dic["domains"])):
            self.req_dic["domains " + self.req_dic["domains"][i]] = sequence_of_domains[i]
    
    def random_number_of_types(self, L):
        number_of_types = 0
        if L == "L1":
            number_of_types = random.randrange(2, 7, 1)
        if L == "L2" or L == "L3":
            number_of_types = random.randrange(3, 7, 1)
        return number_of_types

    def random_comb_of_domain(self, L, number_of_types):
        lst = np.load("make_seq/structure_seq/input_seq_" + L + ".npy")
        return np.random.choice(lst, number_of_types, replace=False)
    
    def make_random_sequence(self, length):
        seq_lst = ['A', 'T', 'G', 'C']
        return "".join(random.choices(seq_lst, k=length))

    def random_sequence_of_domain(self, domains, dic):
        sequence_of_domains = []
        for i in range(len(domains)):
            sequence_of_domains.append(self.make_random_sequence(dic["length " + domains[i]]))
        return sequence_of_domains

    def make_requirement(self):
        path = self.dir_name()
        f = open(path, "w")

        f.write("# type_of_l" + "\n")
        f.write("type_of_l = " + self.req_dic["type_of_l"] + "\n")
        f.write("\n")
        f.write("# structure" + "\n")
        f.write("number_of_types = " + str(self.req_dic["number_of_types"]) + "\n")
        i = 0
        while "s"+str(i) in self.req_dic:
            f.write("s" + str(i) + " = " + self.req_dic["s" + str(i)] + "\n")
            i += 1

        f.write("\n")
        f.write("# length" + "\n")
        for i in range(len(self.req_dic["domains"])):
            f.write("length " + self.req_dic["domains"][i] + " = " + str(self.req_dic["length " + self.req_dic["domains"][i]]) + "\n")

        f.write("\n")
        f.write("# sequence of domains" + "\n")
        for i in range(len(self.req_dic["domains"])):
            f.write("domains " + self.req_dic["domains"][i] + " = " + self.req_dic["domains " + self.req_dic["domains"][i]] + "\n")

        f.close()
        return path

    def printobj(self):
        print(self.req_dic["comb_of_domain"])

    def printobj(self):
        print(self.req_dic["comb_of_domain"])

    def dir_name(self):
        # results_soturon/L1/{str_num}/L1_{str_num}_{no.}/req_L1_{str_num}_{no.}
        comb_of_domain_dic = pickle_load("make_seq/structure_seq/seq_" + self.req_dic["type_of_l"] +".pkl")
        str_num = "d"
        for cd in self.req_dic["comb_of_domain"]:
            str_num += "-" + str(comb_of_domain_dic[cd])
        
        number_in_cb = str(lp.return_num(self.req_dic["type_of_l"], str_num))

        dir_path = "results_soturon/" + self.req_dic["type_of_l"] + "/" + str_num + "/"
        file_name =  self.req_dic["type_of_l"] + "_" + str_num + "_" + number_in_cb + "/"
        req_name =  "req_" + self.req_dic["type_of_l"] + "_" + str_num + "_" + number_in_cb

        if not os.path.isdir(dir_path):
            os.mkdir(dir_path)

        if not os.path.isdir(dir_path + file_name):
            os.mkdir(dir_path + file_name)
        return dir_path + file_name + req_name


def test():
    make_l1_req()
    # make_l2_req()
    # make_l3_req()

def make_l1_req():
    reql1 = requirement("L1")
    print(reql1.make_requirement())

def make_l2_req():
    reql2 = requirement("L2")
    print(reql2.make_requirement())

def make_l3_req():
    reql3 = requirement("L3")
    print(reql3.make_requirement())

def main():
    # test()
    if len(sys.argv) == 1:
        test()
    elif sys.argv[1] == "L1":
        make_l1_req()
    elif sys.argv[1] == "L2":
        make_l2_req()
    elif sys.argv[1] == "L3":
        make_l3_req()
    else:
        print("usage : python make_seq/make_requirement_seq.py L[1-3]")


if __name__ == '__main__':
  main()
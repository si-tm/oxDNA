import random
import csv
import numpy as np
import sys
import pickle

# templateの場所を選択する logファイル作る
# results_soturon/L1, L2, L3
# path名決定

class requirement():
    def __init__(self, L, number_of_types, structures, sequence_of_domains):
        self.req_dic = {}
        self.req_dic["type_of_l"] = L
        self.req_dic["number_of_types"] = number_of_types
        for i in range(len(structures)):
            self.req_dic["s" + str(i)] = structures[0] + " @initial 1.0 M"
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
        # number_of_types, structures, sequence_of_domains
        number_of_types = self.random_number_of_types(L)
        structures = self.random_structures(L, number_of_types)
        

        self.req_dic = {}
        self.req_dic["type_of_l"] = L
        self.req_dic["number_of_types"] = number_of_types
        self.req_dic["structures"] = structures
       
        for i in range(len(structures)):
            self.req_dic["s" + str(i)] = structures[i] + " @initial 1.0 M"
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

    def random_structures(self, L, number_of_types):
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

    def make_requirement(self, path):
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

    # def file_name(self):
    #     # L1_str1_1
    #     self.req_dic["L"] + "_" + 
    


def test():
    make_l1_req()
    make_l2_req()
    make_l3_req()

def make_l1_req():
    reql1 = requirement("L1")
    reql1.make_requirement("results_soturon/L1/req_test.txt")

def make_l2_req():
    reql2 = requirement("L2")
    reql2.make_requirement("results_soturon/L2/req_test.txt")

def make_l3_req():
    reql3 = requirement("L3")
    reql3.make_requirement("results_soturon/L3/req_test.txt")

def main():
    test()

if __name__ == '__main__':
  main()
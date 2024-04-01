import random
import csv
import numpy as np
import sys
import pickle
sys.path.append("make_seq/")
import log_pkl as lp
import os
from datetime import datetime


# templateの場所を選択する logファイル作る
# results_soturon/L1, L2, L3
# path名決定

def pickle_load(path):
    with open(path, mode='rb') as f:
        data = pickle.load(f)
        return data

class requirement():
    def __init__(self, L, number_of_types="random", comb_of_domain="random", sequence_of_domains="random"):
        if L == "L1" or L == "L2" or L == "L3":
            self.L = L
        else:
            print('usage : requirement("L[1-3]")')

        if number_of_types != "random":
            self.number_of_types = number_of_types
        else:
            self.number_of_types = self.random_number_of_types(self.L)
        
        if comb_of_domain != "random":
            self.comb_of_domain = comb_of_domain
        else:
            self.comb_of_domain = self.random_comb_of_domain(self.L, self.number_of_types)

        if sequence_of_domains != "random":
            self.sequence_of_domains = sequence_of_domains
        else:
            self.sequence_of_domains = self.random_sequence_of_domain(L)

        self.req_dic = {}

    def make_req_dic(self):

        L = self.L
        number_of_types = self.number_of_types
        comb_of_domain = self.comb_of_domain
        sequence_of_domains = self.sequence_of_domains

        self.req_dic["type_of_l"] = L
        self.req_dic["number_of_types"] = number_of_types
        self.req_dic["comb_of_domain"] = self.comb_of_domain
        for i in range(len(comb_of_domain)):
            # self.req_dic["s" + str(i)] = comb_of_domain[0] + " @initial 1.0 M"
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
        
        for i in range(len(self.req_dic["domains"])):
            self.req_dic["domains " + self.req_dic["domains"][i]] = sequence_of_domains[i]
        
        # for r in self.req_dic:
        #     print(r, self.req_dic[r])

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
    
    def length_of_sequence(self, type_of_l):
        if type_of_l == "L1":
            return [10, 10]
        elif type_of_l == "L2":
            return [5, 5]
        elif type_of_l == "L3":
            return [17, 17, 17, 15, 17, 17]
        else:
            return []
        
    def random_sequence_of_domain(self, type_of_l):
        sequence_of_domains = []
        domain_length = self.length_of_sequence(type_of_l)
        # print(domain_length)

        for d in domain_length:
            sequence_of_domains.append(self.make_random_sequence(d))

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

    def dir_name(self):
        # results_soturon/L1/{str_num}/L1_{str_num}_{no.}/req_L1_{str_num}_{no.}
        comb_of_domain_dic = pickle_load("make_seq/structure_seq/seq_" + self.req_dic["type_of_l"] +".pkl")
        str_num = "d"
        str_num_lst = []
        # sort
        for cd in self.req_dic["comb_of_domain"]:
            str_num_lst.append(comb_of_domain_dic[cd])
        str_num_lst.sort()
        # print(str_num_lst)

        for snl in str_num_lst:
            str_num += "-" + str(snl)
        
        number_in_cb = str(lp.return_num(self.req_dic["type_of_l"], str_num))
        now = datetime.now()
        number_in_time = now.strftime("%Y-%m-%d-%H%M%S")


        dir_path = "results_soturon/" + self.req_dic["type_of_l"] + "/" + str_num + "/"
        # file_name =  self.req_dic["type_of_l"] + "_" + str_num + "_" + number_in_cb + "/"
        file_name =  self.req_dic["type_of_l"] + "_" + str_num + "_" + number_in_time + "/"
        # req_name =  "req_" + self.req_dic["type_of_l"] + "_" + str_num + "_" + number_in_cb
        req_name =  "req_" + self.req_dic["type_of_l"] + "_" + str_num + "_" + number_in_time

        if not os.path.isdir(dir_path):
            os.mkdir(dir_path)

        if not os.path.isdir(dir_path + file_name):
            os.mkdir(dir_path + file_name)
        return dir_path + file_name + req_name

def make_random_sequence(length):
        seq_lst = ['A', 'T', 'G', 'C']
        return "".join(random.choices(seq_lst, k=length))

def length_of_sequence(type_of_l):
    if type_of_l == "L1":
        return [10, 10]
    elif type_of_l == "L2":
        return [5, 5]
    elif type_of_l == "L3":
        return [17, 17, 17, 15, 17, 17]
    else:
        return []
    
def random_sequence_of_domain(type_of_l):
    sequence_of_domains = []
    domain_length = length_of_sequence(type_of_l)

    for d in domain_length:
        sequence_of_domains.append(make_random_sequence(d))

    return sequence_of_domains


def test():
    make_l1_req()
    # make_l2_req()
    # make_l3_req()

# fix strand [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1] 
def make_l1_req():
    reql1 = requirement("L1")
    print(reql1.make_requirement())

def make_l2_req():
    reql2 = requirement("L2")
    print(reql2.make_requirement())

def make_l3_req():
    reql3 = requirement("L3")
    print(reql3.make_requirement())

def make_random_req(type_of_l):
    type_of_l = "L1"
    sequence_of_domains = random_sequence_of_domain(type_of_l)
    print(sequence_of_domains)
    reql = requirement(L=type_of_l, sequence_of_domains=sequence_of_domains)
    reql.make_req_dic()
    reql.make_requirement()

def make_req(type_of_l, number_of_types, comb_of_domain, sequence_of_domains):
    reql = requirement(L=type_of_l, number_of_types=number_of_types, comb_of_domain=comb_of_domain, sequence_of_domains=sequence_of_domains)
    reql.make_req_dic()
    reql.make_requirement()

def main():
    # test()
    if len(sys.argv) == 1:
        test()
    elif sys.argv[1] == "L1_strandfixed":
        make_l1_req()
    elif sys.argv[1] == "L2_strandfixed":
        make_l2_req()
    elif sys.argv[1] == "L3_strandfixed":
        make_l3_req()
    else:
        print("usage : python make_seq/make_requirement_seq.py L[1-3]_strandfixed")

    # if len(sys.argv) == 2:
    #     test()
    # elif sys.argv[1] == "L1":
    #     make_req("L1")
    # elif sys.argv[1] == "L2":
    #     make_req("L2")
    # elif sys.argv[1] == "L3":
    #     make_req("L3")
    # else:
    #     print("usage : python make_seq/make_requirement_seq.py L[1-3] seq_path")


if __name__ == '__main__':
    main()
    # make_req(type_of_l="L1", number_of_types="2", comb_of_domain="b a b a*", sequence_of_domains=["GTTACTTGGA", "GGTTTTTTGC"])

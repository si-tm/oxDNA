import random
import csv
import numpy as np
import sys
import pickle
sys.path.append("make_seq/")
import log_pkl as lp
import os
from datetime import datetime
import make_requirement_seq as mrs

def sequences_of_domains(type_f_l):
    print(type_f_l)
    reql = mrs.requirement(type_f_l)
    sequence_of_domains = reql.random_sequence_of_domain(reql.req_dic["domains"], reql.req_dic)
    return sequence_of_domains

def main():
    if len(sys.argv) == 2:
        sequence_of_domains = sequences_of_domains(sys.argv[1])
        print(sequence_of_domains)
        return sequence_of_domains
    else:
        print("usage : python make_seq/make_sequence.py L[1-3]")


if __name__ == '__main__':
    main()

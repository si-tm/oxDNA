import sys
sys.path.append(".")
sys.path.append("./make_seq/")
from read_requirement import read_requirement 
from make_requirement_seq import requirement
import time


# 既存のd-*フォルダから、構造を変えず、domainsのみを変更してrequirementを作成する

def make_diff_req(path):
    # pathからdomainsを取り出す
    req = read_requirement(path)
    # 新しいreqを作成する
    for i in range(5):
        time.sleep(1)
        new_req = requirement(req.req_dic["type_of_l"], number_of_types=len(req.req_dic["structures"]), comb_of_domain=req.req_dic["comb_of_domain"], sequence_of_domains="random")
        new_req.make_req_dic()
        new_req.make_req_dic()
        new_req.make_requirement()

def test():
    path = "results_soturon/L1/d-0-1-6-9-11-13/L1_d-0-1-6-9-11-13_2023-01-29-163201/req_L1_d-0-1-6-9-11-13_2023-01-29-163201"
    make_diff_req(path)

# def main():
if __name__ == '__main__':
#   main()
    test()
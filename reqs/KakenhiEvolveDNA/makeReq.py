import csv
import os
import re
import sys


def main():
    structure = {
        "A" : [
            "s0 = a b @initial 1.0 M",
            "s1 = a b* @initial 1.0 M",
            "s3 = a* b @initial 1.0 M",
            "s4 = a* b* @initial 1.0 M",
            "s2 = a* a @initial 1.0 M"
        ],
        "B" : [
            "s0 = a b @initial 1.0 M",
            "s1 = b b @initial 1.0 M",
            "s2 = a* b* @initial 1.0 M",
            "s3 = b* a @initial 1.0 M",
            "s4 = b* a* @initial 1.0 M"
        ],
        "C" : [
            "s0 = a b @initial 1.0 M",
            "s1 = a* b* @initial 1.0 M"
        ],
        "D" : [
            "s0 = a b @initial 1.0 M",
            "s1 = a b* @initial 1.0 M",
            "s2 = b a @initial 1.0 M",
            "s3 = b b @initial 1.0 M",
            "s4 = b* a @initial 1.0 M"
        ],
        "E" : [
            "s1 = a b* b* b* @initial 1.0 M",
            "s0 = a a* b b @initial 1.0 M",
            "s2 = a* a b b @initial 1.0 M"
            ],
        "G" : [
            "s0 = a b a* b @initial 1.0 M",
            "s2 = b* a a a @initial 1.0 M",
            "s1 = a* b* b b* @initial 1.0 M",
            "s3 = b* b a* a @initial 1.0 M",
            "s4 = b* a* a a* @initial 1.0 M"
            ],
        "F" : [
            "s0 = b b b b* @initial 1.0 M",
            "s1 = b b a* a @initial 1.0 M",
            "s2 = b* b a a @initial 1.0 M",
            "s3 = b* b* a* b* @initial 1.0 M"
            ],
        "H" : [
            "s2 = a b* a b* @initial 1.0 M",
            "s4 = b a b b @initial 1.0 M",
            "s0 = a a* b* b @initial 1.0 M"
            ]
    }

    seq = {
        "L1" : [
            "a",
            "b"
        ],
        "L2" : [
            "a",
            "b"
        ],
        "L3" : [
            "a",
            "b",
            "c",
            "d",
            "e",
            "f"
        ]

    }

    if len(sys.argv) != 3:
        print("usage : python3 makeReq.py <uppercase alphabet> <type of l>")
        return
    # sequence of domains

    target_type = sys.argv[1]
    type_of_l = sys.argv[2]

    filename = f"{target_type}/seq{target_type}.csv"
        
    # structure
    structure_lst = structure[target_type]
    
    seq_lst = seq[type_of_l]

    print(seq_lst)
            
    # CSVファイルを辞書型で読み取ります
    with open(filename, newline='') as csvfile:
        csvreader = csv.DictReader(csvfile)
        
        for row in csvreader:
            # 各行がディクショナリとして読み込まれます
            target = row["file_name"]
            dates_and_times = re.findall(r'final_(\d{14})\.p', target)

            try:
                os.mkdir(f"{target_type}/r{dates_and_times[0]}")
            except:
                print(f"{target_type}/r{dates_and_times[0]}は存在しています")
            filename = f"{target_type}/r{dates_and_times[0]}/req_r{dates_and_times[0]}.txt"
            print(filename)

            with open(filename, 'w') as file:
                with open(f"template_seq/requirement_{type_of_l}.txt", 'r') as temp:
                    is_written_structure = False
                    is_written_seq = False
                    for l in temp:
                        if l[0] == "s":
                            if not is_written_structure:
                                for structure in structure_lst:
                                    file.write(f"{structure}\n")
                                is_written_structure = True
                            continue
                        if l[0] == "d":
                            if not is_written_seq:
                                # domain a = GTTCCAGCACCTTCACT
                                for seq in seq_lst:
                                    file.write(f"domain {seq} = {row[seq]}\n")
                                is_written_seq = True
                            continue
                        file.write(l)


    

if __name__ == '__main__':
    main()
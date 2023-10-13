import csv
import os
import re
import shutil

def main():
    # sequence of domains

    filename = "seqJ.csv"
        
    # structure
    """
    s0 = a b a @initial 1.0 M
    s1 = c e* a @initial 1.0 M
    s2 = a* c* f @initial 1.0 M
    s3 = c* c e @initial 1.0 M
    s4 = f* e* f @initial 1.0 M
    """
    structure_lst = [
        "s0 = a b a @initial 1.0 M",
        "s1 = c e* a @initial 1.0 M",
        "s2 = a* c* f @initial 1.0 M",
        "s3 = c* c e @initial 1.0 M",
        "s4 = f* e* f @initial 1.0 M"
        ]
    
    seq_lst = [
        "a",
        "b",
        "c",
        "d",
        "e",
        "f"
    ]
            
    # CSVファイルを辞書型で読み取ります
    with open(filename, newline='') as csvfile:
        csvreader = csv.DictReader(csvfile)
        
        for row in csvreader:
            # 各行がディクショナリとして読み込まれます
            target = row["file_name"]
            dates_and_times = re.findall(r'final_(\d{14})\.p', target)

            try:
                os.mkdir(f"r{dates_and_times[0]}")
            except:
                print(f"r{dates_and_times[0]}は存在しています")
            filename = f"r{dates_and_times[0]}/req_r{dates_and_times[0]}.txt"
            print(filename)

            with open(filename, 'w') as file:
                with open("../template_seq/requirement_L3.txt", 'r') as temp:
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
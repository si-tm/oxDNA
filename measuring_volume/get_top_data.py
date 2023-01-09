import numpy as np
import matplotlib.pylab as plt
import sys
sys.path.append("../common")
import get_target_file as gtf

def make_initial_strands_data(target_dir):
    # particle2strands[particle_id] = strand_id
    particle2strand = {} 
    # strands2particle[strand_id] = {particle_ids}
    strands2particle = {} 
    top_f = open(gtf.get_top(target_dir))

    col = 0
    particle_id = 0
    initial_strand_num = -1

    for l in top_f:
        if col == 0:
            initial_strand_num = int(l.split(" ")[-1].rstrip('\n'))
        else:
            strand_id = int(l.split(" ")[0])
            if strand_id in strands2particle:
                strands2particle[strand_id].add(particle_id)
            else:
                strands2particle[strand_id] = {particle_id}
            particle2strand[particle_id] = strand_id
            particle_id += 1
        col += 1
    
    print(initial_strand_num)
    top_f.close()
    return strands2particle, particle2strand



def main():
    target_dir = "../results_KakenhiEvolveDNA/seqA/A4/test_a4_200000_1"
    print(make_initial_strands_data(target_dir))

if __name__ == '__main__':
  main()
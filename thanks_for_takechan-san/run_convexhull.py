import scipy
from scipy.spatial import ConvexHull, convex_hull_plot_2d
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import vista_func as vf
import importlib
import sys
sys.path.append("../common")
import get_target_file as gtf
importlib.reload(vf)

def convexhull_volume(connection_data, target, output_dir):
    
    points = vf.make_position_data_ndarray(connection_data)
    #display(points)
    hull = ConvexHull(points)
    x = np.array(points[:, 0])
    y = np.array(points[:, 1])
    z = np.array(points[:, 2])
    fig = plt.figure()
    ax = Axes3D(fig) 
    ax.scatter(x, y, z, color="#aa0000")
    
    ax.set_xlabel("a-value")
    ax.set_ylabel("b-value")
    ax.set_zlabel("L-value")
    
    figfilename = output_dir + "/" + target + ".png"
    for simplex in hull.simplices:

        ax.plot(points[simplex, 0], points[simplex, 1], points[simplex, 2], "o-", color="#00aa00", ms=4, mew=0.5)
    fig.savefig(figfilename)
    return hull.volume

def get_bonds_data(filename):
    output_bonds_data = pd.read_csv(
        filename,
        sep = " ",
        names = ["id1","id2","FENE","BEXC","STCK","NEXC","HB","CRSTCK","CXSTCK","total","1","2","3"]
    ).iloc[2:,:10]
    output_bonds_data = output_bonds_data[:-1].astype("float").astype({"id1" : "int", "id2" : "int"})
    
    return output_bonds_data

# from run_output_bonds_func.py
def create_connection_data(target, output_dir, output_bonds_data):
    lastconf_data = gtf.get_conf(target)
    topology_data = gtf.get_top(target)
    topology_data, expected_num_strands = get_topology_data(output_dir, target)
    newdata1 = pd.concat([topology_data, lastconf_data], axis = 1)
    newdata = get_top_pos_data(newdata1, output_bonds_data)
    data = add_id2_strand(newdata, topology_data)#何か発生？
    connected_data, actual_num_strands = get_connected_strands_data(data)#e77error
    return connected_data, expected_num_strands, actual_num_strands


def main():
    target_dir = "../results_KakenhiEvolveDNA/seqA/A4/test_a4_200000_1"
    bonds_data = open(target_dir + "/bonds", "r")
    target = "e0"
    output_dir = "../test_convexhull"
    output_bonds_data = get_bonds_data(bonds_data)

    print(output_bonds_data)
    gtf.get_top(target_dir)
    # print(convexhull_volume(connection_data, target, output_dir))

if __name__ == '__main__':
  main()
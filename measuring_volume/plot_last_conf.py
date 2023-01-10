import numpy as np
import matplotlib.pylab as plt
import sys
sys.path.append("../common")
import get_target_file as gtf
from mpl_toolkits.mplot3d import Axes3D
import get_top_data as gtd
from scipy.spatial import ConvexHull

def get_all_r(target_dir):
    conf_name = gtf.get_conf(target_dir)
    conf_f = open(conf_name, "r")
    col = 0

    # 4行目からrを読み込む
    x = []
    y = []
    z = []
    for l in conf_f:
        col += 1
        if col > 3:
            rx = float(l.split(" ")[0])
            ry = float(l.split(" ")[1])
            rz = float(l.split(" ")[2])
            x.append(rx)
            y.append(ry)
            z.append(rz)

    conf_f.close()
    return x, y, z

def get_r(target_dir, strands):
    print(strands[1])
    target_strands = strands[1]
    conf_name = gtf.get_conf(target_dir)
    conf_f = open(conf_name, "r")
    line = -3

    # 4行目からrを読み込む
    x = []
    y = []
    z = []
    for l in conf_f:
        line += 1
        if line > 0 and ((line - 1) in target_strands):
            rx = float(l.split(" ")[0])
            ry = float(l.split(" ")[1])
            rz = float(l.split(" ")[2])
            x.append(rx)
            y.append(ry)
            z.append(rz)
        

    conf_f.close()
    return x, y, z

def convexhull_volume(x, y, z):
    points = []
    print(len(x))
    for i in range(len(x)):
        lst = [x[i], y[i], z[i]]
        points.append(lst)
    print(points)
    hull = ConvexHull(points)
    print(hull.volume)
    

def plot(X, Y, Z, target_dir):
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    ax.scatter(X, Y, Z)
    plt.show()

def main():
    target_dir = "../results_KakenhiEvolveDNA/seqA/A4/test_a4_200000_1"
    # x, y, z = get_all_r(target_dir)
    # plot(x, y, z, target_dir)
    
    strands2particle, particle2strand = gtd.make_initial_strands_data(target_dir)
    strands2particle, particle2strand = gtd.get_connection_strands(gtf.get_bonds(target_dir), strands2particle, particle2strand)
    x, y, z = get_r(target_dir, strands2particle)
    convexhull_volume(x, y, z)
    plot(x, y, z, target_dir)


if __name__ == '__main__':
  main()
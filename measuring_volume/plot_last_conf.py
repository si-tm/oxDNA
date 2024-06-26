import numpy as np
import matplotlib.pylab as plt
import sys
sys.path.append("../common")
import get_target_file as gtf
from mpl_toolkits.mplot3d import Axes3D
import get_top_data as gtd
import get_conf_data as gcd
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

    target_strands = list(strands)
    conf_dic = gcd.get_conf_data(target_dir)

    # 4行目からrを読み込む
    x = []
    y = []
    z = []

    for particle_id in target_strands:
        x.append(conf_dic[particle_id]["rx"])
        y.append(conf_dic[particle_id]["ry"])
        z.append(conf_dic[particle_id]["rz"])
    
    return x, y, z

def convexhull_volume(x, y, z):
    points = []
    for i in range(len(x)):
        lst = [x[i], y[i], z[i]]
        points.append(lst)
    hull = ConvexHull(points)

    return hull.volume
    
def plot(X, Y, Z, target_dir):
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    ax.scatter(X, Y, Z)
    plt.show()

def convexhull_volume_all_strands(target_dir):
    strands2particle, particle2strand = gtd.get_particle_strands_data(target_dir)

    volumes = {}

    for strand in strands2particle:
        x, y, z = get_r(target_dir, strands2particle[strand])
        volumes[strand] = convexhull_volume(x, y, z)
        plot(x, y, z, target_dir)
    
    mean_volume = 0.0
    num_of_strands = float(len(strands2particle))

    for strand in volumes:
        mean_volume += volumes[strand]
    
    mean_volume /= num_of_strands
    print(target_dir + " : mean volume is " + str(mean_volume))
    # strands num

    return mean_volume
    
def main():
    target_dir = "../results_KakenhiEvolveDNA/seqA/A4/test_a4_200000_1"
    convexhull_volume_all_strands(target_dir)


if __name__ == '__main__':
  main()
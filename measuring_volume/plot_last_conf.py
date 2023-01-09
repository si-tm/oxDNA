import numpy as np
import matplotlib.pylab as plt
import sys
sys.path.append("../common")
import get_target_file as gtf
from mpl_toolkits.mplot3d import Axes3D

def get_r(target_dir):
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

def plot(X, Y, Z, target_dir):
    print(len(X))
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    ax.scatter(X, Y, Z)
    plt.show()


def main():
    target_dir = "../results_KakenhiEvolveDNA/seqA/A4/test_a4_200000_1"
    x, y, z = get_r(target_dir)
    plot(x, y, z, target_dir)

if __name__ == '__main__':
  main()
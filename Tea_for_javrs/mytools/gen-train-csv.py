import os
import csv
import random
data_dir =r"E:\tea-action-recognition-master\val"

labels = os.listdir(data_dir)

v_r = []
for label in labels:
    videos = os.listdir(os.path.join(data_dir,label))

    for video in videos:
        v_r.append([video[0:-4]+';'+"action_"+label])
    #v_r.append([label[0:-4]])
random.shuffle(v_r)

with open ("my-dataset-val.csv", "w", newline='') as f:
    f_csv = csv.writer(f)
    f_csv.writerows(v_r)
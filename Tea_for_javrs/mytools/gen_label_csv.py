import os
import csv
data_dir =r"E:\tea-action-recognition-master\train"

labels = os.listdir(data_dir)
#print(labels)

add = "action_"
new_labels=[]
for l in labels:
    new_labels.append([add+l])
with open ("my-dataset-labels.csv", "w", newline='') as f:
    f_csv = csv.writer(f)
    f_csv.writerows(new_labels)
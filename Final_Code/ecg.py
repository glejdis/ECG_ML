import wfdb
import os
import csv
import json
mit_dir='../mit-bih-arrhythmia-database-1.0.0/'
data_dir='../arrhythmia/'
ff=os.listdir(mit_dir)
files=[f[:-4] for f in ff if f[-3:]== 'dat']
#print(files)

def annotations(files):
    for f in files:
        with open(data_dir+f+'a.csv', 'w', newline='') as wf:
            writer = csv.writer(wf)
            ann = wfdb.rdann(mit_dir+f, 'atr')
            ll=[[a,b] for (a,b) in zip(ann.sample,ann.symbol)]  
            writer.writerows(ll)

def full_records(files):
    for f in files:
        with open(data_dir+f+'.csv', 'w', newline='') as wf:
            writer = csv.writer(wf)
            record = wfdb.rdsamp(mit_dir+f)
            writer.writerows(record[0])

annotations(files)
full_records(files)

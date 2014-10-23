# -*- coding:utf-8 -*-

import csv
import io
import json
from os import path
from sys import argv

def writerow(fd, row):
    line = ';'.join(row)
    #fd.write(unicode(line+"\n", encoding='utf-8'))
    fd.write(line+"\n")

if len(argv) < 2:
    print "usage: python csv_to_json.py [input csv file]"
    exit(0)

infile = argv[1]
name, ext = path.splitext(infile)
outfile = name + ".json"
with io.open(infile, mode='r', encoding='utf-8') as fd2:
    
    #fdout = io.open('TPEPOP_urp_spreadsheet.csv', mode='w', encoding='utf-8', errors='ignore')
    fdout = open(outfile, 'w')
    count = 0
    
    fdout.write('[\n')
    for line in fd2.readlines():
        r = line.strip().split(',')
        if len(r)<3: continue
        
        sec = r[0].strip()
        num = r[1].strip()
        data = ','.join(r[2:])

        if data=='': continue
        item = json.loads(data)
        item["section"] = sec
        item["number"] = num
        
        res = json.dumps(item, ensure_ascii=False).encode('utf-8')
        #print res
        fdout.write(res+',\n')    
    
    fdout.write(']\n')


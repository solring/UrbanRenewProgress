import requests
import io
from urllib import quote
from time import sleep
from sys import argv

if __name__=='__main__':

    offset = 1
    if len(argv) > 1:
        offset = int(argv[1])
        print "start from %d" % offset
    
    with open('TPE_public_land.csv', 'r') as fd:
        lines = fd.readlines()[offset:]
        fd.close()
        
        fdout = io.open('TPE_public_land_renew.csv', mode="w", encoding="utf8")
        
        for line in lines:
            cols = line.strip().split(',')
            sec = cols[3].decode('utf8')
            id = cols[4]
            url = "http://urban-renew-progress.herokuapp.com/bySec/%s/%s/%s" % ( quote(sec.encode('utf8')), id[:4], id[4:] )
            print url
            
            res = requests.get(url)
            msg = res.text
            print msg
            print "\n-----\n"
            
            fdout.write("%s, %s, %s\n" %(sec, id, msg))
            
            sleep(5)
        
        fdout.close()
            
            
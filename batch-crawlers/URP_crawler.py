#============================================
# Offline crawler through URP API on Heroku
# Solring Lin 2014/09/27
#============================================
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
        print 'read TPE_public_land.csv'
        lines = fd.readlines()[offset:]
        print "number of cases: %d" % len(lines)

        fd.close()
        
        fdout = io.open('TPE_public_land_renew.csv', mode="w", encoding="utf8")
        
        for line in lines:
            cols = line.strip().split(',')
            
            # Get section string & land number
            sec = cols[3].decode('utf8')
            num = cols[4]
            if len(num) < 8: num = '0'*(8-len(num)) + num

            # Send requests
            url = "http://urban-renew-progress.herokuapp.com/bySec/%s/%s/%s" % ( quote(sec.encode('utf8')), num[:4], num[4:] )
            print url
            
            res = requests.get(url)
            msg = res.text
            print msg
            print "\n-----\n"
            
            fdout.write("%s, %s, %s\n" %(sec, id, msg))
            
            sleep(3)
        
        fdout.close()
            
            

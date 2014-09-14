UrbanRenewProgress
=================
  API and crawler for http://www.gis.udd.taipei.gov.tw/r_progress.aspx<br/>
  Returns query results in json format

APIs 
------------------
  http://urban-renew-progress.herokuapp.com/bySec/[section name]/[major #]/[minor #] <br />
  http://urban-renew-progress.herokuapp.com/bySec/[section name]/[merged #] <br />
  http://urban-renew-progress.herokuapp.com/byArea/[dist name]/[section name]/[major #]/[minor #] <br />
  http://urban-renew-progress.herokuapp.com/byArea/[dist name]/[section name]/[merged #] <br />

Result Format
------------------
### JSON
    {
        "msg" : result description
        "cases" :
        [
          {
            "query" : query
            "id" : official case id
            "name" : description
            "status" : status of renew application
          },
          ...
        ]
    }


//in construction

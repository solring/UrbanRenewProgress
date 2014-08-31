UrbanRenewProgress
=================
  API and crawler for http://www.gis.udd.taipei.gov.tw/r_progress.aspx
  Returns query results in json format

APIs 
------------------
  http://urban-renew-progress.herokuapp.com/bySec/[section name]/[major #]/[minor #]
  http://urban-renew-progress.herokuapp.com/bySec/[section name]/[merged #]
  http://urban-renew-progress.herokuapp.com/byArea/[dist name]/[section name]/[major #]/[minor #]
  http://urban-renew-progress.herokuapp.com/byArea/[dist name]/[section name]/[merged #]

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

UrbanRenewProgress
=================
  **NOTE: The official data source is currently down!**
  
  ***New data source*** <br />
  http://data.taipei/opendata/datalist/datasetMeta?oid=560b633f-4ca7-4e37-957a-53879eccf5ea
  
  Realtime API and crawler for http://www.gis.udd.taipei.gov.tw/r_progress.aspx<br/>
  Returns query results in json format
 
  license: CC BY

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
        "section": section name of the land
        "number" :  full land number of the land
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


Data on Google fusiontable
------------------
https://www.google.com/fusiontables/DataSource?docid=13ojWugFOcdvgs8vReoQTXM6Ux5IiJkmAdwqKHqjQ#rows:id=1



Todo
------------------
  - Build from Database to improve performance (note: currently data are retrieved everytime after receiving a query)
  - Daily update of database

#!/bin/bash
# USER=jennifer.fu
# RELEASE=12.1.0.2
# BUNDLE=22646084
 curl -k -X POST -H 'Content-Type: application/json' -d '{
"userName":"jennifer.fu",
"userEmailId":"jennifer.fu@oracle.com",
"baseReleaseVersion":"12.2.0.2",
"isCreateGridGoldImage":"true",
"isCreateDBGoldImage":"true",
"dbOneOffPatches":"",
"dbPSU":"",
"goldImageArchiveFormat":"zip",
"isIgnoreConflictCheck":"true"

}' http://db-goldimage.us.oracle.com:8080/goldimages/jobs  |awk -F "," '{print $1}'|awk -F ":" '{print $2}'



# curl -X GET -H 'Content-Type: application/json'  http://db-goldimage.us.oracle.com:8080/goldimages/jobs --output "test.log" 2> /dev/null > "test.log"

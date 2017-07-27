#!/bin/bash

if [ `id -u` != "0" ]; then
echo "please use root "
exit 1
fi
#require user_name, zip_loc, oracle_home.
#echo -n "enter the grid home : 'ORACLE_HOME'"
#read ORACLE_HOME


#echo -n "enter the db  home : 'DB_HOME'"
#read DB_HOME


#echo -n "enter the user name : 'USER'"
#read  USER

echo -n "enter the zip location: 'ZIP_LOC'"
read ZIP_LOC
ORACLE_HOME=/u01/app/grid
DB_HOME=/u01/app/dbhome

 USER=jennifer.fu
 RELEASE=12.2.0.2
 EMAIL=${USER}@oracle.com
 echo $EMAIL
# BUNDLE=22646084
#JOBID=`curl -k -X POST -H 'Content-Type: application/json' -d '{ "userName":"'"$USER"'", "userEmailId":"'"$EMAIL"'", "baseReleaseVersion":"'"$RELEASE"'", "isCreateGridGoldImage":"true", "isCreateDBGoldImage":"true", "dbOneOffPatches":"", "dbPSU":"", "goldImageArchiveFormat":"zip", "isIgnoreConflictCheck":"true"  }' http://db-goldimage.us.oracle.com:8080/goldimages/jobs |awk -F "," '{print $1}'|awk -F ":" '{print $2}'|sed 's/\"//g'`
#JOBID=8005
#echo $JOBID

cd $ZIP_LOC/install/shiphome/goldimage



mkdir -p $ORACLE_HOME
mkdir -p $DB_HOME
rm -rf $ORACLE_HOME
rm -rf $DB_HOME

chown -R grid:orainstall $ORACLE_HOME
chown -R grid:orainstall $DB_HOME

unzip grid_home.zip -d $ORACLE_HOME
unzip db_home.zip -d $DB_HOME





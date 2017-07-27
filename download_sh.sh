#!/bin/bash
echo -n "enter the shiphome location : 'LOC'"
read LOC

cd $LOC/install/shiphome/goldimage
su - grid -c "unzip grid_home.zip -d /u01/app/grid"
su - rac -c "unzip db_home.zip -d /u02/app/dbhome"

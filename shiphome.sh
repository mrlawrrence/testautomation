#!/bin/bash
rm -rf /u01/app/grid
rm -rf /scratch/installFiles/db
cd install/shiphome/
unzip goldimage/grid_home.zip -d /u01/app/grid
unzip database.zip -d /scratch/installFiles/db




echo 'shiphome unzip done.' | mail -s "DONE!"  jennifer.fu@oracle.com   

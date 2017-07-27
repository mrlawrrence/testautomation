#!/bin/bash
if [ `id -u` != "0" ]; then
echo "please use root "
exit 1

fi
rm -rf /etc/ora*
rm -rf /u01/app/
rm -rf /scratch/installFiles/db
mkdir -p /u01/app/grid
mkdir -p /u01/app/crsusr
chown -R crsusr:oinstall /u01/app

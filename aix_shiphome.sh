#!/bin/bash
if [ `id -u` != "0" ]; then
echo "please use root "
exit 1

fi

aix_loc=/net/slcnas441/export/ifarm_ports/aix/wrk
cd $aix_loc
label=`ls -rl |grep "HAS_12.2.0.1.0_AIX"|sed -n 1p|awk -F " " '{print $9}'`

if [ ! -f $label/regress_dos/ship/database.zip ];
then

label=`ls -rl |grep "HAS_12.2.0.1.0_AIX"|sed -n 3p|awk -F " " '{print $9}'`

fi
label=HAS_12.2.0.1.0_AIX.PPC64_170223
echo $label | tee /scratch/installFiles/aix/label.txt

ship_loc=$aix_loc/${label}/regress_dos/ship
unzip $ship_loc/goldimage/grid_home.zip -d /scratch/installFiles/aix/grid
unzip $ship_loc/database.zip -d /scratch/installFiles/aix/db
echo ibm|scp -r /scratch/installFiles/aix rwsbr13:/ee/installFiles

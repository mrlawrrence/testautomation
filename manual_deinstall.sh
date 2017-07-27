#!/bin/bash

if [ `id -u` != "0" ]; then
echo "please use root "
exit 1

fi
#on linux, remove config files.
#require oracle_home, oracle_base, oracle_orainentory.
#echo -n "enter the oracle home : 'ORACLE_HOME'"
#read ORACLE_HOME

#echo -n "enter the oracle base : 'ORACLE_BASE'"
#read  ORACLE_BASE

#echo -n "enter the oracle inventory: 'ORACLE_INVENTORY'"
#read ORACLE_INVENTORY

#su - grid -c "$ORACLE_HOME/deinstall/deinstall"


ORACLE_HOME=/u01/app/grid
ORACLE_BASE=/u01/app/base
ORACLE_INVENTORY=/u01/app/oraInventory
#$ORACLE_HOME/crs/install/rootcrs.sh -deconfig -force -lastnode

rm -rf /etc/*/*has* /etc/*/*/*has*
rm -rf /etc/oracle /etc/oraInst.loc /etc/oratab
rm -rf /etc/inittab.crs  /etc/inittab.no*
rm -rf /tmp/CVU*
rm -rf /usr/local/bin/coraenv /usr/local/bin/dbhome /usr/local/bin/oraenv
rm -rf /var/tmp/.oracle /usr/tmp/.oracle /tmp/.oracle /tmp/OraInstall*
rm -rf /opt/oracle /etc/inittab.pre* /etc/rc*.d/*init.crs /var/opt/oracle /home/oracle/.oracle
rm -rf /etc/init.d/*ohasd*
rm -rf /etc/init.d/init.*
/scratch/grid/clean_disks.sh


rm -rf $ORACLE_HOME
mkdir -p  $ORACLE_HOME
rm -rf $ORACLE_BASE
mkdir -p $ORACLE_BASE
rm -rf $ORACLE_INVENTORY
mkdir -p $ORACLE_INVENTORY

#create required user and groups.
#create required user and groups.
GI_USER=grid
RAC_USER=rac

 groupadd -g 54322 asmdba
 groupadd -g 54323 oper

if id -u $GI_USER >/dev/null 2>&1; then
        echo "user exists"
else
        echo "user does not exist, then create it "
        useradd -u 10000 -g orainstall -G dba,asmadmin,oper -d /scratch/grid -m -s /usr/bin/bash grid
fi

if id -u $RAC_USER >/dev/null 2>&1; then
        echo "user exists"
else
        echo "user does not exist, then create it "
        useradd -u 10001 -g orainstall -G dba,oper -d /scratch/rac -m -s /usr/bin/bash rac

fi
chown -R $GI_USER:orainstall $ORACLE_BASE/../

#echo "the env is prepared " | mail -s "DONE!"  jennifer.fu@oracle.com

#ssh rws3010159 /scratch/grid/tools/deinstall.sh
#ssh rws3010161 /scratch/grid/tools/deinstall.sh
#ssh rws3010160 /scratch/grid/tools/deinstall.sh

#reboot

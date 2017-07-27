#!/bin/bash
if [ `id -u` != "0" ]; then
echo "please use root "
exit 1
fi

src_file=/scratch/repository/aix/26133434
dsc=/ee

#echo -n "enter the grid home : 'ORACLE_HOME'"
#read ORACLE_HOME
#
#echo -n "enter the node_list : 'nodelist_string'"
#read nodelist_string
#
#
#node_list=(rwsbr15.us.oracle.com  rwsbr16.us.oracle.com)

#ORACLE_HOME=/ee/db/12201db_3

local_node=`hostname`

INV_LOC=`cat /etc/oraInst.loc |grep inventory|cut -d "=" -f 2`;
ORACLE_HOME=`cat $INV_LOC/ContentsXML/inventory.xml |grep OraGI12Home1 |cut -d " " -f 3|cut -d "\"" -f 2`;
IFS_old=$IFS;
IFS=$'\n';
node_list=`$ORACLE_HOME/bin/olsnodes`


#ORACLE_HOME=`cat $INV_LOC/ContentsXML/inventory.xml |grep "OraDB12Home1" |grep -v grid|cut -d " " -f 3|cut -d "\"" -f 2`; 

expect -c "
spawn scp -r rwsah15.us.oracle.com:$src_file $dsc
expect {
\"*assword\" {set timeout 300; send \"welcome1\r\";}
\"yes/no\" {send \"yes\r\"; exp_continue;}
}
expect eof"

expect -c "
spawn scp -r rwsah15.us.oracle.com:/scratch/repository/aix/p6880880/OPatch $ORACLE_HOME
expect {
\"*assword\" {set timeout 300; send \"welcome1\r\";}
\"yes/no\" {send \"yes\r\"; exp_continue;}
}
expect eof"


for node in ${node_list[@]}
do
	
expect -c "
spawn scp -r $dsc/26133434 ${node}.us.oracle.com:$dsc
expect {
\"*assword\" {set timeout 300; send \"ibm\r\";}
\"yes/no\" {send \"yes\r\"; exp_continue;}
}
expect eof"


expect -c "
spawn scp -r $ORACLE_HOME/OPatch ${node}.us.oracle.com:$ORACLE_HOME
expect {
\"*assword\" {set timeout 300; send \"ibm\r\";}
\"yes/no\" {send \"yes\r\"; exp_continue;}
}
expect eof"

expect -c "
spawn ssh ${node}.us.oracle.com \" $ORACLE_HOME/OPatch/opatchauto apply /ee/26133434/ ;\"
expect {
\"*assword\" {set timeout 300; send \"ibm\r\";}
\"yes/no\" {send \"yes\r\"; exp_continue;}
}
expect eof"

done

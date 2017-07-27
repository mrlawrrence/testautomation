#!/bin/sh

ORACLE_BASE=/u01/app/crsusr
ORACLE_HOME=/u01/app/122dbhome
cd $ORACLE_HOME/clone
THISNODE=`hostname -s`

E01=ORACLE_HOME=/u01/app/122dbhome
E02=ORACLE_HOME_NAME=OraDBRAC1
E03=ORACLE_BASE=/u01/app/crsusr

E04=OSDBA_GROUP=oinstall
E05=OSOPER_GROUP=oinstall
E06=OSASM_GROUP=oinstall
E07=OSBACKUPDBA_GROUP=oinstall
E08=OSDGDBA_GROUP=oinstall
E09=OSKMDBA_GROUP=oinstall
E10=OSRACDBA_GROUP=oinstall

#C01="-O CLUSTER_NODES={rws3010158}"
#C02="-O LOCAL_NODE=$THISNODE"

perl $ORACLE_HOME/clone/bin/clone.pl $E01 $E02 $E03 $E04 $E05 $E06 $E07 $E08 $E09 $E10 

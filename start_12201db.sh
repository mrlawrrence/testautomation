#!/bin/sh

ORACLE_BASE=/scratch/u01/app/crsusr
ORACLE_HOME=/scratch/u01/app/db
cd $ORACLE_HOME/clone
THISNODE=`hostname -s`

E01=ORACLE_HOME=/scratch/u01/app/db
E02=ORACLE_HOME_NAME=OraDBRAC
E03=ORACLE_BASE=/scratch/u01/app/crsusr

E04=OSDBA_GROUP=oinstall
E05=OSOPER_GROUP=oinstall
E06=OSASM_GROUP=oinstall
E07=OSBACKUPDBA_GROUP=oinstall
E08=OSDGDBA_GROUP=oinstall
E09=OSKMDBA_GROUP=oinstall

C01="-O CLUSTER_NODES={rwsah13,rwsah15}"
C02="-O LOCAL_NODE=$THISNODE"

perl $ORACLE_HOME/clone/bin/clone.pl $E01 $E02 $E03 $E04 $E05 $E06 $E07 $E08 $E09 $C01 $C02

#!/bin/sh

ORACLE_BASE=/u02/app/base
ORACLE_HOME=/u02/app/db11204
cd $ORACLE_HOME/clone
THISNODE=`hostname -s`

E01=ORACLE_HOME=/u02/app/db11204
E02=ORACLE_HOME_NAME=OraDB11204
E03=ORACLE_BASE=/u02/app/base

E04=OSDBA_GROUP=orainstall
E05=OSOPER_GROUP=orainstall
E06=OSASM_GROUP=orainstall
E07=OSBACKUPDBA_GROUP=orainstall
E08=OSDGDBA_GROUP=orainstall
E09=OSKMDBA_GROUP=orainstall

C01="-O CLUSTER_NODES={rws00fzq,rws00fzr}"
C02="-O LOCAL_NODE=$THISNODE"

perl $ORACLE_HOME/clone/bin/clone.pl $E01 $E02 $E03 $E04 $E05 $E06 $E07 $E08 $E09 $C01 $C02

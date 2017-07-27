#!/bin/bash

su - crsusr -c "/u01/app/grid/gridSetup.sh -responseFile /scratch/crsusr/add_20170420.rsp -debug -silent -skipPrereqs"

ssh rws3010160 /u01/app/grid/root.sh
ssh rws3010160 /u01/app/oraInventory/orainstRoot.sh
ssh rws3010161 /u01/app/oraInventory/orainstRoot.sh
ssh rws3010161 /u01/app/grid/root.sh

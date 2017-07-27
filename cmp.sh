#!/bin/bash
echo welcome1|scp rwsah15:/scratch/installFiles/db12201.zip /tmp/
echo welcome1|scp rwsah15:/scratch/installFiles/db12102.zip /tmp/
echo welcome1|scp rwsah15:/scratch/installFiles/db11204.zip /tmp/
 mkdir -p /u02/app
unzip /tmp/db12201.zip -d /u02/app/db12201
unzip /tmp/db12102.zip -d /u02/app/db12102
unzip /tmp/db11204.zip -d /u02/app/db11204

chown -R grid:orainstall /u02/app

ssh rws00fzr mkdir -p /u02/app


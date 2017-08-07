import shutit
import time
import getpass



start = time.time()

bugnum = raw_input('bug number : ')
print bugnum
host = raw_input('host to collect : ')
print host
root_pwd = getpass.getpass('host root password: ')
bugdbuser = raw_input('bugdb user: ')
print bugdbuser
bugdbpwd = getpass.getpass('bugdb password: ')


getgihome_cmd = """INV_LOC=`cat /etc/oraInst.loc |grep inventory|cut -d "=" -f 2`;export ORACLE_HOME=`cat $INV_LOC/ContentsXML/inventory.xml |grep OraGI12Home1 |cut -d " " -f 3|cut -d "\\"" -f 2`;echo $ORACLE_HOME"""
getoraclebase_cmd = """export ORACLE_BASE=`$ORACLE_HOME/bin/orabase`;echo $ORACLE_BASE"""
getlogs_cmd = """$ORACLE_HOME/bin/tfactl diagcollect"""


#cluster_node = shutit.create_session('bash', loglevel='DEBUG')
cluster_node = shutit.create_session('bash')


# host = cluster_node.get_input('please input host: ', ispass=False)
# root_pwd = cluster_node.get_input('please input root password for cluster node', ispass=True)
# bugdbuser = cluster_node.get_input('please input bugdb user ', ispass=False)
# bugdbpwd = cluster_node.get_input('please input bugdb user password ', ispass=True)

cluster_node.login('ssh root@{host}.us.oracle.com'.format(host=host), user='root', password=root_pwd)

# cluster_node.login('ssh root@rwsae05', user='root', password=root_pwd)
oraclehome=cluster_node.send_and_get_output(getgihome_cmd,echo=True)
print(oraclehome)
oraclebase = cluster_node.send_and_get_output(getoraclebase_cmd,echo=True)
print(oraclebase)
gettfaname_cmd = """cd $ORACLE_BASE/tfa/repository;ls -tral|grep collection|head -n 1|cut -d ":" -f 2|cut -d " " -f 2;"""

cluster_node.send(getlogs_cmd, expect='Logs are being collected')

logdir = cluster_node.send_and_get_output(gettfaname_cmd)
print(logdir)
tar_cmd = """tar -czvf {logdir}.tar.gz {logdir}""".format(
    logdir=logdir)

cluster_node.send(tar_cmd)

# print(cluster_node.send_and_get_output('pwd',echo=True))
cluster_node.send('sftp {bugdbuser}@oracle.com@bugsftp'.format(bugdbuser=bugdbuser),
                  echo=True, expect='Password')
cluster_node.send(bugdbpwd, echo=True, expect='sftp')
#cluster_node.send('! pwd', echo=True, expect='Remote')
cluster_node.send('cd {bugnum}'.format(bugnum=bugnum), echo=True, expect='sftp')
#cluster_node.send('! tar cf - $tmpfile | gzip -9 > ${dirname}_${hostname}.tar.gz'.format(dirname=tfadir,hostname=hostname))
cluster_node.send('put {logdir}.tar.gz'.format(
    logdir=logdir), echo=True, expect='sftp')
cluster_node.send('exit', echo=True)
print('logs are uploaded to bugdb. done!')

cluster_node.logout()
print time.time() - start

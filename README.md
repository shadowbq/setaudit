setaudit
========

setaudit a BSD libbsm audit context setting tool

###Compile:###

```shell
git clone http://github.com/shadowbq/setaudit.git
cd setaudit
gmake
sudo gmake install
```

###Usage:###

```shell
$ /usr/local/sbin/setaudit 
usage: ./setaudit [-a auid] [-m mask] [-s source] [-p port] comand ...
```

###Example Usage:###

```shell
setaudit -a www -m ex /usr/local/etc/rc.d/apache22 restart
```

###Notes:###

OpenBSM http://en.wikipedia.org/wiki/OpenBSM

Based on http://www.opensource.apple.com/source/bsm/

This has only been tested on the following BSD versions, but should work on all BSD systems with libbsm installed.
- FreeBSD 9.0

###Real Life:###

Audit Configuration (Note: setaudit does not correctly read in /etc/security/audit_ configs)

```shell
#BSM audit_user config
www:all:no
```

Clear the file location `/tmp/foo`

```shell
[root@machine ~]# rm /tmp/foo 
```

Sudoing as www user and touch the file `/tmp/foo` show no audit log
```shell
[root@machine ~]# sudo -u www touch /tmp/foo
[root@machine ~]# auditreduce -u www -o file=/tmp/foo /var/audit/current |praudit
[root@machine ~]# 
```

Clear the file location `/tmp/foo` & audit log

```shell
[root@machine ~]# rm /tmp/foo 
[root@machine ~]# audit -n
```
Setaudit and Sudo as www user and touch the file `/tmp/foo` shows correct www audit log
```shell
[root@machine ~]# setaudit -a www -m all sudo -u www touch /tmp/foo
[root@machine ~]# auditreduce -u www -o file=/tmp/foo /var/audit/current |praudit
header,97,11,stat(2),0,Mon May  7 11:31:05 2012, + 321 msec
path,/tmp/foo
subject,www,www,www,www,www,1713,0,0,0.0.0.0
return,failure : No such file or directory,4294967295
trailer,97
header,124,11,open(2) - write,creat,0,Mon May  7 11:31:05 2012, + 321 msec
argument,3,0x1b6,mode
argument,2,0x201,flags
path,/tmp/foo
subject,www,www,www,www,www,1713,0,0,0.0.0.0
return,success,3
trailer,124

```
setaudit
========

setaudit a BSD libbsm audit context setting tool

###Compile:###

```bash
git clone http://github.com/shadowbq/setaudit.git
cd setaudit
gmake
sudo gmake install
```

###Usage:###

```bash
$ /usr/local/sbin/setaudit 
usage: ./setaudit [-a auid] [-m mask] [-s source] [-p port] comand ...
```

###Example Usage:###

```bash
setaudit -a www -m ex /usr/local/etc/rc.d/apache22 restart
```

###Notes:###

OpenBSM http://en.wikipedia.org/wiki/OpenBSM

Based on http://www.opensource.apple.com/source/bsm/

###Real Life:###

```bash

[root@machine ~]# setaudit -a www -m all touch /tmp/foo

[root@machine ~]# auditreduce -u www -o file=/tmp/foo /var/audit/current |praudit

header,126,11,stat(2),0,Mon May  7 11:22:55 2012, + 308 msec
path,/tmp/foo
attribute,644,root,www,73,1089365,0
subject,www,root,wheel,root,wheel,1683,0,0,0.0.0.0
return,success,0
trailer,126
header,126,11,utimes(2),0,Mon May  7 11:22:55 2012, + 308 msec
path,/tmp/foo
attribute,644,root,www,73,1089365,0
subject,www,root,wheel,root,wheel,1683,0,0,0.0.0.0
return,success,0
trailer,126

```
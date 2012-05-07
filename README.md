setaudit
========

setaudit a BSD libbsm audit context setting tool

Compile:

```bash
git clone http://github.com/shadowbq/setaudit.git
cd setaudit
gmake
sudo gmake install
```

Usage:

```bash
$ /usr/local/sbin/setaudit 
usage: ./setaudit [-a auid] [-m mask] [-s source] [-p port] comand ...
```

Example Usage:

```bash
setaudit -a www -m ex /usr/local/etc/rc.d/apache22 restart
```
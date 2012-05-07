## Probably only works with GNU make

ifndef CFLAGS
CFLAGS = -g -Wall -pipe -fno-common -I/usr/include $(CCFLAGS) 
endif
BINCFLAGS = $(CFLAGS) -I../lib
BSMLIBPATH = -L../lib -L/usr/lib
GCC=gcc 
WORK=./work


OUTFILES = setaudit

all: mkwork ${OUTFILES}

install: ${OUTFILES}
	for bin in ${OUTFILES} ; do \
		install $(WORK)/$$bin /usr/local/sbin ; \
		/usr/bin/strip -S /usr/local/sbin/$$bin ; \
	done

mkwork: $(shell mkdir -p $(WORK)) 

setaudit: setaudit.c
	$(GCC) $(BINCFLAGS) $(BSMLIBPATH) -lbsm setaudit.c -o $(WORK)/setaudit 

clean: 
	rm -f *.o ${OUTFILES}


## Probably only works with GNU make

ifndef CFLAGS
CFLAGS = -g -Wall -pipe -fno-common -I/usr/include $(CCFLAGS) 
endif
BINCFLAGS = $(CFLAGS) -I../lib
BSMLIBPATH = -L../lib -L/usr/lib
GCC=gcc 

OUTFILES = setaudit

all: ${OUTFILES}

install: ${OUTFILES}
	for bin in ${OUTFILES} ; do \
		install $$bin /usr/sbin ; \
		/usr/bin/strip -S /usr/sbin/$$bin ; \
	done

setaudit: setaudit.c
	$(GCC) $(BINCFLAGS) -mdynamic-no-pic $(BSMLIBPATH) -lbsm setaudit.c -o setaudit 

clean: 
	rm -f *.o ${OUTFILES}


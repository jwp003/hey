# See LICENCE file for copyright and license details

include config.mk

SRC = hey.c
OBJ = ${SRC:.c=.o}

all: hey README.md

.c.o:
	@echo cc -c ${CFLAGS} $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

hey: ${OBJ}
	@echo cc -o hey ${OBJ} ${LDFLAGS}
	@${CC} -o hey ${OBJ} ${LDFLAGS}

README.md: hey.1
	@echo Generating README.md
	@mandoc -T markdown hey.1 | sed 's/VERSION/${VERSION}/g' > README.md

clean:
	@echo Cleaning
	@rm -f ${OBJ} hey 

install:
	@echo Installing executable to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp hey ${DESTDIR}${PREFIX}/bin/
	@chmod 755 ${DESTDIR}${PREFIX}/bin/hey
	@echo Installing manual page to ${DESTDIR}${MANPATH}/man1
	@mkdir -p ${DESTDIR}${MANPATH}/man1
	@sed 's/VERSION/${VERSION}/g' < hey.1 > ${DESTDIR}${MANPATH}/man1/hey.1
	@chmod 644 ${DESTDIR}${MANPATH}/man1/hey.1
	@makewhatis ${DESTDIR}${MANPATH}

uninstall:
	@echo Removing executable: ${DESTDIR}${PREFIX}/bin/hey
	@rm -f ${DESTDIR}${PREFIX}/bin/hey
	@echo Removing man page: ${DESTDIR}${MANPATH}/man1/hey.1
	@rm -f ${DESTDIR}${MANPATH}/man1/hey.1
	@makewhatis ${DESTDIR}${MANPATH}

.PHONY: all clean install uninstall

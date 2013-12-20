# cwm from openbsd cvs 
# Makefile adapted for linux
# missing bsd functions are added (strl* and queue.h from OpenBSD and 
# fgetln from netbsd pkgsrc
# $OpenBSD: Makefile,v 1.20 2013/05/19 23:38:20 okan Exp $


PROG=		cwm

SRCS=		calmwm.c screen.c xmalloc.c client.c menu.c \
		search.c util.c xutil.c conf.c  xevents.c group.c \
		kbfunc.c mousefunc.c   parse.c


SRCS+=		strlcpy.c strlcat.c fgetln.c strtonum.c

OBJS=		calmwm.o screen.o xmalloc.o client.o menu.o \
		search.o util.o xutil.o conf.o xevents.o group.o \
		kbfunc.o mousefunc.o  parse.o
OBJS+=		strlcpy.o strlcat.o fgetln.o strtonum.o 
X11BASE=/usr
CPPFLAGS+=	-Wall -g -DDEBUG -I${X11BASE}/include -I${X11BASE}/include/freetype2 -I.
GCC_WEIRD=	-std=c99 -D_GNU_SOURCE

CFLAGS+=	-Wall

LDADD+=		-g -L${X11BASE}/lib -lXft -lXrender -lX11 -lxcb -lXau -lXdmcp \
		-lfontconfig -lexpat -lfreetype -lz -lXinerama -lXrandr -lXext

MANDIR=		${X11BASE}/man/man
MAN=		cwm.1 cwmrc.5

CLEANFILES=	cwm.cat1 cwmrc.cat5

cwm: $(OBJS)
	$(CC) $(LDADD) $(OBJS) -o cwm

clean:
	-rm *.o parse.c
	-rm cwm
parse.c:
	byacc -o parse.c parse.y 

.c.o: parse.c
	$(CC) $(GCC_WEIRD) $(CPPFLAGS) -c $<

install: cwm
	install cwm /usr/local/bin
	install cwm.1  /usr/local/share/man/man1
	install cwmrc.5  /usr/local/share/man/man5

From: Vadim Egorov <egorovv@mailandnews.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [egorovv@mailandnews.com: inet_network]
Date: Thu, 20 Apr 2000 22:25:00 -0000
Message-id: <u66tcjaa1.fsf@mailandnews.com>
References: <20000419134603.A15867@cygnus.com> <200004191752.NAA03943@envy.delorie.com> <20000419135549.D15867@cygnus.com> <200004191757.NAA03992@envy.delorie.com> <itygkq3z.fsf@mailandnews.com> <20000419194209.C17112@cygnus.com> <uog758k80.fsf@mailandnews.com> <200004201315.JAA29367@envy.delorie.com> <20000420154647.D1862@cygnus.com>
X-SW-Source: 2000-q2/msg00024.html

Chris Faylor <cgf@cygnus.com> writes:

> On Thu, Apr 20, 2000 at 09:15:08AM -0400, DJ Delorie wrote:
> >Note that BSD code should no longer have the advertising clause in it.
> 
> Yup.
> 

This copyright stuff is really tough.

Here is an another inet_network patch containing BSD implementation.
I have only changed u_long to unsigned int. Copyright notice is left
unchanged and same as it is in other BSD files in cygwin.

Personally I don't see much difference between this solution and previous
one - undocumented winsock func - I won't be surprised if they use the same 
source.

-- 
Regards,
Vadim Egorov 

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.5
diff -u -3 -r1.5 Makefile.in
--- Makefile.in	2000/04/13 22:43:48	1.5
+++ Makefile.in	2000/04/21 05:01:06
@@ -125,7 +125,7 @@
 	regsub.o registry.o resource.o scandir.o security.o select.o shared.o \
 	signal.o sigproc.o smallprint.o spawn.o strace.o strsep.o sync.o \
 	syscalls.o sysconf.o syslog.o termios.o times.o tty.o uinfo.o uname.o \
-	wait.o window.o \
+	wait.o window.o inet_network.o\
 	$(EXTRA_DLL_OFILES) $(EXTRA_OFILES) $(MT_SAFE_OBJECTS)
 
 GMON_OFILES:= gmon.o mcount.o profil.o
Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.5
diff -u -3 -r1.5 cygwin.din
--- cygwin.din	2000/04/13 06:53:23	1.5
+++ cygwin.din	2000/04/21 05:01:07
@@ -919,6 +919,7 @@
 connect = cygwin_connect
 herror = cygwin_herror
 inet_addr = cygwin_inet_addr
+inet_network
 inet_netof
 inet_makeaddr
 listen = cygwin_listen

--- inet_network.c	Thu Jan 01 03:00:00 1970
+++ inet_network.c	Fri Apr 21 08:38:48 2000
@@ -0,0 +1,93 @@
+/*
+ * Copyright (c) 1983, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ * $FreeBSD: src/lib/libc/net/inet_network.c,v 1.6 1999/11/04 04:30:44 ache Exp $
+ */
+
+#if defined(LIBC_SCCS) && !defined(lint)
+static char sccsid[] = "@(#)inet_network.c	8.1 (Berkeley) 6/4/93";
+#endif /* LIBC_SCCS and not lint */
+
+#include <sys/types.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <ctype.h>
+
+/*
+ * Internet network address interpretation routine.
+ * The library routines call this routine to interpret
+ * network numbers.
+ */
+unsigned int
+inet_network(cp)
+	register const char *cp;
+{
+	register unsigned int val, base, n, i;
+	register char c;
+	u_long parts[4], *pp = parts;
+
+again:
+	val = 0; base = 10;
+	if (*cp == '0')
+		base = 8, cp++;
+	if (*cp == 'x' || *cp == 'X')
+		base = 16, cp++;
+	while ((c = *cp) != 0) {
+		if (isdigit((unsigned char)c)) {
+			val = (val * base) + (c - '0');
+			cp++;
+			continue;
+		}
+		if (base == 16 && isxdigit((unsigned char)c)) {
+			val = (val << 4) + (c + 10 - (islower((unsigned char)c) ? 'a' : 'A'));
+			cp++;
+			continue;
+		}
+		break;
+	}
+	if (*cp == '.') {
+		if (pp >= parts + 3)
+			return (INADDR_NONE);
+		*pp++ = val, cp++;
+		goto again;
+	}
+	if (*cp && !isspace((unsigned char)*cp))
+		return (INADDR_NONE);
+	*pp++ = val;
+	n = pp - parts;
+	for (val = 0, i = 0; i < n; i++) {
+		val <<= 8;
+		val |= parts[i] & 0xff;
+	}
+	return (val);
+}
+

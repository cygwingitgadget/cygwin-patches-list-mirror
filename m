Return-Path: <cygwin-patches-return-2172-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13126 invoked by alias); 10 May 2002 22:29:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13095 invoked from network); 10 May 2002 22:29:12 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2FC6@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'newlib@sources.redhat.com'" <newlib@sources.redhat.com>, 
	cygwin-patches@cygwin.com
Subject: [PATCH] strlcat & strlcpy
Date: Fri, 10 May 2002 15:29:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1F872.13A00960"
X-SW-Source: 2002-q2/txt/msg00156.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1F872.13A00960
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 1281

Here's a patch to cygwin and newlib that adds the functions strlcat and
strlcpy.  These functions are replacement functions for strncat and strncpy.
They were created by the OpenBSD team to address buffer overflow problems
that can happen so easily when using the "n" versions.  Some other OS's have
picked them up already, and software packages have begun to use them when
available.  Aside from security benefits there are also performance
benefits.  Strlcat is much faster than strncat, due to strncat's penchant
for padding the destination string.

The original source for these two come from OpenBSD.  You can find them
here:
http://www.openbsd.org/cgi-bin/cvsweb/src/lib/libc/string/

A good discussion of the new functions can be found here:
http://www.courtesan.com/todd/papers/strlcpy.html

===================

For newlib:
2002-05-10  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
        * libc/include/string.h: Add strlcat and strlcpy.
        * libc/string/Makefile.am: Add strlcat.c and strlcpy.c.
        * libc/string/strlcat.c: New file.
        * libc/string/strlcpy.c: New file.

For cygwin:
2002-05-10  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

	  * cygwin.din: Add strlcat and strlcpy.
	  * include/cygwin/version.h: Increment API minor version number.


------_=_NextPart_000_01C1F872.13A00960
Content-Type: application/octet-stream;
	name="cygwin.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin.diff"
Content-length: 1147

diff -ubBpNr orig/cygwin.din new/cygwin.din=0A=
--- orig/cygwin.din	Wed Apr 10 10:14:18 2002=0A=
+++ new/cygwin.din	Fri May 10 16:32:29 2002=0A=
@@ -967,6 +967,10 @@ pclose=0A=
 _pclose =3D pclose=0A=
 strftime=0A=
 _strftime =3D strftime=0A=
+strlcat=0A=
+_strlcat =3D strlcat=0A=
+strlcpy=0A=
+_strlcpy =3D strlcpy=0A=
 strptime=0A=
 _strptime =3D strptime=0A=
 setgrent=0A=
diff -ubBpNr orig/include/cygwin/version.h new/include/cygwin/version.h=0A=
--- orig/include/cygwin/version.h	Wed Apr 10 10:14:19 2002=0A=
+++ new/include/cygwin/version.h	Fri May 10 16:35:15 2002=0A=
@@ -150,12 +150,13 @@ details. */=0A=
        50: Export fnmatch.=0A=
        51: Export recvmsg, sendmsg.=0A=
        52: Export strptime=0A=
+       53: Export strlcat, strlcpy.=0A=
      */=0A=
=20=0A=
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull =
*/=0A=
=20=0A=
 #define CYGWIN_VERSION_API_MAJOR 0=0A=
-#define CYGWIN_VERSION_API_MINOR 52=0A=
+#define CYGWIN_VERSION_API_MINOR 53=0A=
=20=0A=
      /* There is also a compatibity version number associated with the=0A=
 	shared memory regions.  It is incremented when incompatible=0A=

------_=_NextPart_000_01C1F872.13A00960
Content-Type: application/octet-stream;
	name="newlib.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="newlib.diff"
Content-length: 7896

diff -ubBpNr orig/libc/include/string.h new/libc/include/string.h=0A=
--- orig/libc/include/string.h	Wed Aug 30 14:30:15 2000=0A=
+++ new/libc/include/string.h	Fri May 10 18:20:28 2002=0A=
@@ -34,6 +34,8 @@ char 	*_EXFUN(strcpy,(char *, const char=0A=
 size_t	 _EXFUN(strcspn,(const char *, const char *));=0A=
 char 	*_EXFUN(strerror,(int));=0A=
 size_t	 _EXFUN(strlen,(const char *));=0A=
+size_t	 _EXFUN(strlcat,(char *, const char *, size_t));=0A=
+size_t	 _EXFUN(strlcpy,(char *, const char *, size_t));=0A=
 char 	*_EXFUN(strncat,(char *, const char *, size_t));=0A=
 int	 _EXFUN(strncmp,(const char *, const char *, size_t));=0A=
 char 	*_EXFUN(strncpy,(char *, const char *, size_t));=0A=
diff -ubBpNr orig/libc/string/Makefile.am new/libc/string/Makefile.am=0A=
--- orig/libc/string/Makefile.am	Fri May 10 16:56:54 2002=0A=
+++ new/libc/string/Makefile.am	Fri May 10 16:31:16 2002=0A=
@@ -23,6 +23,8 @@ LIB_SOURCES =3D \=0A=
 	strcpy.c \=0A=
 	strcspn.c \=0A=
 	strerror.c \=0A=
+	strlcat.c \=0A=
+	strlcpy.c \=0A=
 	strlen.c  \=0A=
 	strlwr.c \=0A=
 	strncat.c \=0A=
diff -ubBpNr orig/libc/string/strlcat.c new/libc/string/strlcat.c=0A=
--- orig/libc/string/strlcat.c	Wed Dec 31 19:00:00 1969=0A=
+++ new/libc/string/strlcat.c	Fri May 10 17:23:05 2002=0A=
@@ -0,0 +1,74 @@=0A=
+/*      $OpenBSD: strlcat.c,v 1.8 2001/05/13 15:40:15 deraadt Exp $       =
 */=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>=0A=
+ * All rights reserved.=0A=
+ *=0A=
+ * Redistribution and use in source and binary forms, with or without=0A=
+ * modification, are permitted provided that the following conditions=0A=
+ * are met:=0A=
+ * 1. Redistributions of source code must retain the above copyright=0A=
+ *    notice, this list of conditions and the following disclaimer.=0A=
+ * 2. Redistributions in binary form must reproduce the above copyright=0A=
+ *    notice, this list of conditions and the following disclaimer in the=
=0A=
+ *    documentation and/or other materials provided with the distribution.=
=0A=
+ * 3. The name of the author may not be used to endorse or promote product=
s=0A=
+ *    derived from this software without specific prior written permission=
.=0A=
+ *=0A=
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTI=
ES,=0A=
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILIT=
Y=0A=
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL=
=0A=
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,=0A=
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROF=
ITS;=0A=
+ * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY=
,=0A=
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=
=0A=
+ * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=
=0A=
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.=0A=
+ */=0A=
+=0A=
+#if defined(LIBC_SCCS) && !defined(lint)=0A=
+static char *rcsid =3D "$OpenBSD: strlcat.c,v 1.8 2001/05/13 15:40:15 dera=
adt Exp $";=0A=
+#endif /* LIBC_SCCS and not lint */=0A=
+=0A=
+#include <sys/types.h>=0A=
+#include <string.h>=0A=
+=0A=
+/*=0A=
+ * Appends src to string dst of size siz (unlike strncat, siz is the=0A=
+ * full size of dst, not space left).  At most siz-1 characters=0A=
+ * will be copied.  Always NUL terminates (unless siz <=3D strlen(dst)).=
=0A=
+ * Returns strlen(src) + MIN(siz, strlen(initial dst)).=0A=
+ * If retval >=3D siz, truncation occurred.=0A=
+ */=0A=
+size_t=0A=
+_DEFUN (strlcat, (dst, src, siz),=0A=
+	char *dst _AND=0A=
+	_CONST char *src _AND=0A=
+	size_t siz)=0A=
+{=0A=
+        register char *d =3D dst;=0A=
+        register const char *s =3D src;=0A=
+        register size_t n =3D siz;=0A=
+        size_t dlen;=0A=
+=0A=
+        /* Find the end of dst and adjust bytes left but don't go past end=
 */=0A=
+        while (n-- !=3D 0 && *d !=3D '\0')=0A=
+                d++;=0A=
+        dlen =3D d - dst;=0A=
+        n =3D siz - dlen;=0A=
+=0A=
+        if (n =3D=3D 0)=0A=
+                return(dlen + strlen(s));=0A=
+        while (*s !=3D '\0') {=0A=
+                if (n !=3D 1) {=0A=
+                        *d++ =3D *s;=0A=
+                        n--;=0A=
+                }=0A=
+                s++;=0A=
+        }=0A=
+        *d =3D '\0';=0A=
+=0A=
+        return(dlen + (s - src));        /* count does not include NUL */=
=0A=
+}=0A=
+=0A=
diff -ubBpNr orig/libc/string/strlcpy.c new/libc/string/strlcpy.c=0A=
--- orig/libc/string/strlcpy.c	Wed Dec 31 19:00:00 1969=0A=
+++ new/libc/string/strlcpy.c	Fri May 10 17:23:48 2002=0A=
@@ -0,0 +1,70 @@=0A=
+/*      $OpenBSD: strlcpy.c,v 1.5 2001/05/13 15:40:16 deraadt Exp $       =
 */=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>=0A=
+ * All rights reserved.=0A=
+ *=0A=
+ * Redistribution and use in source and binary forms, with or without=0A=
+ * modification, are permitted provided that the following conditions=0A=
+ * are met:=0A=
+ * 1. Redistributions of source code must retain the above copyright=0A=
+ *    notice, this list of conditions and the following disclaimer.=0A=
+ * 2. Redistributions in binary form must reproduce the above copyright=0A=
+ *    notice, this list of conditions and the following disclaimer in the=
=0A=
+ *    documentation and/or other materials provided with the distribution.=
=0A=
+ * 3. The name of the author may not be used to endorse or promote product=
s=0A=
+ *    derived from this software without specific prior written permission=
.=0A=
+ *=0A=
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTI=
ES,=0A=
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILIT=
Y=0A=
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL=
=0A=
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,=0A=
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=0A=
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROF=
ITS;=0A=
+ * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY=
,=0A=
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=
=0A=
+ * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=
=0A=
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.=0A=
+ */=0A=
+=0A=
+#if defined(LIBC_SCCS) && !defined(lint)=0A=
+static char *rcsid =3D "$OpenBSD: strlcpy.c,v 1.5 2001/05/13 15:40:16 dera=
adt Exp $";=0A=
+#endif /* LIBC_SCCS and not lint */=0A=
+=0A=
+#include <sys/types.h>=0A=
+#include <string.h>=0A=
+=0A=
+/*=0A=
+ * Copy src to string dst of size siz.  At most siz-1 characters=0A=
+ * will be copied.  Always NUL terminates (unless siz =3D=3D 0).=0A=
+ * Returns strlen(src); if retval >=3D siz, truncation occurred.=0A=
+ */=0A=
+size_t=0A=
+_DEFUN (strlcpy, (dst, src, siz),=0A=
+	char *dst _AND=0A=
+	_CONST char *src _AND=0A=
+	size_t siz)=0A=
+{=0A=
+        register char *d =3D dst;=0A=
+        register const char *s =3D src;=0A=
+        register size_t n =3D siz;=0A=
+=0A=
+        /* Copy as many bytes as will fit */=0A=
+        if (n !=3D 0 && --n !=3D 0) {=0A=
+                do {=0A=
+                        if ((*d++ =3D *s++) =3D=3D 0)=0A=
+                                break;=0A=
+                } while (--n !=3D 0);=0A=
+        }=0A=
+=0A=
+        /* Not enough room in dst, add NUL and traverse rest of src */=0A=
+        if (n =3D=3D 0) {=0A=
+                if (siz !=3D 0)=0A=
+                        *d =3D '\0';                /* NUL-terminate dst *=
/=0A=
+                while (*s++)=0A=
+                        ;=0A=
+        }=0A=
+=0A=
+        return(s - src - 1);        /* count does not include NUL */=0A=
+}=0A=
+=0A=

------_=_NextPart_000_01C1F872.13A00960--

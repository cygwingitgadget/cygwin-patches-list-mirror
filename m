Return-Path: <cygwin-patches-return-1502-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 19175 invoked by alias); 17 Nov 2001 08:10:58 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 19141 invoked from network); 17 Nov 2001 08:10:56 -0000
X-Originating-IP: [203.29.197.73]
From: "Gareth Pearce" <tilps@hotmail.com>
To: <cygwin-patches@cygwin.com>,
	<newlib@sources.redhat.com>
Subject: [PATCH] - add setbuffer/setlinebuf functions
Date: Sat, 13 Oct 2001 21:14:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00E2_01C16F9B.940E3E60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE28g1rEjoT2Y89RdrU0001288b@hotmail.com>
X-OriginalArrivalTime: 17 Nov 2001 08:10:56.0256 (UTC) FILETIME=[6219B800:01C16F3F]
X-SW-Source: 2001-q4/txt/msg00034.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00E2_01C16F9B.940E3E60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 931

Hi

I noticed that these 2 functions were not part of the newlib library - even
though they are defined in the headers.
Attached is 2 patches one for a new file setbuffer.c in libc/stdio/ and the
other for modifications to the makefiles in that directory.

This is my first go at something like this - so it wouldnt supprise me if I
have something amiss, feel free to tell me what I need to do to correct
this, or if I am out of place trying to get this added.

If this goes in, I will submit another patch for the cygwin.din to export
these if that is needed.

ChangeLog entry

2001-11-17  Gareth Pearce  <tilps@hotmail.com>

        * libc/stdio/Makefile.am: Modify to add setbuffer.c
        * libc/stdio/Makefile.in: Modify to add setbuffer.c
        * libc/stdio/setbuffer.c: New file to add support for
setbuffer/setlinebuf
        (setbuffer): New function - calls setvbuf
        (setlinebuf): New function - calls setvbuf

------=_NextPart_000_00E2_01C16F9B.940E3E60
Content-Type: application/octet-stream;
	name="setbuffer.patch1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setbuffer.patch1"
Content-length: 2180

--- Makefile.am	2001/04/20 22:50:51	1.3=0A=
+++ Makefile.am	2001/11/17 07:52:48=0A=
@@ -53,6 +53,7 @@ lib_a_SOURCES =3D \=0A=
 	rget.c 				\=0A=
 	scanf.c 			\=0A=
 	setbuf.c 			\=0A=
+	setbuffer.c 			\=0A=
 	setvbuf.c 			\=0A=
 	siprintf.c 			\=0A=
 	snprintf.c			\=0A=
@@ -113,6 +114,7 @@ CHEWOUT_FILES =3D \=0A=
 	rename.def		\=0A=
 	rewind.def		\=0A=
 	setbuf.def		\=0A=
+	setbuffer.def		\=0A=
 	setvbuf.def		\=0A=
 	siprintf.def		\=0A=
 	sprintf.def		\=0A=
@@ -155,6 +157,7 @@ puts.o: fvwrite.h=0A=
 refill.o: local.h=0A=
 scanf.o: local.h=0A=
 setbuf.o: local.h=0A=
+setbuffer.o: local.h=0A=
 setvbuf.o: local.h=0A=
 siprintf.o: local.h=0A=
 sprintf.o: local.h=0A=
--- Makefile.in	2001/04/20 22:50:51	1.3=0A=
+++ Makefile.in	2001/11/17 07:52:51=0A=
@@ -135,6 +135,7 @@ lib_a_SOURCES =3D \=0A=
 	rget.c 				\=0A=
 	scanf.c 			\=0A=
 	setbuf.c 			\=0A=
+	setbuffer.c 			\=0A=
 	setvbuf.c 			\=0A=
 	siprintf.c 			\=0A=
 	snprintf.c			\=0A=
@@ -193,6 +194,7 @@ CHEWOUT_FILES =3D \=0A=
 	rename.def		\=0A=
 	rewind.def		\=0A=
 	setbuf.def		\=0A=
+	setbuffer.def		\=0A=
 	setvbuf.def		\=0A=
 	siprintf.def		\=0A=
 	sprintf.def		\=0A=
@@ -226,9 +228,9 @@ fprintf.o fputc.o fputs.o fread.o freope=0A=
 ftell.o fvwrite.o fwalk.o fwrite.o getc.o getchar.o gets.o getw.o \=0A=
 iprintf.o makebuf.o mktemp.o perror.o printf.o putc.o putchar.o puts.o \=
=0A=
 putw.o refill.o remove.o rename.o rewind.o rget.o scanf.o setbuf.o \=0A=
-setvbuf.o siprintf.o snprintf.o sprintf.o sscanf.o stdio.o tmpfile.o \=0A=
-tmpnam.o ungetc.o vfprintf.o vfscanf.o vprintf.o vscanf.o vsnprintf.o \=0A=
-vsprintf.o vsscanf.o wbuf.o wsetup.o=0A=
+setbuffer.o setvbuf.o siprintf.o snprintf.o sprintf.o sscanf.o stdio.o \=
=0A=
+tmpfile.o tmpnam.o ungetc.o vfprintf.o vfscanf.o vprintf.o vscanf.o \=0A=
+vsnprintf.o vsprintf.o vsscanf.o wbuf.o wsetup.o=0A=
 CFLAGS =3D @CFLAGS@=0A=
 COMPILE =3D $(CC) $(DEFS) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLA=
GS) $(CFLAGS)=0A=
 CCLD =3D $(CC)=0A=
@@ -432,6 +434,7 @@ puts.o: fvwrite.h=0A=
 refill.o: local.h=0A=
 scanf.o: local.h=0A=
 setbuf.o: local.h=0A=
+setbuffer.o: local.h=0A=
 setvbuf.o: local.h=0A=
 siprintf.o: local.h=0A=
 sprintf.o: local.h=0A=

------=_NextPart_000_00E2_01C16F9B.940E3E60
Content-Type: application/octet-stream;
	name="setbuffer.patch2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setbuffer.patch2"
Content-length: 4231

--- setbuffer.c.EMPTY	Sat Nov 17 18:55:11 2001=0A=
+++ setbuffer.c	Sat Nov 17 17:44:23 2001=0A=
@@ -0,0 +1,125 @@=0A=
+/*=0A=
+ * Copyright (c) 1990 The Regents of the University of California.=0A=
+ * All rights reserved.=0A=
+ *=0A=
+ * Redistribution and use in source and binary forms are permitted=0A=
+ * provided that the above copyright notice and this paragraph are=0A=
+ * duplicated in all such forms and that any documentation,=0A=
+ * advertising materials, and other materials related to such=0A=
+ * distribution and use acknowledge that the software was developed=0A=
+ * by the University of California, Berkeley.  The name of the=0A=
+ * University may not be used to endorse or promote products derived=0A=
+ * from this software without specific prior written permission.=0A=
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR=0A=
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED=0A=
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.=0A=
+ */=0A=
+=0A=
+/*=20=0A=
+Modified copy of setbuf.c to support setbuffer and setlinebuf functions=0A=
+defined as part of BSD.=0A=
+Modifications by Gareth Pearce, 2001.=0A=
+*/=0A=
+=0A=
+/*=0A=
+FUNCTION=0A=
+<<setbuffer>>---specify full buffering for a file or stream with size=0A=
+=0A=
+INDEX=0A=
+	setbuffer=0A=
+=0A=
+ANSI_SYNOPSIS=0A=
+	#include <stdio.h>=0A=
+	void setbuffer(FILE *<[fp]>, char *<[buf]>, int <[size]>);=0A=
+=0A=
+TRAD_SYNOPSIS=0A=
+	#include <stdio.h>=0A=
+	void setbuffer(<[fp]>, <[buf]>, <[size]>)=0A=
+	FILE *<[fp]>;=0A=
+	char *<[buf]>;=0A=
+	int <[size]>;=0A=
+=0A=
+DESCRIPTION=0A=
+<<setbuffer>> specifies that output to the file or stream identified by=0A=
+<[fp]> should be fully buffered.  All output for this file will go to a=0A=
+buffer (of size <[size]>).  Output will be passed on to the host system=0A=
+only when the buffer is full, or when an input operation intervenes.=0A=
+=0A=
+You may, if you wish, supply your own buffer by passing a pointer to=0A=
+it as the argument <[buf]>.  It must have size <[size]>.  You can=0A=
+also use <<NULL>> as the value of <[buf]>, to signal that the=0A=
+<<setbuffer>> function is to allocate the buffer.=0A=
+=0A=
+WARNINGS=0A=
+You may only use <<setbuffer>> before performing any file operation=0A=
+other than opening the file.=0A=
+=0A=
+If you supply a non-null <[buf]>, you must ensure that the associated=0A=
+storage continues to be available until you close the stream=0A=
+identified by <[fp]>.=0A=
+=0A=
+RETURNS=0A=
+<<setbuffer>> does not return a result.=0A=
+=0A=
+PORTABILITY=0A=
+This function comes from BSD not ANSI or POSIX.=0A=
+=0A=
+Supporting OS subroutines required: <<close>>, <<fstat>>, <<isatty>>,=0A=
+<<lseek>>, <<read>>, <<sbrk>>, <<write>>.=0A=
+=0A=
+=0A=
+FUNCTION=0A=
+=0A=
+<<setlinebuf>>---specify line buffering for a file or stream=0A=
+=0A=
+INDEX=0A=
+	setlinebuf=0A=
+=0A=
+ANSI_SYNOPSIS=0A=
+	#include <stdio.h>=0A=
+	void setlinebuf(FILE *<[fp]>);=0A=
+=0A=
+TRAD_SYNOPSIS=0A=
+	#include <stdio.h>=0A=
+	void setlinebuf(<[fp]>)=0A=
+	FILE *<[fp]>;=0A=
+=0A=
+DESCRIPTION=0A=
+<<setlinebuf>> specifies that output to the file or stream identified by=
=0A=
+<[fp]> should be line buffered.  This causes the file or stream to pass=0A=
+on output to the host system at every newline, as well as when the=0A=
+buffer is full, or when an input operation intervenes.=0A=
+=0A=
+WARNINGS=0A=
+You may only use <<setlinebuf>> before performing any file operation=0A=
+other than opening the file.=0A=
+=0A=
+RETURNS=0A=
+<<setlinebuf>> returns as per setvbuf.=0A=
+=0A=
+PORTABILITY=0A=
+This function comes from BSD not ANSI or POSIX.=0A=
+=0A=
+Supporting OS subroutines required: <<close>>, <<fstat>>, <<isatty>>,=0A=
+<<lseek>>, <<read>>, <<sbrk>>, <<write>>.=0A=
+*/=0A=
+=0A=
+#include <_ansi.h>=0A=
+#include <stdio.h>=0A=
+#include "local.h"=0A=
+=0A=
+void=0A=
+_DEFUN (setbuffer, (fp, buf, size),=0A=
+	FILE * fp _AND=0A=
+	char *buf _AND=0A=
+	int size)=0A=
+{=0A=
+  (void) setvbuf (fp, buf, buf ? _IOFBF : _IONBF, (size_t) size);=0A=
+}=0A=
+=0A=
+int=0A=
+_DEFUN (setlinebuf, (fp),=0A=
+	FILE * fp)=0A=
+{=0A=
+  return (setvbuf (fp, (char *) NULL, _IOLBF, (size_t) 0));=0A=
+}=0A=

------=_NextPart_000_00E2_01C16F9B.940E3E60--

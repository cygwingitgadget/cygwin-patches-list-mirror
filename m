Return-Path: <cygwin-patches-return-6142-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18570 invoked by alias); 6 Sep 2007 23:40:26 -0000
Received: (qmail 18559 invoked by uid 22791); 6 Sep 2007 23:40:25 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Sep 2007 23:40:15 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1ITQxJ-0006YL-Up 	for cygwin-patches@cygwin.com; Thu, 06 Sep 2007 23:40:14 +0000
Message-ID: <46E08F5C.D534F44E@dessent.net>
Date: Thu, 06 Sep 2007 23:40:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] inline __getreent in newlib
Content-Type: multipart/mixed;  boundary="------------B8F9464C4050D6E8F6245AA7"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00017.txt.bz2

This is a multi-part message in MIME format.
--------------B8F9464C4050D6E8F6245AA7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 2241


I noticed today that all instances of _REENT in newlib go through a
function call to __getreent().  All this function does is get the value
of %fs:4 and subtract a fixed offset from it, so this seems rather
wasteful.  And we already have the required value of this offset
computed for us in tlsoffsets.h, so we have everything we need to
provide newlib with an inline version of this function, saving the
overhead of a function call.  It would obviously be cleaner to be able
to do:

#define __getreent() (&_my_tls.local_clib)

...however this would require dragging all kinds of internal Cygwin
definitions into a newlib header and since we already have the required
offset in tlsoffsets.h we might as well just use that.  The attached
patch does this; the second part would obviously have to be approved by
the newlib maintainers, but I thought I'd see if there's any interest in
this idea first before bothering them.

The following is the result of the iospeed output from the testsuite:
(units are ms elapsed as returned by GetTickCount, so smaller is better,
but note that the resolution here is at best 10ms.)

Before:
              ----- text -----  ---- binary ----
linesz    cr  getc fread fgets  getc fread fgets
     4     0  1906   110   656  1890    78   719
    64     0  1906    94   218  1907    46   110
  4096     0  1922   125   172  2313    62    63
     4     1  1438   203   640  1890    63   719
    64     1  1891   109   219  1922    63    94
  4096     1  1938    93   188  1922    78    78

After:
              ----- text -----  ---- binary ----
linesz    cr  getc fread fgets  getc fread fgets
     4     0  1781   125   672  1782    62   703
    64     0  1765   110   218  1750    62   109
  4096     0  1797    93   188  1766    78    78
     4     1  1328   188   609  1750    62   719
    64     1  1750   109   203  1781    47   109
  4096     1  1797   125   172  1766    62    63

I don't pretend to claim that this is a very scientific benchmark at
all, but there does seem to be a slight improvement especially in the
getc column which represents reading the whole 16MB file one byte at a
time, where this _REENT overhead would be most pronounced.

So, valid optimization or just complication?

Brian
--------------B8F9464C4050D6E8F6245AA7
Content-Type: text/plain; charset=us-ascii;
 name="getreent-inline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="getreent-inline.patch"
Content-length: 777

2007-09-06  Brian Dessent  <brian@dessent.net>

	* include/cygwin/config.h (__getreent): Define inline version.


Index: include/cygwin/config.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/config.h,v
retrieving revision 1.5
diff -u -p -r1.5 config.h
--- include/cygwin/config.h	15 Nov 2003 17:04:10 -0000	1.5
+++ include/cygwin/config.h	6 Sep 2007 23:12:33 -0000
@@ -20,6 +20,9 @@ extern "C" {
 #define _CYGWIN_CONFIG_H
 
 #define __DYNAMIC_REENT__
+#include "../tlsoffsets.h"
+extern char *_tlsbase __asm__ ("%fs:4");
+#define __getreent() (struct _reent *)(_tlsbase + tls_local_clib)
 #define __FILENAME_MAX__ (260 - 1 /* NUL */)
 #define _READ_WRITE_RETURN_TYPE _ssize_t
 #define __LARGE64_FILES 1

--------------B8F9464C4050D6E8F6245AA7
Content-Type: text/plain; charset=us-ascii;
 name="newlib-getreent-inline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newlib-getreent-inline.patch"
Content-length: 595

2007-09-06  Brian Dessent  <brian@dessent.net>

	* libc/reent/getreent.c: Allow for case where __getreent is
	defined as a macro.

Index: libc/reent/getreent.c
===================================================================
RCS file: /cvs/src/src/newlib/libc/reent/getreent.c,v
retrieving revision 1.1
diff -u -p -r1.1 getreent.c
--- libc/reent/getreent.c	17 May 2002 23:39:37 -0000	1.1
+++ libc/reent/getreent.c	6 Sep 2007 23:13:10 -0000
@@ -3,6 +3,10 @@
 #include <_ansi.h>
 #include <reent.h>
 
+#ifdef __getreent
+#undef __getreent
+#endif
+
 struct _reent *
 _DEFUN_VOID(__getreent)
 {

--------------B8F9464C4050D6E8F6245AA7--


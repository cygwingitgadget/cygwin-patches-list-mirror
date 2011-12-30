Return-Path: <cygwin-patches-return-7575-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 670 invoked by alias); 30 Dec 2011 06:45:13 -0000
Received: (qmail 639 invoked by uid 22791); 30 Dec 2011 06:45:10 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_TP
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 30 Dec 2011 06:44:57 +0000
Received: by iagw33 with SMTP id w33so26432883iag.2        for <cygwin-patches@cygwin.com>; Thu, 29 Dec 2011 22:44:56 -0800 (PST)
Received: by 10.42.161.10 with SMTP id r10mr40510584icx.22.1325227496617;        Thu, 29 Dec 2011 22:44:56 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id yg2sm83935562igb.1.2011.12.29.22.44.55        (version=SSLv3 cipher=OTHER);        Thu, 29 Dec 2011 22:44:56 -0800 (PST)
Message-ID: <1325227497.5512.18.camel@YAAKOV04>
Subject: [PATCH] Add getpt(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Fri, 30 Dec 2011 06:45:00 -0000
Content-Type: multipart/mixed; boundary="=-woQXG2yOvaPcBq40DD6e"
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00065.txt.bz2


--=-woQXG2yOvaPcBq40DD6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 565

getpt(3) is a GNU extension which predates posix_openpt(3):

http://www.kernel.org/doc/man-pages/online/pages/man3/getpt.3.html

The code itself is quite simple, but let me preempt some questions:

1) Yes, portable code should use posix_openpt(3).  Unfortunately not all
code is written with portability in mind.

2) A macro is insufficient as it will not be discovered by an Autoconf
AC_CHECK_FUNC or CMake CHECK_FUNCTION_EXISTS test (which is exactly how
I came across this issue in the first place).

Patches for winsup/cygwin and winsup/doc attached.


Yaakov


--=-woQXG2yOvaPcBq40DD6e
Content-Disposition: attachment; filename="cygwin-getpt.patch"
Content-Type: text/x-patch; name="cygwin-getpt.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 3197

2011-12-30  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (getpt): Export.
	* posix.sgml (std-gnu): Add getpt.
	* tty.cc (getpt): New function.
	* include/cygwin/stdlib.h [!__STRICT_ANSI__] (getpt): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.249
diff -u -p -r1.249 cygwin.din
--- cygwin.din	7 Nov 2011 20:05:48 -0000	1.249
+++ cygwin.din	17 Nov 2011 01:29:52 -0000
@@ -759,6 +759,7 @@ getprogname NOSIGFE
 getprotobyname = cygwin_getprotobyname SIGFE
 getprotobynumber = cygwin_getprotobynumber SIGFE
 getprotoent = cygwin_getprotoent SIGFE
+getpt SIGFE
 getpwduid NOSIGFE
 _getpwduid = getpwduid NOSIGFE
 getpwent SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.72
diff -u -p -r1.72 posix.sgml
--- posix.sgml	8 Nov 2011 09:24:58 -0000	1.72
+++ posix.sgml	17 Nov 2011 01:29:52 -0000
@@ -1116,6 +1116,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     get_nprocs_conf
     getopt_long
     getopt_long_only
+    getpt
     getxattr
     lgetxattr
     listxattr
Index: tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.91
diff -u -p -r1.91 tty.cc
--- tty.cc	30 Oct 2011 04:50:35 -0000	1.91
+++ tty.cc	17 Nov 2011 01:29:53 -0000
@@ -26,6 +26,12 @@ details. */
 HANDLE NO_COPY tty_list::mutex = NULL;
 
 extern "C" int
+getpt (void)
+{
+  return open ("/dev/ptmx", O_RDWR | O_NOCTTY);
+}
+
+extern "C" int
 posix_openpt (int oflags)
 {
   return open ("/dev/ptmx", oflags);
Index: include/cygwin/stdlib.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/stdlib.h,v
retrieving revision 1.11
diff -u -p -r1.11 stdlib.h
--- include/cygwin/stdlib.h	8 Nov 2011 05:50:18 -0000	1.11
+++ include/cygwin/stdlib.h	17 Nov 2011 01:29:53 -0000
@@ -31,6 +31,7 @@ char *setstate (const char *state);
 void srandom (unsigned);
 char *ptsname (int);
 int ptsname_r(int, char *, size_t);
+int getpt (void);
 int grantpt (int);
 int unlockpt (int);
 #endif /*__STRICT_ANSI__*/
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.356
diff -u -p -r1.356 version.h
--- include/cygwin/version.h	7 Nov 2011 20:05:49 -0000	1.356
+++ include/cygwin/version.h	17 Nov 2011 01:29:53 -0000
@@ -425,12 +425,13 @@ details. */
       254: Export getgrouplist.
       255: Export ptsname_r.
       256: Add CW_ALLOC_DRIVE_MAP, CW_MAP_DRIVE_MAP, CW_FREE_DRIVE_MAP.
+      257: Export getpt.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 256
+#define CYGWIN_VERSION_API_MINOR 257
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-woQXG2yOvaPcBq40DD6e
Content-Disposition: attachment; filename="doc-getpt.patch"
Content-Type: text/x-patch; name="doc-getpt.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 752

2011-12-30  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document getpt.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.94
diff -u -p -r1.94 new-features.sgml
--- new-features.sgml	13 Dec 2011 03:54:59 -0000	1.94
+++ new-features.sgml	30 Dec 2011 06:41:31 -0000
@@ -101,7 +101,7 @@ dlopen now supports the Glibc-specific R
 </para></listitem>
 
 <listitem><para>
-Other new API: clock_settime, __fpurge, getgrouplist, ppoll, psiginfo,
+Other new API: clock_settime, __fpurge, getgrouplist, getpt, ppoll, psiginfo,
 psignal, ptsname_r, sys_siglist, pthread_setschedprio, sysinfo.
 </para></listitem>
 

--=-woQXG2yOvaPcBq40DD6e--

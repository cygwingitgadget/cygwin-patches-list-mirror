Return-Path: <cygwin-patches-return-7596-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23666 invoked by alias); 21 Feb 2012 22:45:11 -0000
Received: (qmail 23650 invoked by uid 22791); 21 Feb 2012 22:45:09 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 21 Feb 2012 22:44:56 +0000
Received: by iaeh11 with SMTP id h11so11735466iae.2        for <cygwin-patches@cygwin.com>; Tue, 21 Feb 2012 14:44:55 -0800 (PST)
Received-SPF: pass (google.com: domain of yselkowitz@gmail.com designates 10.43.133.74 as permitted sender) client-ip=10.43.133.74;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of yselkowitz@gmail.com designates 10.43.133.74 as permitted sender) smtp.mail=yselkowitz@gmail.com; dkim=pass header.i=yselkowitz@gmail.com
Received: from mr.google.com ([10.43.133.74])        by 10.43.133.74 with SMTP id hx10mr29737332icc.30.1329864295449 (num_hops = 1);        Tue, 21 Feb 2012 14:44:55 -0800 (PST)
Received: by 10.43.133.74 with SMTP id hx10mr23809533icc.30.1329864295371;        Tue, 21 Feb 2012 14:44:55 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id k3sm11368969igq.1.2012.02.21.14.44.54        (version=SSLv3 cipher=OTHER);        Tue, 21 Feb 2012 14:44:54 -0800 (PST)
Message-ID: <1329864298.3540.2.camel@YAAKOV04>
Subject: [PATCH] Add scandirat(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Tue, 21 Feb 2012 22:45:00 -0000
Content-Type: multipart/mixed; boundary="=-lIsb8KoD4U1h3F5TaFCt"
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
X-SW-Source: 2012-q1/txt/msg00019.txt.bz2


--=-lIsb8KoD4U1h3F5TaFCt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 242

scandirat(3) was added in glibc-2.15[1] and has supposedly been proposed
for addition to POSIX.1[2].  Patch attached.


Yaakov

[1] http://sourceware.org/git/?p=glibc.git;a=blob_plain;f=NEWS
[2] http://article.gmane.org/gmane.linux.man/2419


--=-lIsb8KoD4U1h3F5TaFCt
Content-Disposition: attachment; filename="cygwin-scandirat.patch"
Content-Type: text/x-patch; name="cygwin-scandirat.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 4250

2012-02-??  Yaakov Selkowitz <yselkowitz@...>

	* cygwin.din (scandirat): Export.
	* posix.sgml (std-gnu): Add scandirat.
	* syscalls.cc (scandirat): New function.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* include/sys/dirent.h (scandirat): Declare.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.253
diff -u -p -r1.253 cygwin.din
--- cygwin.din	28 Jan 2012 14:44:01 -0000	1.253
+++ cygwin.din	21 Feb 2012 11:36:15 -0000
@@ -1406,6 +1406,7 @@ scalbnf NOSIGFE
 _scalbnf = scalbnf NOSIGFE
 scandir SIGFE
 _scandir = scandir SIGFE
+scandirat SIGFE
 scanf SIGFE
 _scanf = scanf SIGFE
 scanf_r = _scanf_r SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.75
diff -u -p -r1.75 posix.sgml
--- posix.sgml	6 Jan 2012 07:12:17 -0000	1.75
+++ posix.sgml	21 Feb 2012 11:36:15 -0000
@@ -1136,6 +1136,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     pthread_sigqueue
     ptsname_r
     removexattr
+    scandirat
     setxattr
     strchrnul
     sysinfo
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.622
diff -u -p -r1.622 syscalls.cc
--- syscalls.cc	14 Feb 2012 19:08:19 -0000	1.622
+++ syscalls.cc	21 Feb 2012 11:36:16 -0000
@@ -39,6 +39,7 @@ details. */
 #include <wctype.h>
 #include <unistd.h>
 #include <sys/wait.h>
+#include <dirent.h>
 #include "ntdll.h"
 
 #undef fstat
@@ -4437,6 +4438,21 @@ renameat (int olddirfd, const char *oldp
 }
 
 extern "C" int
+scandirat (int dirfd, const char *pathname, struct dirent ***namelist,
+	   int (*select) (const struct dirent *),
+	   int (*compar) (const struct dirent **, const struct dirent **))
+{
+  tmp_pathbuf tp;
+  myfault efault;
+  if (efault.faulted (EFAULT))
+    return -1;
+  char *path = tp.c_get ();
+  if (gen_full_path_at (path, dirfd, pathname))
+    return -1;
+  return scandir (pathname, namelist, select, compar);
+}
+
+extern "C" int
 symlinkat (const char *oldpath, int newdirfd, const char *newpathname)
 {
   tmp_pathbuf tp;
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.363
diff -u -p -r1.363 version.h
--- include/cygwin/version.h	7 Feb 2012 16:50:19 -0000	1.363
+++ include/cygwin/version.h	21 Feb 2012 11:36:16 -0000
@@ -428,12 +428,13 @@ details. */
       257: Export getpt.
       258: Export get_current_dir_name.
       259: Export pthread_sigqueue.
+      260: Export scandirat.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 259
+#define CYGWIN_VERSION_API_MINOR 260
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: include/sys/dirent.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/dirent.h,v
retrieving revision 1.23
diff -u -p -r1.23 dirent.h
--- include/sys/dirent.h	6 Aug 2010 18:55:25 -0000	1.23
+++ include/sys/dirent.h	21 Feb 2012 11:36:16 -0000
@@ -1,6 +1,6 @@
 /* Posix dirent.h for WIN32.
 
-   Copyright 2001, 2002, 2003, 2005, 2006, 2007, 2010 Red Hat, Inc.
+   Copyright 2001, 2002, 2003, 2005, 2006, 2007, 2010, 2012 Red Hat, Inc.
 
    This software is a copyrighted work licensed under the terms of the
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
@@ -69,6 +69,10 @@ int scandir (const char *__dir,
 	     int (*select) (const struct dirent *),
 	     int (*compar) (const struct dirent **, const struct dirent **));
 
+int scandirat (int __dirfd, const char *__dir, struct dirent ***__namelist,
+	       int (*select) (const struct dirent *),
+	       int (*compar) (const struct dirent **, const struct dirent **));
+
 int alphasort (const struct dirent **__a, const struct dirent **__b);
 #ifdef _DIRENT_HAVE_D_TYPE
 /* File types for `d_type'.  */

--=-lIsb8KoD4U1h3F5TaFCt--

Return-Path: <cygwin-patches-return-6329-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11660 invoked by alias); 23 Apr 2008 19:18:45 -0000
Received: (qmail 11643 invoked by uid 22791); 23 Apr 2008 19:18:43 -0000
X-Spam-Check-By: sourceware.org
Received: from ti-out-0910.google.com (HELO ti-out-0910.google.com) (209.85.142.188)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 23 Apr 2008 19:18:14 +0000
Received: by ti-out-0910.google.com with SMTP id y8so1243943tia.14         for <cygwin-patches@cygwin.com>; Wed, 23 Apr 2008 12:18:11 -0700 (PDT)
Received: by 10.151.106.4 with SMTP id i4mr13588ybm.189.1208978290489;         Wed, 23 Apr 2008 12:18:10 -0700 (PDT)
Received: from ?192.168.0.100? ( [24.76.249.6])         by mx.google.com with ESMTPS id q13sm504728qbq.8.2008.04.23.12.18.09         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 23 Apr 2008 12:18:10 -0700 (PDT)
Message-ID: <480F8B7D.5080908@users.sourceforge.net>
Date: Wed, 23 Apr 2008 19:18:00 -0000
From: "Yaakov (Cygwin Ports)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: wait.h
Content-Type: multipart/mixed;  boundary="------------060000050702070406030302"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q2/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------060000050702070406030302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 641

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

glibc ships a <wait.h> which contains only one line:

#include <sys/wait.h>

I know of at least three packages that #include <wait.h> instead of
<sys/wait.h>.  Could such a header please be added to Cygwin (preferably
to both branches)?

Patch attached; I presume this is trivial enough to not require a
copyright assignment.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkgPi30ACgkQpiWmPGlmQSOIMgCg3ZFsz6Zc+nld3dEG+OnNuud9
5oMAn1T1hG2bJJ5JFhziC0w9ffN9aWW2
=ObqW
-----END PGP SIGNATURE-----

--------------060000050702070406030302
Content-Type: text/plain;
 name="wait.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wait.h.diff"
Content-length: 1073

Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.4116
diff -u -r1.4116 ChangeLog
--- ChangeLog	23 Apr 2008 11:19:57 -0000	1.4116
+++ ChangeLog	23 Apr 2008 17:48:09 -0000
@@ -1,3 +1,7 @@
+2008-04-23  Yaakov (Cygwin Ports) <yselkowitz@users.sourceforge.net>
+
+	* include/wait.h: New file.
+
 2008-04-23  Corinna Vinschen  <corinna@vinschen.de>
 
 	* posix.sgml: Add openat, faccessat, fchmodat, fchownat, fstatat,
Index: include/wait.h
===================================================================
RCS file: include/wait.h
diff -N include/wait.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/wait.h	23 Apr 2008 17:48:09 -0000
@@ -0,0 +1,16 @@
+/* wait.h
+
+   Copyright 2008 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _WAIT_H
+#define _WAIT_H
+
+#include <sys/wait.h>
+
+#endif /* _WAIT_H */



--------------060000050702070406030302--

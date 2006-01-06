Return-Path: <cygwin-patches-return-5703-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14588 invoked by alias); 6 Jan 2006 15:30:27 -0000
Received: (qmail 14579 invoked by uid 22791); 6 Jan 2006 15:30:26 -0000
X-Spam-Check-By: sourceware.org
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 06 Jan 2006 15:30:25 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43) 	id 1EutXj-0003bV-Hq 	for cygwin-patches@cygwin.com; Fri, 06 Jan 2006 16:30:15 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])         by main.gmane.org with esmtp (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Fri, 06 Jan 2006 16:30:15 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Fri, 06 Jan 2006 16:30:15 +0100
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  export getsubopt
Date: Fri, 06 Jan 2006 15:30:00 -0000
Message-ID:  <loom.20060106T162823-127@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00012.txt.bz2

Since POSIX requires getsubopt, and newlib provides it, here goes (and let's 
hope this patch applies cleaner than my previous two):

2006-01-06  Eric Blake  <ebb9@byu.net>

	* cygwin.din: Export getsubopt.
	* include/cygwin/version.h: Bump API minor version.


Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.151
diff -u -r1.151 cygwin.din
--- cygwin.din  18 Nov 2005 17:48:23 -0000      1.151
+++ cygwin.din  6 Jan 2006 15:27:57 -0000
@@ -321,6 +321,7 @@
 getservent = cygwin_getservent SIGFE
 getsockname = cygwin_getsockname SIGFE
 getsockopt = cygwin_getsockopt SIGFE
+getsubopt SIGFE
 getusershell SIGFE
 herror = cygwin_herror SIGFE
 hstrerror = cygwin_hstrerror NOSIGFE
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.219
diff -u -r1.219 version.h
--- include/cygwin/version.h    22 Dec 2005 16:45:15 -0000      1.219
+++ include/cygwin/version.h    6 Jan 2006 15:27:57 -0000
@@ -1,6 +1,6 @@
 /* version.h -- Cygwin version numbers and accompanying documentation.
 
-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006 
Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -284,12 +284,13 @@
            int, as per linux.
       148: Add open(2) flags O_SYNC, O_RSYNC, O_DSYNC and O_DIRECT.
       149: Add open(2) flag O_NOFOLLOW.
+      150: Export getsubopt.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 149
+#define CYGWIN_VERSION_API_MINOR 150
 
      /* There is also a compatibity version number associated with the
        shared memory regions.  It is incremented when incompatible



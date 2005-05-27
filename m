Return-Path: <cygwin-patches-return-5486-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8493 invoked by alias); 27 May 2005 14:23:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8270 invoked by uid 22791); 27 May 2005 14:23:04 -0000
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 27 May 2005 14:23:04 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DbffY-0003rI-35
	for cygwin-patches@cygwin.com; Fri, 27 May 2005 16:18:46 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Fri, 27 May 2005 16:18:36 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Fri, 27 May 2005 16:18:36 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  question on limits.h
Date: Fri, 27 May 2005 14:23:00 -0000
Message-ID:  <loom.20050527T160835-619@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q2/txt/msg00082.txt.bz2

My reading of POSIX says that LLONG_MIN and friends must always be defined, and 
not just when the version of C is new enough: 
http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html
At any rate, I was surprised when I noticed that coreutils was redefining 
ULLONG_MAX because it couldn't find it in limits.h.

2005-05-27  Eric Blake  <ebb9@byu.net>

	(LLONG_MIN, LLONG_MAX, ULLONG_MAX): Always define.

Index: cygwin/include/limits.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/limits.h,v
retrieving revision 1.15
diff -u -r1.15 limits.h
--- cygwin/include/limits.h     19 May 2005 19:45:28 -0000      1.15
+++ cygwin/include/limits.h     27 May 2005 14:15:47 -0000
@@ -107,7 +107,6 @@
 #define ULONG_LONG_MAX (LONG_LONG_MAX * 2ULL + 1)
 #endif
 
-#if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
 /* Minimum and maximum values a `signed long long int' can hold.  */
 #undef LLONG_MIN
 #define LLONG_MIN (-LLONG_MAX-1)
@@ -117,7 +116,6 @@
 /* Maximum value an `unsigned long long int' can hold.  (Minimum is 0).  */
 #undef ULLONG_MAX
 #define ULLONG_MAX (LLONG_MAX * 2ULL + 1)
-#endif
 
 /* Maximum number of iovcnt in a writev (an arbitrary number) */
 #undef IOV_MAX



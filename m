Return-Path: <cygwin-patches-return-5643-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23950 invoked by alias); 6 Sep 2005 15:40:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23935 invoked by uid 22791); 6 Sep 2005 15:40:50 -0000
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 06 Sep 2005 15:40:50 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ECfXU-0007bg-IX
	for cygwin-patches@cygwin.com; Tue, 06 Sep 2005 17:39:13 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 06 Sep 2005 17:39:12 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 06 Sep 2005 17:39:12 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  fix =?utf-8?b?QVJHX01BWA==?=
Date: Tue, 06 Sep 2005 15:40:00 -0000
Message-ID:  <loom.20050906T172937-420@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q3/txt/msg00098.txt.bz2

Even though cygexec mountpoints can have a larger argument space, we might as 
well make ARG_MAX and sysconf(_SC_ARG_MAX) work correctly in the common case of 
non-cygexec mountpoints.  POSIX defines ARG_MAX as the max number of bytes to 
an exec*() call, including the environment, and requires a minimum of 4k.  This 
patch is slightly conservative, since the CreateProcess limitation of 32k does 
not include the environment, but any bigger number would be problemetic.  This 
was discovered by the recent breakage in xargs 4.2.25-1, where 1M was too big.

For further justification of this patch, see the thread at 
http://lists.gnu.org/archive/html/bug-findutils/2005-09/msg00039.html

2005-09-06  Eric Blake  <ebb9@byu.net>

	* include/limits.h (ARG_MAX): New limit.
	* sysconf.cc (sysconf): _SC_ARG_MAX: Use it.

Index: sysconf.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v
retrieving revision 1.40
diff -u -r1.40 sysconf.cc
--- sysconf.cc  13 Apr 2005 16:41:33 -0000      1.40
+++ sysconf.cc  6 Sep 2005 15:32:41 -0000
@@ -1,6 +1,6 @@
 /* sysconf.cc
 
-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005 Red 
Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -30,8 +30,10 @@
   switch (in)
     {
       case _SC_ARG_MAX:
-       /* FIXME: what's the right value?  _POSIX_ARG_MAX is only 4K */
-       return 1048576;
+        /* Actually, for cygexec-mounted executables, it is much larger, but
+           as this is sysconf and not pathconf, we have no way to express
+           that larger limit.  Stick with a value that is always safe.  */
+       return ARG_MAX;
       case _SC_OPEN_MAX:
        {
          long max = getdtablesize ();
Index: include/limits.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/limits.h,v
retrieving revision 1.16
diff -u -r1.16 limits.h
--- include/limits.h    29 May 2005 10:05:56 -0000      1.16
+++ include/limits.h    6 Sep 2005 15:32:41 -0000
@@ -146,6 +146,14 @@
 #undef OPEN_MAX
 #define OPEN_MAX 256
 
+/* Maximum # of bytes for arguments to exec functions, including environment.
+   Actually, the environment is not a limitation here, and executables that
+   live on cygexec mount points have a larger limit, but this is a reasonable
+   limit, also returned by sysconf(_SC_ARG_MAX), that covers Window's
+   CreateProcess limit.  */
+#undef ARG_MAX
+#define ARG_MAX (32 * 1024)
+
 /* # of bytes in a pipe buf. This is the max # of bytes which can be
    written to a pipe in one atomic operation. */
 #undef PIPE_BUF



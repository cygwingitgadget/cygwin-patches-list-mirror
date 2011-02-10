Return-Path: <cygwin-patches-return-7173-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2836 invoked by alias); 10 Feb 2011 05:50:24 -0000
Received: (qmail 2818 invoked by uid 22791); 10 Feb 2011 05:50:23 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-yw0-f43.google.com (HELO mail-yw0-f43.google.com) (209.85.213.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 10 Feb 2011 05:50:13 +0000
Received: by yws5 with SMTP id 5so501694yws.2        for <cygwin-patches@cygwin.com>; Wed, 09 Feb 2011 21:50:11 -0800 (PST)
Received: by 10.236.102.179 with SMTP id d39mr8876336yhg.72.1297317000166;        Wed, 09 Feb 2011 21:50:00 -0800 (PST)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id j3sm770170yha.7.2011.02.09.21.49.58        (version=SSLv3 cipher=RC4-MD5);        Wed, 09 Feb 2011 21:49:59 -0800 (PST)
Subject: [PATCH] pthread_yield
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-cFd4zS6MGb47TyVDCceI"
Date: Thu, 10 Feb 2011 05:50:00 -0000
Message-ID: <1297316998.752.10.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00028.txt.bz2


--=-cFd4zS6MGb47TyVDCceI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 622

pthread_yield(3) was part of the POSIX.1c drafts but never made it into
the final standard.  Nevertheless, it is provided by Linux[1],
FreeBSD[2], OpenBSD[3], AIX[4], and possibly other *NIXes.  

"On Linux, this function is implemented as a call to sched_yield(2)."
Patch attached.


Yaakov


[1] http://www.kernel.org/doc/man-pages/online/pages/man3/pthread_yield.3.html
[2] http://www.freebsd.org/cgi/man.cgi?query=pthread_yield
[3] http://www.openbsd.org/cgi-bin/man.cgi?query=pthread_yield
[4] http://publib.boulder.ibm.com/infocenter/aix/v6r1/index.jsp?topic=/com.ibm.aix.basetechref/doc/basetrf1/pthread_yield.htm


--=-cFd4zS6MGb47TyVDCceI
Content-Disposition: attachment; filename="pthread_yield.patch"
Content-Type: text/x-patch; name="pthread_yield.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2579

2011-02-09  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* cygwin.din (pthread_yield): Export as alias to sched_yield.
	* include/pthread.h (pthread_yield): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* posix.sgml (std-deprec): Add pthread_yield.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.229
diff -u -r1.229 cygwin.din
--- cygwin.din	13 Jan 2011 13:48:12 -0000	1.229
+++ cygwin.din	10 Feb 2011 03:11:52 -0000
@@ -1245,6 +1245,7 @@
 pthread_sigmask SIGFE
 pthread_suspend SIGFE
 pthread_testcancel SIGFE
+pthread_yield = sched_yield SIGFE
 ptsname SIGFE
 putc SIGFE
 _putc = putc SIGFE
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.26
diff -u -r1.26 pthread.h
--- include/pthread.h	7 Feb 2007 17:22:40 -0000	1.26
+++ include/pthread.h	10 Feb 2011 03:11:53 -0000
@@ -194,6 +194,7 @@
 
 int pthread_suspend (pthread_t);
 int pthread_continue (pthread_t);
+int pthread_yield (void);
 
 #ifdef __cplusplus
 }
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.332
diff -u -r1.332 version.h
--- include/cygwin/version.h	12 Jan 2011 13:01:43 -0000	1.332
+++ include/cygwin/version.h	10 Feb 2011 03:11:53 -0000
@@ -399,12 +399,13 @@
       233: Add TIOCGPGRP, TIOCSPGRP.  Export llround, llroundf.
       234: Export program_invocation_name, program_invocation_short_name.
       235: Export madvise.
+      236: Export pthread_yield.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 235
+#define CYGWIN_VERSION_API_MINOR 236
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.52
diff -u -r1.52 posix.sgml
--- posix.sgml	12 Jan 2011 13:09:31 -0000	1.52
+++ posix.sgml	10 Feb 2011 05:13:45 -0000
@@ -1225,6 +1225,7 @@
     pthread_continue		(XPG2)
     pthread_getsequence_np	(Tru64)
     pthread_suspend		(XPG2)
+    pthread_yield		(POSIX.1c drafts)
     pututline			(XPG2)
     putw			(SVID)
     rindex			(SUSv3)

--=-cFd4zS6MGb47TyVDCceI--

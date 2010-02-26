Return-Path: <cygwin-patches-return-6980-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18132 invoked by alias); 26 Feb 2010 05:15:50 -0000
Received: (qmail 18109 invoked by uid 22791); 26 Feb 2010 05:15:48 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.147)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 26 Feb 2010 05:15:43 +0000
Received: by qw-out-1920.google.com with SMTP id 14so151904qwa.20         for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2010 21:15:41 -0800 (PST)
Received: by 10.224.58.208 with SMTP id i16mr240244qah.13.1267161341347;         Thu, 25 Feb 2010 21:15:41 -0800 (PST)
Received: from ?127.0.0.1? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 21sm1648589qyk.1.2010.02.25.21.15.39         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Thu, 25 Feb 2010 21:15:40 -0800 (PST)
Message-ID: <4B875901.6010906@users.sourceforge.net>
Date: Fri, 26 Feb 2010 05:15:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] define SIGPWR
Content-Type: multipart/mixed;  boundary="------------050001070708020506000301"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00096.txt.bz2

This is a multi-part message in MIME format.
--------------050001070708020506000301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 787

I'm running across more and more software which expects SIGPWR to be 
defined.

In Linux, SIGPWR is a synonym for SIGLOST on sparc, on alpha it's a 
synonym for SIGINFO (unique to alpha, and SIGLOST is not defined), and 
almost all other arches do not define SIGLOST at all and define SIGPWR 
on it's own.  Only one arch (parisc) defines both SIGLOST and SIGPWR 
separately.

Neither SIGPWR nor SIGLOST are defined by POSIX.  Since we already 
define SIGLOST, and no signal value <SIGRTMIN is undefined, this patch 
follows the lead of Linux sparc and defines SIGPWR as a synonym for SIGLOST.

IIUC in strsig.cc, only the first signal passed to _s2 will be listed by 
'kill -l' but both are accepted.  To match Linux behaviour I chose to 
make SIGPWR primary.

Patch attached.


Yaakov


--------------050001070708020506000301
Content-Type: text/plain;
 name="cygwin-signal-SIGPWR.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-signal-SIGPWR.patch"
Content-length: 2425

2010-02-25  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/cygwin/signal.h: Define SIGPWR as synonym for SIGLOST.
	* strsig.cc: Ditto.
	* include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR.

Index: strsig.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strsig.cc,v
retrieving revision 1.5
diff -u -r1.5 strsig.cc
--- strsig.cc	11 Sep 2008 06:22:31 -0000	1.5
+++ strsig.cc	26 Feb 2010 05:13:23 -0000
@@ -49,7 +49,8 @@
   _s(SIGVTALRM, "Virtual timer expired"),	/* 26 */ \
   _s(SIGPROF, "Profiling timer expired"),	/* 27 */ \
   _s(SIGWINCH, "Window changed"),		/* 28 */ \
-  _s(SIGLOST, "Resource lost"),			/* 29 */ \
+  _s2(SIGPWR, "Power failure",				/* 29 */ \
+      SIGLOST, "Resource lost"),			 \
   _s(SIGUSR1, "User defined signal 1"),		/* 30 */ \
   _s(SIGUSR2, "User defined signal 2"),		/* 31 */ \
   _s2(SIGRTMIN, "Real-time signal 0",		/* 32 */ \
Index: include/cygwin/signal.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/signal.h,v
retrieving revision 1.17
diff -u -r1.17 signal.h
--- include/cygwin/signal.h	11 Sep 2008 06:22:31 -0000	1.17
+++ include/cygwin/signal.h	26 Feb 2010 05:13:24 -0000
@@ -250,6 +250,7 @@
 #define	SIGPROF	27	/* profiling time alarm */
 #define	SIGWINCH 28	/* window changed */
 #define	SIGLOST 29	/* resource lost (eg, record-lock lost) */
+#define	SIGPWR  SIGLOST	/* power failure */
 #define	SIGUSR1 30	/* user defined signal 1 */
 #define	SIGUSR2 31	/* user defined signal 2 */
 
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.309
diff -u -r1.309 version.h
--- include/cygwin/version.h	8 Feb 2010 09:52:40 -0000	1.309
+++ include/cygwin/version.h	26 Feb 2010 05:13:24 -0000
@@ -376,12 +376,13 @@
       220: Export accept4, SOCK_CLOEXEC, SOCK_NONBLOCK.
       221: Export strfmon.
       222: CW_INT_SETLOCALE added.
+      223: SIGPWR added.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 222
+#define CYGWIN_VERSION_API_MINOR 223
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------050001070708020506000301--

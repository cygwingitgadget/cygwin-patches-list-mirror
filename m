Return-Path: <cygwin-patches-return-7296-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13027 invoked by alias); 4 May 2011 10:53:04 -0000
Received: (qmail 12787 invoked by uid 22791); 4 May 2011 10:53:02 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 04 May 2011 10:52:46 +0000
Received: by iyi20 with SMTP id 20so1161190iyi.2        for <cygwin-patches@cygwin.com>; Wed, 04 May 2011 03:52:45 -0700 (PDT)
Received: by 10.231.193.202 with SMTP id dv10mr101311ibb.136.1304506365637;        Wed, 04 May 2011 03:52:45 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id g16sm430283ibb.20.2011.05.04.03.52.44        (version=SSLv3 cipher=OTHER);        Wed, 04 May 2011 03:52:45 -0700 (PDT)
Subject: [PATCH] psignal, psiginfo, sys_siglist
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-WASZQ/1XtgdTwKmmeERs"
Date: Wed, 04 May 2011 10:53:00 -0000
Message-ID: <1304506369.820.15.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00062.txt.bz2


--=-WASZQ/1XtgdTwKmmeERs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 280

This patch exports psignal() from newlib (once my corresponding patch is
accepted) and implements psiginfo() and sys_siglist[].  The first two
are POSIX.1-2008, the latter is in BSD and glibc.

Patches for winsup/cygwin and winsup/doc, and a test application,
attached.


Yaakov


--=-WASZQ/1XtgdTwKmmeERs
Content-Disposition: attachment; filename="winsup-psignal.patch"
Content-Type: text/x-patch; name="winsup-psignal.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 5639

2011-05-04  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (psiginfo): Export.
	(psignal): Export.
	(sys_siglist): Export.
	* posix.sgml (std-notimpl): Move psiginfo and psignal from here...
	(std-susv4): ... to here.
	(std-deprec): Add sys_siglist.
	* strsig.cc (sys_siglist): New array.
	(psiginfo): New function.
	* include/cygwin/signal.h (sys_siglist): Declare.
	(psiginfo): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.237
diff -u -r1.237 cygwin.din
--- cygwin.din	3 May 2011 01:13:36 -0000	1.237
+++ cygwin.din	4 May 2011 08:15:14 -0000
@@ -28,6 +28,7 @@
 sys_nerr = _sys_nerr DATA
 _sys_nerr DATA
 sys_sigabbrev DATA
+sys_siglist DATA
 _timezone DATA
 _tzname DATA
 _Exit SIGFE
@@ -1167,6 +1168,8 @@
 program_invocation_short_name DATA
 _printf = printf SIGFE
 pselect SIGFE
+psiginfo SIGFE
+psignal SIGFE
 pthread_atfork SIGFE
 pthread_attr_destroy SIGFE
 pthread_attr_getdetachstate SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.58
diff -u -r1.58 posix.sgml
--- posix.sgml	3 May 2011 01:13:37 -0000	1.58
+++ posix.sgml	4 May 2011 08:15:14 -0000
@@ -527,6 +527,8 @@
     pread
     printf
     pselect
+    psiginfo
+    psignal
     pthread_atfork
     pthread_attr_destroy
     pthread_attr_getdetachstate
@@ -1244,6 +1246,7 @@
     setutent			(XPG2)
     sys_errlist			(BSD)
     sys_nerr			(BSD)
+    sys_siglist			(BSD)
     ttyslot			(SUSv2)
     ualarm			(SUSv3)
     usleep			(SUSv3)
@@ -1375,8 +1378,6 @@
     posix_trace[...]
     posix_typed_[...]
     powl
-    psiginfo
-    psignal
     pthread_attr_getguardsize
     pthread_attr_setguardsize
     pthread_attr_setstack
Index: strsig.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strsig.cc,v
retrieving revision 1.7
diff -u -r1.7 strsig.cc
--- strsig.cc	26 Feb 2010 16:00:17 -0000	1.7
+++ strsig.cc	4 May 2011 08:28:38 -0000
@@ -1,6 +1,6 @@
 /* strsig.cc
 
-   Copyright 2004, 2007, 2008, 2010 Red Hat, Inc.
+   Copyright 2004, 2007, 2008, 2010, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -10,6 +10,8 @@
 
 #include "winsup.h"
 #include <cygtls.h>
+#include <stdio.h>
+#include <string.h>
 
 struct sigdesc
 {
@@ -66,6 +68,16 @@
 
 #undef _s
 #undef _s2
+#define _s(n, s) s
+#define _s2(n, s, n1, s1) s
+const char *sys_siglist[] NO_COPY_INIT =
+{
+  NULL,
+  __signals
+};
+
+#undef _s
+#undef _s2
 #define _s(n, s) {n, #n, s}
 #define _s2(n, s, n1, s1) {n, #n, s}, {n, #n1, #s1}
 static const sigdesc siglist[] =
@@ -96,3 +108,38 @@
       return siglist[i].n;
   return 0;
 }
+
+extern "C" void
+psiginfo (const siginfo_t *info, const char *s)
+{
+  if (s != NULL && *s != '\0')
+    fprintf (stderr, "%s: ", s);
+
+  fprintf (stderr, "%s", strsignal (info->si_signo));
+
+  if (info->si_signo > 0 && info->si_signo < NSIG)
+  {
+    switch (info->si_signo)
+    {
+      case SIGILL:
+      case SIGBUS:
+      case SIGFPE:
+      case SIGSEGV:
+        fprintf (stderr, " (%d [%p])", info->si_code, info->si_addr);
+        break;
+      case SIGCHLD:
+        fprintf (stderr, " (%d %d %d %ld)", info->si_code, info->si_pid,
+                 info->si_status, info->si_uid);
+        break;
+/* FIXME: implement si_band
+      case SIGPOLL:
+        fprintf (stderr, " (%d %ld)", info->si_code, info->si_band);
+        break;
+*/
+      default:
+        fprintf (stderr, " (%d %d %ld)", info->si_code, info->si_pid, info->si_uid);
+    }
+  }
+
+  fprintf (stderr, "\n");
+}
Index: include/cygwin/signal.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/signal.h,v
retrieving revision 1.18
diff -u -r1.18 signal.h
--- include/cygwin/signal.h	26 Feb 2010 05:43:50 -0000	1.18
+++ include/cygwin/signal.h	4 May 2011 08:30:09 -0000
@@ -1,6 +1,6 @@
 /* signal.h
 
-  Copyright 2004, 2005, 2006 Red Hat, Inc.
+  Copyright 2004, 2005, 2006, 2011 Red Hat, Inc.
 
   This file is part of Cygwin.
 
@@ -261,6 +261,7 @@
 
 #define SIG_HOLD ((_sig_func_ptr)2)	/* Signal in signal mask */
 
+void psiginfo (const siginfo_t *, const char *);
 int sigwait (const sigset_t *, int *);
 int sigwaitinfo (const sigset_t *, siginfo_t *);
 int sighold (int);
@@ -272,8 +273,10 @@
 int siginterrupt (int, int);
 #ifdef __INSIDE_CYGWIN__
 extern const char *sys_sigabbrev[];
+extern const char *sys_siglist[];
 #else
 extern const char __declspec(dllimport) *sys_sigabbrev[];
+extern const char __declspec(dllimport) *sys_siglist[];
 #endif
 
 #ifdef __cplusplus
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.342
diff -u -r1.342 version.h
--- include/cygwin/version.h	3 May 2011 01:13:37 -0000	1.342
+++ include/cygwin/version.h	4 May 2011 08:21:58 -0000
@@ -407,12 +407,13 @@
       240: Export ppoll.
       241: Export pthread_attr_getstack, pthread_attr_getstackaddr,
 	   pthread_getattr_np.
+      242: Export psiginfo, psignal, sys_siglist.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 241
+#define CYGWIN_VERSION_API_MINOR 242
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-WASZQ/1XtgdTwKmmeERs
Content-Disposition: attachment; filename="doc-psignal.patch"
Content-Type: text/x-patch; name="doc-psignal.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 799

2011-05-04  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document psiginfo, psignal,
	and sys_siglist.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.77
diff -u -r1.77 new-features.sgml
--- new-features.sgml	3 May 2011 04:09:52 -0000	1.77
+++ new-features.sgml	4 May 2011 09:55:51 -0000
@@ -39,8 +39,8 @@
 </para></listitem>
 
 <listitem><para>
-Other new API: ppoll, pthread_attr_getstack, pthread_attr_getstackaddr,
-pthread_getattr_np, pthread_setschedprio.
+Other new API: ppoll, psiginfo, psignal, sys_siglist, pthread_attr_getstack,
+pthread_attr_getstackaddr, pthread_getattr_np, pthread_setschedprio.
 </para></listitem>
 
 </itemizedlist>

--=-WASZQ/1XtgdTwKmmeERs
Content-Disposition: attachment; filename="psignal-test.c"
Content-Type: text/x-csrc; name="psignal-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 883

#pragma CCOD:script no

#define _XOPEN_SOURCE 700
#define _BSD_SOURCE
#include <signal.h>
#include <stdio.h>
#include <string.h>

#ifdef __CYGWIN__
/* compile with unpatched headers */
extern void psiginfo (const siginfo_t *, const char *);
extern void psignal (int, const char *);
extern const char *sys_siglist[];
#endif

int
main (void)
{
	int i;
	char s[3];
	siginfo_t info;

	info.si_code = 1111;

	for (i = 0; i < NSIG + 3; i++)
	{
		info.si_signo = i;
		switch (i)
		  {
		    case SIGILL:
		    case SIGBUS:
		    case SIGFPE:
		    case SIGSEGV:
			info.si_addr = (void *)0x10000000;
			break;
		    case SIGCHLD:
			info.si_status = 4;
			break;
		    default:
			info.si_pid = 2222;
			info.si_uid = 3333;
		  }

		sprintf(s, "%d", i);
		printf("%d: %s\n", i, sys_siglist[i]);
		printf("%d: %s\n", i, strsignal(i));
		psignal(i, s);
		psiginfo(&info, s);
	}

	return 0;
}

--=-WASZQ/1XtgdTwKmmeERs--

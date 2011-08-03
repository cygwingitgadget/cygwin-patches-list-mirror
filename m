Return-Path: <cygwin-patches-return-7473-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27061 invoked by alias); 3 Aug 2011 18:42:15 -0000
Received: (qmail 27050 invoked by uid 22791); 3 Aug 2011 18:42:13 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_LR,TW_QT,TW_RQ
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Aug 2011 18:41:57 +0000
Received: by yxk38 with SMTP id 38so833970yxk.2        for <cygwin-patches@cygwin.com>; Wed, 03 Aug 2011 11:41:56 -0700 (PDT)
Received: by 10.91.66.11 with SMTP id t11mr5621463agk.189.1312396916483;        Wed, 03 Aug 2011 11:41:56 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id o14sm838624anc.45.2011.08.03.11.41.54        (version=SSLv3 cipher=OTHER);        Wed, 03 Aug 2011 11:41:55 -0700 (PDT)
Subject: [PATCH] clock_nanosleep(2), round two
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Wed, 03 Aug 2011 18:42:00 -0000
Content-Type: multipart/mixed; boundary="=-kLvqDGdZtxBvRcRlgukW"
Message-ID: <1312396928.7084.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00049.txt.bz2


--=-kLvqDGdZtxBvRcRlgukW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 361

Here's my second attempt at clock_nanosleep(2).  After what we dealt
with in round one, this should be a piece of cake.

http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_nanosleep.html
http://www.kernel.org/doc/man-pages/online/pages/man2/clock_nanosleep.2.html

Patches for winsup/cygwin and winsup/doc, plus a test program, attached.


Yaakov


--=-kLvqDGdZtxBvRcRlgukW
Content-Disposition: attachment; filename="cygwin-clock_nanosleep.patch"
Content-Type: text/x-patch; name="cygwin-clock_nanosleep.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 7828

2011-08-03  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (clock_nanosleep): Export.
	* posix.sgml (std-notimpl): Move clock_nanosleep from here...
	(std-susv4): ... to here.
	(std-notes): Note limitations of clock_nanosleep.
	* signal.cc (clock_nanosleep): Renamed from nanosleep, adding clock_id
	and flags arguments and changing return values throughout.
	Improve checks for illegal rqtp values.  Add support for
	CLOCK_MONOTONIC and TIMER_ABSTIME.
	(nanosleep): Rewrite in terms of clock_nanosleep.
	(sleep): Ditto.
	(usleep): Ditto.
	* thread.cc: Mark clock_nanosleep in list of cancellation points.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.245
diff -u -p -r1.245 cygwin.din
--- cygwin.din	21 Jul 2011 09:39:21 -0000	1.245
+++ cygwin.din	3 Aug 2011 17:56:20 -0000
@@ -223,6 +223,7 @@ _clock = clock SIGFE
 clock_getcpuclockid SIGFE
 clock_getres SIGFE
 clock_gettime SIGFE
+clock_nanosleep SIGFE
 clock_setres SIGFE
 clock_settime SIGFE
 clog NOSIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.69
diff -u -p -r1.69 posix.sgml
--- posix.sgml	21 Jul 2011 09:39:21 -0000	1.69
+++ posix.sgml	3 Aug 2011 17:56:20 -0000
@@ -92,6 +92,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     clock_getcpuclockid
     clock_getres
     clock_gettime
+    clock_nanosleep		(see chapter "Implementation Notes")
     clock_settime		(see chapter "Implementation Notes")
     clog
     clogf
@@ -1299,7 +1300,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     ceill
     cexpl
     cimagl
-    clock_nanosleep
     clogl
     conjl
     copysignl
@@ -1446,8 +1446,10 @@ by keeping track of the current root and
 related function calls.  A real chroot functionality is not supported by
 Windows however.</para>
 
-<para><function>clock_setres</function>, <function>clock_settime</function>,
-and <function>timer_create</function> only support CLOCK_REALTIME.</para>
+<para><function>clock_nanosleep</function> currently supports only
+CLOCK_REALTIME and CLOCK_MONOTONIC.  <function>clock_setres</function>,
+<function>clock_settime</function>, and <function>timer_create</function>
+currently support only CLOCK_REALTIME.</para>
 
 <para>BSD file locks created via <function>flock</function> are not
 propagated to the parent process and sibling processes.  The locks are
Index: signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.99
diff -u -p -r1.99 signal.cc
--- signal.cc	3 Aug 2011 16:40:47 -0000	1.99
+++ signal.cc	3 Aug 2011 17:56:20 -0000
@@ -81,52 +81,104 @@ signal (int sig, _sig_func_ptr func)
 }
 
 extern "C" int
-nanosleep (const struct timespec *rqtp, struct timespec *rmtp)
+clock_nanosleep (clockid_t clk_id, int flags, const struct timespec *rqtp,
+		 struct timespec *rmtp)
 {
+  const bool abstime = (flags & TIMER_ABSTIME) ? true : false;
   int res = 0;
   sig_dispatch_pending ();
   pthread_testcancel ();
 
-  if ((unsigned int) rqtp->tv_nsec > 999999999)
+  if (rqtp->tv_sec < 0 || rqtp->tv_nsec < 0 || rqtp->tv_nsec > 999999999L)
+    return EINVAL;
+
+  /* Explicitly disallowed by POSIX. Needs to be checked first to avoid
+     being caught by the following test. */
+  if (clk_id == CLOCK_THREAD_CPUTIME_ID)
+    return EINVAL;
+
+  /* support for CPU-time clocks is optional */
+  if (CLOCKID_IS_PROCESS (clk_id) || CLOCKID_IS_THREAD (clk_id))
+    return ENOTSUP;
+
+  switch (clk_id)
     {
-      set_errno (EINVAL);
-      return -1;
+    case CLOCK_REALTIME:
+    case CLOCK_MONOTONIC:
+      break;
+    default:
+      /* unknown or illegal clock ID */
+      return EINVAL;
     }
+
   LARGE_INTEGER timeout;
 
   timeout.QuadPart = (LONGLONG) rqtp->tv_sec * NSPERSEC
 		     + ((LONGLONG) rqtp->tv_nsec + 99LL) / 100LL;
-  timeout.QuadPart *= -1LL;
 
-  syscall_printf ("nanosleep (%ld.%09ld)", rqtp->tv_sec, rqtp->tv_nsec);
+  if (abstime)
+    {
+      struct timespec tp;
+
+      clock_gettime (clk_id, &tp);
+      /* Check for immediate timeout */
+      if (tp.tv_sec > rqtp->tv_sec
+          || (tp.tv_sec == rqtp->tv_sec && tp.tv_nsec > rqtp->tv_nsec))
+	return 0;
+
+      if (clk_id == CLOCK_REALTIME)
+	timeout.QuadPart += FACTOR;
+      else
+	{
+	  /* other clocks need to be handled with a relative timeout */
+	  timeout.QuadPart -= tp.tv_sec * NSPERSEC + tp.tv_nsec / 100LL;
+	  timeout.QuadPart *= -1LL;
+	}
+    }
+  else /* !abstime */
+    timeout.QuadPart *= -1LL;
+
+  syscall_printf ("clock_nanosleep (%ld.%09ld)", rqtp->tv_sec, rqtp->tv_nsec);
 
   int rc = cancelable_wait (signal_arrived, &timeout);
   if (rc == WAIT_OBJECT_0)
     {
       _my_tls.call_signal_handler ();
-      set_errno (EINTR);
-      res = -1;
+      res = EINTR;
     }
 
-  if (rmtp)
+  /* according to POSIX, rmtp is used only if !abstime */
+  if (rmtp && !abstime)
     {
       rmtp->tv_sec = (time_t) (timeout.QuadPart / NSPERSEC);
       rmtp->tv_nsec = (long) ((timeout.QuadPart % NSPERSEC) * 100LL);
     }
 
-  syscall_printf ("%d = nanosleep (%ld.%09ld, %ld.%09.ld)", res, rqtp->tv_sec,
-		  rqtp->tv_nsec, rmtp ? rmtp->tv_sec : 0,
-		  rmtp ? rmtp->tv_nsec : 0);
+  syscall_printf ("%d = clock_nanosleep (%lu, %d, %ld.%09ld, %ld.%09.ld)",
+		  res, clk_id, flags, rqtp->tv_sec, rqtp->tv_nsec,
+		  rmtp ? rmtp->tv_sec : 0, rmtp ? rmtp->tv_nsec : 0);
   return res;
 }
 
+extern "C" int
+nanosleep (const struct timespec *rqtp, struct timespec *rmtp)
+{
+  int res = clock_nanosleep (CLOCK_REALTIME, 0, rqtp, rmtp);
+  if (res != 0)
+    {
+      set_errno (res);
+      return -1;
+    }
+  return 0;
+}
+
 extern "C" unsigned int
 sleep (unsigned int seconds)
 {
   struct timespec req, rem;
   req.tv_sec = seconds;
   req.tv_nsec = 0;
-  if (nanosleep (&req, &rem))
+  if (clock_nanosleep (CLOCK_REALTIME, 0, &req, &rem))
     return rem.tv_sec + (rem.tv_nsec > 0);
   return 0;
 }
@@ -137,8 +189,13 @@ usleep (useconds_t useconds)
   struct timespec req;
   req.tv_sec = useconds / 1000000;
   req.tv_nsec = (useconds % 1000000) * 1000;
-  int res = nanosleep (&req, NULL);
-  return res;
+  int res = clock_nanosleep (CLOCK_REALTIME, 0, &req, NULL);
+  if (res != 0)
+    {
+      set_errno (res);
+      return -1;
+    }
+  return 0;
 }
 
 extern "C" int
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.245
diff -u -p -r1.245 thread.cc
--- thread.cc	3 Aug 2011 16:40:47 -0000	1.245
+++ thread.cc	3 Aug 2011 17:56:20 -0000
@@ -577,7 +577,7 @@ pthread::cancel ()
 
     * accept ()
     o aio_suspend ()
-    o clock_nanosleep ()
+    * clock_nanosleep ()
     * close ()
     * connect ()
     * creat ()
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.350
diff -u -p -r1.350 version.h
--- include/cygwin/version.h	21 Jul 2011 09:39:22 -0000	1.350
+++ include/cygwin/version.h	3 Aug 2011 17:56:20 -0000
@@ -418,12 +418,13 @@ details. */
 	   error_print_progname.
       248: Export __fpurge.
       249: Export pthread_condattr_getclock, pthread_condattr_setclock.
+      250: Export clock_nanosleep.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 249
+#define CYGWIN_VERSION_API_MINOR 250
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-kLvqDGdZtxBvRcRlgukW
Content-Disposition: attachment; filename="doc-clock_nanosleep.patch"
Content-Type: text/x-patch; name="doc-clock_nanosleep.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 909

2011-08-03  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document new POSIX Clock Selection
	option APIs.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.87
diff -u -p -r1.87 new-features.sgml
--- new-features.sgml	20 Jul 2011 01:19:53 -0000	1.87
+++ new-features.sgml	20 Jul 2011 10:41:00 -0000
@@ -41,6 +41,11 @@ pthread_attr_setstackaddr, pthread_attr_
 </para></listitem>
 
 <listitem><para>
+POSIX Clock Selection option.  New APIs: clock_nanosleep,
+pthread_condattr_getclock, pthread_condattr_setclock.
+</para></listitem>
+
+<listitem><para>
 clock_gettime(3) and clock_getres(3) accept per-process and per-thread CPU-time
 clocks, including CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
 New APIs: clock_getcpuclockid, pthread_getcpuclockid.

--=-kLvqDGdZtxBvRcRlgukW
Content-Disposition: attachment; filename="nanosleep-test.c"
Content-Type: text/x-csrc; name="nanosleep-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2114

#pragma CCOD:script no
#pragma CCOD:options -lrt

#define _XOPEN_SOURCE 600
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifdef __CYGWIN__
#include <dlfcn.h>
int (*clock_nanosleep) (clockid_t, int, const struct timespec *, struct timespec *);
#endif

int
mysleep (clockid_t clk_id, int flags, struct timespec *rqtp, struct timespec *rmtp)
{
  struct timespec now;
  int res;

  clock_gettime (CLOCK_REALTIME, &now);
  printf ("Start: %s", asctime (localtime (&now.tv_sec)));

  res = clock_nanosleep (clk_id, flags, rqtp, rmtp);

  clock_gettime (CLOCK_REALTIME, &now);
  printf ("End:   %s\n", asctime (localtime (&now.tv_sec)));

  return res;
}

void
mysleep_err (clockid_t clk_id, int flags, struct timespec *rqtp, struct timespec *rmtp)
{
  int res = clock_nanosleep (clk_id, flags, rqtp, rmtp);
  printf ("%s\n", strerror (res));
}

int
main (void)
{
  struct timespec tp;
  int res;

#ifdef __CYGWIN__
  clock_nanosleep = dlsym (dlopen ("cygwin1.dll", 0), "clock_nanosleep");
#endif

  tp.tv_sec = 2;
  tp.tv_nsec = 500000000;
  res = mysleep (CLOCK_REALTIME, 0, &tp, NULL);
  if (res)
    goto done;

  clock_gettime (CLOCK_REALTIME, &tp);
  tp.tv_sec += 2;
  res = mysleep (CLOCK_REALTIME, TIMER_ABSTIME, &tp, NULL);
  if (res)
    goto done;

  clock_gettime (CLOCK_MONOTONIC, &tp);
  tp.tv_sec += 2;
  res = mysleep (CLOCK_MONOTONIC, TIMER_ABSTIME, &tp, NULL);
  if (res)
    goto done;

  tp.tv_sec = 2;
  tp.tv_nsec = 500000000;
  res = mysleep (CLOCK_MONOTONIC, 0, &tp, NULL);
  if (res)
    goto done;

  clock_gettime (CLOCK_REALTIME, &tp);
  tp.tv_sec--;
  mysleep_err (CLOCK_REALTIME, TIMER_ABSTIME, &tp, NULL);

  tp.tv_sec = -1;
  tp.tv_nsec = 500000000;
  mysleep_err (CLOCK_REALTIME, 0, &tp, NULL);

  tp.tv_sec = 1;
  tp.tv_nsec = -500000000;
  mysleep_err (CLOCK_REALTIME, 0, &tp, NULL);

  tp.tv_sec = 0;
  tp.tv_nsec = 500000000;
#ifdef CLOCK_PROCESS_CPUTIME_ID
  mysleep_err (CLOCK_PROCESS_CPUTIME_ID, 0, &tp, NULL);
#endif
#ifdef CLOCK_THREAD_CPUTIME_ID
  mysleep_err (CLOCK_THREAD_CPUTIME_ID, 0, &tp, NULL);
#endif
  mysleep_err (-1, 0, &tp, NULL);

done:
  return res;
}

--=-kLvqDGdZtxBvRcRlgukW--

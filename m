Return-Path: <cygwin-patches-return-6750-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27546 invoked by alias); 9 Oct 2009 03:24:07 -0000
Received: (qmail 27523 invoked by uid 22791); 9 Oct 2009 03:24:05 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta07.emeryville.ca.mail.comcast.net (HELO QMTA07.emeryville.ca.mail.comcast.net) (76.96.30.64)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 09 Oct 2009 03:23:59 +0000
Received: from OMTA06.emeryville.ca.mail.comcast.net ([76.96.30.51]) 	by QMTA07.emeryville.ca.mail.comcast.net with comcast 	id qSpq1c00216AWCUA7TPzSv; Fri, 09 Oct 2009 03:23:59 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA06.emeryville.ca.mail.comcast.net with comcast 	id qTPw1c0030Lg2Gw8STPyu7; Fri, 09 Oct 2009 03:23:59 +0000
Message-ID: <4ACEACBA.4030904@byu.net>
Date: Fri, 09 Oct 2009 03:24:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: utimensat UTIME_NOW granularity bug
References: <loom.20091008T221131-292@post.gmane.org> <20091008212425.GB2068@ednor.casa.cgf.cx>
In-Reply-To: <20091008212425.GB2068@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------030002090506070306060900"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00081.txt.bz2

This is a multi-part message in MIME format.
--------------030002090506070306060900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1792

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 10/8/2009 3:24 PM:
>> I think we need to implement a companion to systime(), which returns the system 
>> time without any truncation, so that the function clock_gettime(CLOCK_REALTIME) 
>> can report time with resolution to the 10th of a microsecond rather than to 
>> plain microseconds.  Then utimensat needs to use clock_gettime rather than 
>> gettimeofday, so that it is not needlessly truncating the 10th of microsecond 
>> resolution available from Windows.
> 
> Why not send these type of musings to the cygwin-developers list?  It really
> is more appropriate for this type of discussion.

Sorry about the wrong list.  At any rate, what about this patch?

2009-10-08  Eric Blake  <ebb9@byu.net>

	* hires.h (hires_ms): Change initime_us to initime_ns, with 10x
	more resolution.
	(hires_ms::nsecs): New prototype.
	(hires_ms::usecs, hires_ms::msecs, hires_ms::uptime): Adjust.
	* times.cc (NSPERMS, MILLION, BILLION): New helper macros; use
	throughout to avoid long runs of 0.
	(systime_ns): New helper function.
	(hires_ms::prime): Use it for more resolution.
	(hires_ms::usecs): Change to...
	(hires_ms::nsecs): ...with more resolution.
	(clock_gettime): Use more resolution.
	* fhandler_disk_file.cc (utimens_fs): Get current time before
	opening handle, using higher resolution.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrOrLcACgkQ84KuGfSFAYDtcwCfRjSI0jqSvLb+TDcy/Exir4UP
edAAoKYrSYJoqLY9pfQmcLe3eedH8bas
=tgjw
-----END PGP SIGNATURE-----

--------------030002090506070306060900
Content-Type: text/plain;
 name="cygwin.patch30"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch30"
Content-length: 7458

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 1e6a781..eb40d05 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1282,6 +1282,22 @@ fhandler_base::utimens_fs (const struct timespec *tvp)
   struct timespec tmp[2];
   bool closeit = false;

+  clock_gettime (CLOCK_REALTIME, &timeofday);
+  if (!tvp)
+    tmp[1] = tmp[0] = timeofday;
+  else
+    {
+      if ((tvp[0].tv_nsec < UTIME_NOW || tvp[0].tv_nsec > 999999999L)
+	  || (tvp[1].tv_nsec < UTIME_NOW || tvp[1].tv_nsec > 999999999L))
+	{
+	  set_errno (EINVAL);
+	  return -1;
+	}
+      tmp[0] = (tvp[0].tv_nsec == UTIME_NOW) ? timeofday : tvp[0];
+      tmp[1] = (tvp[1].tv_nsec == UTIME_NOW) ? timeofday : tvp[1];
+    }
+  debug_printf ("incoming lastaccess %08x %08x", tmp[0].tv_sec, tmp[0].tv_nsec);
+
   if (!get_handle ())
     {
       query_open (query_write_attributes);
@@ -1301,25 +1317,6 @@ fhandler_base::utimens_fs (const struct timespec *tvp)
       closeit = true;
     }

-  gettimeofday (reinterpret_cast<struct timeval *> (&timeofday), 0);
-  timeofday.tv_nsec *= 1000;
-  if (!tvp)
-    tmp[1] = tmp[0] = timeofday;
-  else
-    {
-      if ((tvp[0].tv_nsec < UTIME_NOW || tvp[0].tv_nsec > 999999999L)
-	  || (tvp[1].tv_nsec < UTIME_NOW || tvp[1].tv_nsec > 999999999L))
-	{
-	  if (closeit)
-	    close_fs ();
-	  set_errno (EINVAL);
-	  return -1;
-	}
-      tmp[0] = (tvp[0].tv_nsec == UTIME_NOW) ? timeofday : tvp[0];
-      tmp[1] = (tvp[1].tv_nsec == UTIME_NOW) ? timeofday : tvp[1];
-    }
-  debug_printf ("incoming lastaccess %08x %08x", tmp[0].tv_sec, tmp[0].tv_nsec);
-
   IO_STATUS_BLOCK io;
   FILE_BASIC_INFORMATION fbi;

diff --git a/winsup/cygwin/hires.h b/winsup/cygwin/hires.h
index 3c7bd27..e91df06 100644
--- a/winsup/cygwin/hires.h
+++ b/winsup/cygwin/hires.h
@@ -1,6 +1,6 @@
 /* hires.h: Definitions for hires clock calculations

-   Copyright 2002, 2003, 2004, 2005 Red Hat, Inc.
+   Copyright 2002, 2003, 2004, 2005, 2009 Red Hat, Inc.

 This file is part of Cygwin.

@@ -39,14 +39,15 @@ class hires_us : hires_base

 class hires_ms : hires_base
 {
-  LONGLONG initime_us;
+  LONGLONG initime_ns;
   void prime ();
  public:
-  LONGLONG usecs ();
-  LONGLONG msecs () {return usecs () / 1000LL;}
+  LONGLONG nsecs ();
+  LONGLONG usecs () {return nsecs () / 10LL;}
+  LONGLONG msecs () {return nsecs () / 10000LL;}
   UINT dmsecs () { return timeGetTime (); }
   UINT resolution ();
-  LONGLONG uptime () {return (usecs () - initime_us) / 1000LL;}
+  LONGLONG uptime () {return (nsecs () - initime_ns) / 10000LL;}
 };

 extern hires_ms gtod;
diff --git a/winsup/cygwin/times.cc b/winsup/cygwin/times.cc
index f89a72a..ceb6a28 100644
--- a/winsup/cygwin/times.cc
+++ b/winsup/cygwin/times.cc
@@ -26,7 +26,10 @@ details. */
 #include "ntdll.h"

 #define FACTOR (0x19db1ded53e8000LL)
-#define NSPERSEC 10000000LL
+#define NSPERMS       10000LL /* 100ns ticks per millisecond */
+#define MILLION     1000000LL /* microseconds per second */
+#define NSPERSEC   10000000LL /* 100ns ticks per second */
+#define BILLION  1000000000LL /* nanoseconds per second */

 static inline LONGLONG
 systime ()
@@ -41,6 +44,18 @@ systime ()
   return x.QuadPart;
 }

+static inline LONGLONG
+systime_ns ()
+{
+  LARGE_INTEGER x;
+  FILETIME ft;
+  GetSystemTimeAsFileTime (&ft);
+  x.HighPart = ft.dwHighDateTime;
+  x.LowPart = ft.dwLowDateTime;
+  x.QuadPart -= FACTOR;		/* Add conversion factor for UNIX vs. Windows base time */
+  return x.QuadPart;
+}
+
 /* Cygwin internal */
 static unsigned long long __stdcall
 __to_clock_t (FILETIME *src, int flag)
@@ -154,8 +169,8 @@ gettimeofday (struct timeval *tv, void *tzvp)
   if (now == (LONGLONG) -1)
     return -1;

-  tv->tv_sec = now / 1000000;
-  tv->tv_usec = now % 1000000;
+  tv->tv_sec = now / MILLION;
+  tv->tv_usec = now % MILLION;

   if (tz != NULL)
     {
@@ -191,7 +206,7 @@ timespec_to_filetime (const struct timespec *time_in, FILETIME *out)
   else
     {
       long long x = time_in->tv_sec * NSPERSEC +
-			    time_in->tv_nsec / (NSPERSEC/100000) + FACTOR;
+			    time_in->tv_nsec / (BILLION / NSPERSEC) + FACTOR;
       out->dwHighDateTime = x >> 32;
       out->dwLowDateTime = x;
     }
@@ -202,7 +217,7 @@ void __stdcall
 timeval_to_filetime (const struct timeval *time_in, FILETIME *out)
 {
   long long x = time_in->tv_sec * NSPERSEC +
-			time_in->tv_usec * (NSPERSEC/1000000) + FACTOR;
+			time_in->tv_usec * (NSPERSEC / MILLION) + FACTOR;
   out->dwHighDateTime = x >> 32;
   out->dwLowDateTime = x;
 }
@@ -228,15 +243,15 @@ timeval_to_timespec (const struct timeval *tvp, struct timespec *tmp)
   tmp[0].tv_nsec = tvp[0].tv_usec * 1000;
   if (tmp[0].tv_nsec < 0)
     tmp[0].tv_nsec = 0;
-  else if (tmp[0].tv_nsec > 999999999)
-    tmp[0].tv_nsec = 999999999;
+  else if (tmp[0].tv_nsec >= BILLION)
+    tmp[0].tv_nsec = BILLION - 1;

   tmp[1].tv_sec = tvp[1].tv_sec;
   tmp[1].tv_nsec = tvp[1].tv_usec * 1000;
   if (tmp[1].tv_nsec < 0)
     tmp[1].tv_nsec = 0;
-  else if (tmp[1].tv_nsec > 999999999)
-    tmp[1].tv_nsec = 999999999;
+  else if (tmp[1].tv_nsec >= BILLION)
+    tmp[1].tv_nsec = BILLION - 1;

   return tmp;
 }
@@ -631,7 +646,7 @@ hires_us::prime ()
     }

   primed_ft.QuadPart = systime ();
-  freq = (double) ((double) 1000000. / (double) ifreq.QuadPart);
+  freq = (double) ((double) (1e6) / (double) ifreq.QuadPart);
   inited = true;
   SetThreadPriority (GetCurrentThread (), priority);
 }
@@ -667,7 +682,7 @@ hires_ms::prime ()
     {
       int priority = GetThreadPriority (GetCurrentThread ());
       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_TIME_CRITICAL);
-      initime_us = systime () - (((LONGLONG) timeGetTime ()) * 1000LL);
+      initime_ns = systime_ns () - (((LONGLONG) timeGetTime ()) * NSPERMS);
       inited = true;
       SetThreadPriority (GetCurrentThread (), priority);
     }
@@ -675,18 +690,18 @@ hires_ms::prime ()
 }

 LONGLONG
-hires_ms::usecs ()
+hires_ms::nsecs ()
 {
   if (!inited)
     prime ();

-  LONGLONG t = systime ();
-  LONGLONG res = initime_us + (((LONGLONG) timeGetTime ()) * 1000LL);
-  if (res < (t - 40000LL))
+  LONGLONG t = systime_ns ();
+  LONGLONG res = initime_ns + (((LONGLONG) timeGetTime ()) * NSPERMS);
+  if (res < (t - 40 * NSPERMS))
     {
       inited = false;
       prime ();
-      res = initime_us + (((LONGLONG) timeGetTime ()) * 1000LL);
+      res = initime_ns + (((LONGLONG) timeGetTime ()) * NSPERMS);
     }
   return res;
 }
@@ -700,12 +715,12 @@ clock_gettime (clockid_t clk_id, struct timespec *tp)
       return -1;
     }

-  LONGLONG now = gtod.usecs ();
+  LONGLONG now = gtod.nsecs ();
   if (now == (LONGLONG) -1)
     return -1;

-  tp->tv_sec = now / 1000000;
-  tp->tv_nsec = (now % 1000000) * 1000;
+  tp->tv_sec = now / NSPERSEC;
+  tp->tv_nsec = (now % NSPERSEC) * (BILLION / NSPERSEC);
   return 0;
 }

@@ -750,7 +765,7 @@ clock_getres (clockid_t clk_id, struct timespec *tp)
   DWORD period = gtod.resolution ();

   tp->tv_sec = period / 1000;
-  tp->tv_nsec = (period % 1000) * 1000000;
+  tp->tv_nsec = (period % 1000) * MILLION;

   return 0;
 }
@@ -768,7 +783,7 @@ clock_setres (clockid_t clk_id, struct timespec *tp)
   if (period_set)
     timeEndPeriod (minperiod);

-  DWORD period = (tp->tv_sec * 1000) + ((tp->tv_nsec) / 1000000);
+  DWORD period = (tp->tv_sec * 1000) + ((tp->tv_nsec) / MILLION);

   if (timeBeginPeriod (period))
     {
-- 
1.6.5.rc1


--------------030002090506070306060900--

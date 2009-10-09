Return-Path: <cygwin-patches-return-6754-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6341 invoked by alias); 9 Oct 2009 12:46:15 -0000
Received: (qmail 6330 invoked by uid 22791); 9 Oct 2009 12:46:14 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta07.emeryville.ca.mail.comcast.net (HELO QMTA07.emeryville.ca.mail.comcast.net) (76.96.30.64)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 09 Oct 2009 12:46:10 +0000
Received: from OMTA03.emeryville.ca.mail.comcast.net ([76.96.30.27]) 	by QMTA07.emeryville.ca.mail.comcast.net with comcast 	id qcCk1c0060b6N64A7cm95p; Fri, 09 Oct 2009 12:46:09 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA03.emeryville.ca.mail.comcast.net with comcast 	id qcm71c00C0Lg2Gw8Pcm8Lt; Fri, 09 Oct 2009 12:46:09 +0000
Message-ID: <4ACF307F.1040604@byu.net>
Date: Fri, 09 Oct 2009 12:46:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: utimensat UTIME_NOW granularity bug
References: <loom.20091008T221131-292@post.gmane.org>  <20091008212425.GB2068@ednor.casa.cgf.cx>  <4ACEACBA.4030904@byu.net> <20091009045800.GA17335@ednor.casa.cgf.cx>
In-Reply-To: <20091009045800.GA17335@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------050403040901020005080804"
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
X-SW-Source: 2009-q4/txt/msg00085.txt.bz2

This is a multi-part message in MIME format.
--------------050403040901020005080804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2721

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 10/8/2009 10:58 PM:
> 
> I don't like "MILLION" or "BILLION".  I think a real number is clearer
> for that.  Maybe it's jsut me but when I see million I can't help myself
> from checking to see if it's 1000000 or 1024*1024.  And, if you're going
> to assign constants to 1 with a bunch of zeros where do you draw the
> line?

OK, here's the respin without the churn.

> 
> It looks like you either don't need the systime() call or it should
> call systime_ns.

Done.  hires_us still uses systime().

> 
>>       long long x = time_in->tv_sec * NSPERSEC +
>> -			    time_in->tv_nsec / (NSPERSEC/100000) + FACTOR;
>> +			    time_in->tv_nsec / (BILLION / NSPERSEC) + FACTOR;
> 
> I'm too tired now to figure out why you switched these but it seems
> odd that you switched the numerator and denominator  here but
> 
>>   long long x = time_in->tv_sec * NSPERSEC +
>> -			time_in->tv_usec * (NSPERSEC/1000000) + FACTOR;
>> +			time_in->tv_usec * (NSPERSEC / MILLION) + FACTOR;

Because the number 100000 is unrelated to anything else in this file; just
because NSPERSEC/1000000 gives the right answer doesn't mean it expresses
the right equation.  We are really calculating these two values:

tv_nsec / 100 (nsecs) - scaling down
tv_nsec * 10 (usecs) - scaling up

so that x will be in terms of 100ns ticks.  The relations should be:

/ 100 = 1000000000/NSPERSEC = 1000000000/10000000
*  10 =   NSPERSEC/1000000  =   10000000/1000000

since NSPERSEC falls in between nanoseconds and microseconds.

(By the way, I love git - it makes it very easy to rebase a patch against
CVS).

2009-10-09  Eric Blake  <ebb9@byu.net>

	* hires.h (hires_ms): Change initime_us to initime_ns, with 10x
	more resolution.
	(hires_ms::nsecs): New prototype.
	(hires_ms::usecs, hires_ms::msecs, hires_ms::uptime): Adjust.
	* times.cc (systime_ns): New helper function.
	(hires_ms::prime): Use it for more resolution.
	(hires_ms::usecs): Change to...
	(hires_ms::nsecs): ...with more resolution.
	(clock_gettime): Use more resolution.
	(systime): Rewrite in terms of systime_ns.
	(timespec_to_filetime): Rewrite math to reflect true operation.
	* fhandler_disk_file.cc (utimens_fs): Get current time before
	opening handle, using higher resolution.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrPMH8ACgkQ84KuGfSFAYA9jgCfa+431ch8i/qqCgFFNMgqCUy2
6qYAoJhUWLC0DNaRawytPNM+LYpzixCm
=3A7g
-----END PGP SIGNATURE-----

--------------050403040901020005080804
Content-Type: text/plain;
 name="cygwin.patch30"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch30"
Content-length: 5146

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
index f89a72a..573c4c0 100644
--- a/winsup/cygwin/times.cc
+++ b/winsup/cygwin/times.cc
@@ -29,7 +29,7 @@ details. */
 #define NSPERSEC 10000000LL

 static inline LONGLONG
-systime ()
+systime_ns ()
 {
   LARGE_INTEGER x;
   FILETIME ft;
@@ -37,10 +37,15 @@ systime ()
   x.HighPart = ft.dwHighDateTime;
   x.LowPart = ft.dwLowDateTime;
   x.QuadPart -= FACTOR;		/* Add conversion factor for UNIX vs. Windows base time */
-  x.QuadPart /= 10;		/* Convert to microseconds */
   return x.QuadPart;
 }

+static inline LONGLONG
+systime ()
+{
+  return systime_ns () / 10;
+}
+
 /* Cygwin internal */
 static unsigned long long __stdcall
 __to_clock_t (FILETIME *src, int flag)
@@ -191,7 +196,7 @@ timespec_to_filetime (const struct timespec *time_in, FILETIME *out)
   else
     {
       long long x = time_in->tv_sec * NSPERSEC +
-			    time_in->tv_nsec / (NSPERSEC/100000) + FACTOR;
+			    time_in->tv_nsec / (1000000000/NSPERSEC) + FACTOR;
       out->dwHighDateTime = x >> 32;
       out->dwLowDateTime = x;
     }
@@ -667,7 +672,7 @@ hires_ms::prime ()
     {
       int priority = GetThreadPriority (GetCurrentThread ());
       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_TIME_CRITICAL);
-      initime_us = systime () - (((LONGLONG) timeGetTime ()) * 1000LL);
+      initime_ns = systime_ns () - (((LONGLONG) timeGetTime ()) * 10000LL);
       inited = true;
       SetThreadPriority (GetCurrentThread (), priority);
     }
@@ -675,18 +680,18 @@ hires_ms::prime ()
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
+  LONGLONG res = initime_ns + (((LONGLONG) timeGetTime ()) * 10000LL);
+  if (res < (t - 40 * 10000LL))
     {
       inited = false;
       prime ();
-      res = initime_us + (((LONGLONG) timeGetTime ()) * 1000LL);
+      res = initime_ns + (((LONGLONG) timeGetTime ()) * 10000LL);
     }
   return res;
 }
@@ -700,12 +705,12 @@ clock_gettime (clockid_t clk_id, struct timespec *tp)
       return -1;
     }

-  LONGLONG now = gtod.usecs ();
+  LONGLONG now = gtod.nsecs ();
   if (now == (LONGLONG) -1)
     return -1;

-  tp->tv_sec = now / 1000000;
-  tp->tv_nsec = (now % 1000000) * 1000;
+  tp->tv_sec = now / NSPERSEC;
+  tp->tv_nsec = (now % NSPERSEC) * (1000000000 / NSPERSEC);
   return 0;
 }

-- 
1.6.5.rc1


--------------050403040901020005080804--

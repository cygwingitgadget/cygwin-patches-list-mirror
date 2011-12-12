Return-Path: <cygwin-patches-return-7562-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19022 invoked by alias); 12 Dec 2011 22:58:07 -0000
Received: (qmail 19012 invoked by uid 22791); 12 Dec 2011 22:58:06 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_BG
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f43.google.com (HELO mail-bw0-f43.google.com) (209.85.214.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 12 Dec 2011 22:57:53 +0000
Received: by bkbzs2 with SMTP id zs2so7317010bkb.2        for <cygwin-patches@cygwin.com>; Mon, 12 Dec 2011 14:57:52 -0800 (PST)
Received: by 10.180.19.138 with SMTP id f10mr23912014wie.53.1323730672275;        Mon, 12 Dec 2011 14:57:52 -0800 (PST)
Received: from [192.168.2.99] (cpc3-cmbg8-0-0-cust629.5-4.cable.virginmedia.com. [82.6.102.118])        by mx.google.com with ESMTPS id d17sm24632163wbh.19.2011.12.12.14.57.50        (version=SSLv3 cipher=OTHER);        Mon, 12 Dec 2011 14:57:51 -0800 (PST)
Message-ID: <4EE686D5.3080905@gmail.com>
Date: Mon, 12 Dec 2011 22:58:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch,1.7.10] clock_setres returns zero
Content-Type: multipart/mixed; boundary="------------070803030209040008060901"
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
X-SW-Source: 2011-q4/txt/msg00052.txt.bz2

This is a multi-part message in MIME format.
--------------070803030209040008060901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2506


    Hi folks,

  I actually noticed this in 1.7.9, but looking at the source in CVS I can see
it's still present in 1.7.10.  Here's the STC:

> $ cat clockres.c

#include <stdio.h>
#include <time.h>
#include <errno.h>

int main (int argc, const char **argv)
{
  struct timespec ts;
  if (clock_getres (CLOCK_MONOTONIC, &ts) < 0)
  {
    fprintf (stderr, "Bad: %d\n", errno);
    return -1;
  }
  printf ("%ld sec, %ld nanos\n", ts.tv_sec, ts.tv_nsec);
  return 0;
}

> $ gcc-4 clockres.c -o clockres -W -Wall -Wextra
> clockres.c: In function 'main':
> clockres.c:6:15: warning: unused parameter 'argc'
> clockres.c:6:34: warning: unused parameter 'argv'
> 
> $ ./clockres.exe
> 0 sec, 0 nanos
> 
> $

  This happens because on my PC, QueryPerformanceFrequency returns 2511600000,
so the following code in times.cc#hires_ns::prime()

>   freq = (double) ((double) 1000000000. / (double) ifreq.QuadPart);

calculates freq correctly(*) as 0.39815257206561555.  This means that the
resolution is less than a nanosecond, so hires_ns::resolution(), which is
where clock_getres gets the result from, ...

> LONGLONG
> hires_ns::resolution ()
> {
>   if (!inited)
>     prime ();
>   if (inited < 0)
>     {
>       set_errno (ENOSYS);
>       return (long long) -1;
>     }
> 
>   return (LONGLONG) freq;
> }

... truncates it to zero.  (The libgfortran testsuite barfs on this.)

  Although the resolution is too small to express in integer nanoseconds,
that's ok when it's used to calculate the actual time, because that is all
done in double precision before being truncated to integer, in
hires_ns::nsecs() here:

>   // FIXME: Use round() here?
>   now.QuadPart = (LONGLONG) (freq * (double) (now.QuadPart - primed_pc.QuadPart));
>   return now.QuadPart;

  So we'll calculate the correct time to the nearest nanosecond anyway.  Since
that's the maximum resolution that we can return in a timespec from
clock_gettime anyway, I think we should just round up resolutions less than
1ns to pretend they're exactly 1ns.

winsup/cygwin/ChangeLog:

	* times.cc (hires_ns::resolution): Don't return less than 1.

  Tested by building the clean sources, copying the DLL and test executable
into a temp dir on their own and invoking it from cmd.exe, patching the source
and rebuilding the DLL, copying the new DLL into the temp dir and rerunning
the testcase to see "0 sec, 1 nanos".  Didn't do a full install though.  OK?

    cheers,
      DaveK
-- 
(*) - Apart from the fact that it's a period, not a frequency!


--------------070803030209040008060901
Content-Type: text/x-c;
 name="clock_getres_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clock_getres_fix.diff"
Content-length: 483

Index: winsup/cygwin/times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.112
diff -p -u -r1.112 times.cc
--- winsup/cygwin/times.cc	3 Dec 2011 21:43:27 -0000	1.112
+++ winsup/cygwin/times.cc	12 Dec 2011 08:23:20 -0000
@@ -718,7 +718,7 @@ hires_ns::resolution ()
       return (long long) -1;
     }
 
-  return (LONGLONG) freq;
+  return (freq <= 1.0) ? 1ll : (LONGLONG) freq;
 }
 
 UINT

--------------070803030209040008060901--

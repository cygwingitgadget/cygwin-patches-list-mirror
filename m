Return-Path: <cygwin-patches-return-6847-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23838 invoked by alias); 20 Nov 2009 14:16:19 -0000
Received: (qmail 23818 invoked by uid 22791); 20 Nov 2009 14:16:14 -0000
X-SWARE-Spam-Status: No, hits=-0.5 required=5.0 	tests=AWL,BAYES_40,HK_OBFDOM,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta08.emeryville.ca.mail.comcast.net (HELO QMTA08.emeryville.ca.mail.comcast.net) (76.96.30.80)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 20 Nov 2009 14:15:23 +0000
Received: from OMTA15.emeryville.ca.mail.comcast.net ([76.96.30.71]) 	by QMTA08.emeryville.ca.mail.comcast.net with comcast 	id 7RU11d0061Y3wxoA8SFNbo; Fri, 20 Nov 2009 14:15:22 +0000
Received: from [192.168.0.104] ([24.10.247.15]) 	by OMTA15.emeryville.ca.mail.comcast.net with comcast 	id 7SFM1d0040Lg2Gw8bSFMG8; Fri, 20 Nov 2009 14:15:22 +0000
Message-ID: <4B06A48C.5050904@byu.net>
Date: Fri, 20 Nov 2009 14:16:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
References: <4B045581.4040301@byu.net> <20091118204709.GA3461@ednor.casa.cgf.cx>
In-Reply-To: <20091118204709.GA3461@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------010200010409060203080703"
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
X-SW-Source: 2009-q4/txt/msg00178.txt.bz2

This is a multi-part message in MIME format.
--------------010200010409060203080703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1050

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 11/18/2009 1:47 PM:
> On Wed, Nov 18, 2009 at 01:13:53PM -0700, Eric Blake wrote:
>> 2009-11-18  Eric Blake  <ebb9@byu.net>
>>
>> 	* signal.cc (nanosleep): Support 'infinite' sleep times.
>> 	(sleep): Avoid uninitialized memory.
> 
> Sorry but, while I agree with the basic idea, this seems like
> unnecessary use of recursion.  It seems like you could accomplish the
> same thing by just putting the cancelable_wait in a for loop.  I think
> adding recursion here obfuscates the function unnecesarily.

How about the following, then?  Same changelog.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAksGpIwACgkQ84KuGfSFAYBvGACggqFBOQYWN1zzy4opgYkvshmi
erIAnirblvNhSsDBd8Ds+3CeRUyea08F
=htPq
-----END PGP SIGNATURE-----

--------------010200010409060203080703
Content-Type: text/plain;
 name="cygwin.patch33"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch33"
Content-length: 3453

Index: signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.88
diff -u -p -r1.88 signal.cc
--- signal.cc	9 Jun 2008 13:45:59 -0000	1.88
+++ signal.cc	20 Nov 2009 14:14:43 -0000
@@ -1,7 +1,7 @@
 /* signal.cc
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
-   2005, 2006, 2007, 2008 Red Hat, Inc.
+   2005, 2006, 2007, 2008, 2009 Red Hat, Inc.
 
    Written by Steve Chamberlain of Cygnus Support, sac@cygnus.com
    Significant changes by Sergey Okhapkin <sos@prospect.com.ru>
@@ -87,33 +87,63 @@ nanosleep (const struct timespec *rqtp, 
   sig_dispatch_pending ();
   pthread_testcancel ();
 
-  if ((unsigned int) rqtp->tv_sec > (HIRES_DELAY_MAX / 1000 - 1)
-      || (unsigned int) rqtp->tv_nsec > 999999999)
+  if ((unsigned int) rqtp->tv_nsec > 999999999)
     {
       set_errno (EINVAL);
       return -1;
     }
+  unsigned int sec = rqtp->tv_sec;
   DWORD resolution = gtod.resolution ();
-  DWORD req = ((rqtp->tv_sec * 1000 + (rqtp->tv_nsec + 999999) / 1000000
-		+ resolution - 1) / resolution) * resolution;
-  DWORD end_time = gtod.dmsecs () + req;
-  syscall_printf ("nanosleep (%ld)", req);
-
-  int rc = cancelable_wait (signal_arrived, req);
+  bool done = false;
+  DWORD req;
   DWORD rem;
-  if ((rem = end_time - gtod.dmsecs ()) > HIRES_DELAY_MAX)
-    rem = 0;
-  if (rc == WAIT_OBJECT_0)
+
+  while (!done)
     {
-      _my_tls.call_signal_handler ();
-      set_errno (EINTR);
-      res = -1;
+      /* Divide user's input into transactions no larger than 49.7
+         days at a time.  */
+      if (sec > HIRES_DELAY_MAX)
+        {
+          req = ((HIRES_DELAY_MAX * 1000 + resolution - 1)
+                 / resolution * resolution);
+          sec -= HIRES_DELAY_MAX;
+        }
+      else
+        {
+          req = ((sec * 1000 + (rqtp->tv_nsec + 999999) / 1000000
+                  + resolution - 1) / resolution) * resolution;
+          sec = 0;
+          done = true;
+        }
+
+      DWORD end_time = gtod.dmsecs () + req;
+      syscall_printf ("nanosleep (%ld)", req);
+
+      int rc = cancelable_wait (signal_arrived, req);
+      if ((rem = end_time - gtod.dmsecs ()) > HIRES_DELAY_MAX)
+        rem = 0;
+      if (rc == WAIT_OBJECT_0)
+        {
+          _my_tls.call_signal_handler ();
+          set_errno (EINTR);
+          res = -1;
+          break;
+        }
     }
 
   if (rmtp)
     {
-      rmtp->tv_sec = rem / 1000;
+      rmtp->tv_sec = sec + rem / 1000;
       rmtp->tv_nsec = (rem % 1000) * 1000000;
+      if (sec)
+        {
+          rmtp->tv_nsec += rqtp->tv_nsec;
+          if (rmtp->tv_nsec >= 1000000000)
+            {
+              rmtp->tv_nsec -= 1000000000;
+              rmtp->tv_sec++;
+            }
+        }
     }
 
   syscall_printf ("%d = nanosleep (%ld, %ld)", res, req, rem);
@@ -126,8 +156,9 @@ sleep (unsigned int seconds)
   struct timespec req, rem;
   req.tv_sec = seconds;
   req.tv_nsec = 0;
-  nanosleep (&req, &rem);
-  return rem.tv_sec + (rem.tv_nsec > 0);
+  if (nanosleep (&req, &rem))
+    return rem.tv_sec + (rem.tv_nsec > 0);
+  return 0;
 }
 
 extern "C" unsigned int
@@ -136,7 +167,7 @@ usleep (useconds_t useconds)
   struct timespec req;
   req.tv_sec = useconds / 1000000;
   req.tv_nsec = (useconds % 1000000) * 1000;
-  int res = nanosleep (&req, 0);
+  int res = nanosleep (&req, NULL);
   return res;
 }
 

--------------010200010409060203080703--

Return-Path: <cygwin-patches-return-6842-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23807 invoked by alias); 18 Nov 2009 20:14:37 -0000
Received: (qmail 23794 invoked by uid 22791); 18 Nov 2009 20:14:36 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0 	tests=AWL,BAYES_20,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta15.emeryville.ca.mail.comcast.net (HELO QMTA15.emeryville.ca.mail.comcast.net) (76.96.27.228)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 Nov 2009 20:13:45 +0000
Received: from OMTA20.emeryville.ca.mail.comcast.net ([76.96.30.87]) 	by QMTA15.emeryville.ca.mail.comcast.net with comcast 	id 6ie71d0041smiN4AFkDlX9; Wed, 18 Nov 2009 20:13:45 +0000
Received: from [192.168.0.104] ([24.10.247.15]) 	by OMTA20.emeryville.ca.mail.comcast.net with comcast 	id 6kDj1d00U0Lg2Gw8gkDkWl; Wed, 18 Nov 2009 20:13:45 +0000
Message-ID: <4B045581.4040301@byu.net>
Date: Wed, 18 Nov 2009 20:14:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: patch: sleep/nanosleep bug
Content-Type: multipart/mixed;  boundary="------------040503010800070709070502"
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
X-SW-Source: 2009-q4/txt/msg00173.txt.bz2

This is a multi-part message in MIME format.
--------------040503010800070709070502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1219

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I see no reason why we can't sleep for more than 49.7 days (not that I
expect many programs to try that, though).  Plus, sleep was reading
uninitialized memory, giving garbage answers.

Here's an example that proves where this matters:
$ (time timeout 2 sleep 49d) 2>&1 | grep sys
sys     0m0.046s
$ (time timeout 2 sleep 50d) 2>&1 | grep sys
sys     0m1.500s

Notice how CPU utilization spikes from nearly 0% to nearly 100% once you
cross 49.7 days, because sleep(1) is now in a super-tight loop of
repeatedly calling nanosleep (which fails), then checking the current time
to see if enough elapsed time has occurred.

2009-11-18  Eric Blake  <ebb9@byu.net>

	* signal.cc (nanosleep): Support 'infinite' sleep times.
	(sleep): Avoid uninitialized memory.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAksEVYEACgkQ84KuGfSFAYCcFgCfU2rkcgCAQ4Ywfv73mJe51AbL
xZsAnRwuA/ybkXvz+3uEQvUzyHjbWk4l
=pH2l
-----END PGP SIGNATURE-----

--------------040503010800070709070502
Content-Type: text/plain;
 name="cygwin.patch33"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch33"
Content-length: 2569

diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index b3654de..4f248bf 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -1,7 +1,7 @@
 /* signal.cc

    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
-   2005, 2006, 2007, 2008 Red Hat, Inc.
+   2005, 2006, 2007, 2008, 2009 Red Hat, Inc.

    Written by Steve Chamberlain of Cygnus Support, sac@cygnus.com
    Significant changes by Sergey Okhapkin <sos@prospect.com.ru>
@@ -87,14 +87,40 @@ nanosleep (const struct timespec *rqtp, struct timespec *rmtp)
   sig_dispatch_pending ();
   pthread_testcancel ();

-  if ((unsigned int) rqtp->tv_sec > (HIRES_DELAY_MAX / 1000 - 1)
-      || (unsigned int) rqtp->tv_nsec > 999999999)
+  if ((unsigned int) rqtp->tv_nsec > 999999999)
     {
       set_errno (EINVAL);
       return -1;
     }
+  /* FIXME - needs help if we ever decide to support 64-bit time_t.  */
+  time_t sec = rqtp->tv_sec;
+  while ((unsigned int) sec > (HIRES_DELAY_MAX / 1000 - 1))
+    {
+      /* Too big for a single transaction.  Repeatedly sleep for
+	 smaller chunks (49.7 days at a time!) until either we get
+	 EINTR or we have slept as long as the user requested
+	 (supposing the universe hasn't burned out yet).  */
+      struct timespec temp = { HIRES_DELAY_MAX / 1000 - 1, 0 };
+      int result = nanosleep (&temp, &temp);
+      sec -= HIRES_DELAY_MAX / 1000 - 1;
+      if (result)
+	{
+	  if (rmtp)
+	    {
+	      rmtp->tv_sec = sec + temp.tv_sec;
+	      rmtp->tv_nsec = rqtp->tv_nsec + temp.tv_nsec;
+	      if (rmtp->tv_nsec >= 1000000000)
+		{
+		  rmtp->tv_sec++;
+		  rmtp->tv_nsec -= 1000000000;
+		}
+	    }
+	  return result;
+	}
+    }
+
   DWORD resolution = gtod.resolution ();
-  DWORD req = ((rqtp->tv_sec * 1000 + (rqtp->tv_nsec + 999999) / 1000000
+  DWORD req = ((sec * 1000 + (rqtp->tv_nsec + 999999) / 1000000
 		+ resolution - 1) / resolution) * resolution;
   DWORD end_time = gtod.dmsecs () + req;
   syscall_printf ("nanosleep (%ld)", req);
@@ -126,8 +152,9 @@ sleep (unsigned int seconds)
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
@@ -136,7 +163,7 @@ usleep (useconds_t useconds)
   struct timespec req;
   req.tv_sec = useconds / 1000000;
   req.tv_nsec = (useconds % 1000000) * 1000;
-  int res = nanosleep (&req, 0);
+  int res = nanosleep (&req, NULL);
   return res;
 }

-- 
1.6.4.2


--------------040503010800070709070502--

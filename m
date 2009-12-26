Return-Path: <cygwin-patches-return-6882-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26237 invoked by alias); 26 Dec 2009 05:13:47 -0000
Received: (qmail 26225 invoked by uid 22791); 26 Dec 2009 05:13:46 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta02.emeryville.ca.mail.comcast.net (HELO QMTA02.emeryville.ca.mail.comcast.net) (76.96.30.24)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 Dec 2009 05:13:40 +0000
Received: from OMTA12.emeryville.ca.mail.comcast.net ([76.96.30.44]) 	by QMTA02.emeryville.ca.mail.comcast.net with comcast 	id Mh9j1d0030x6nqcA2hDflS; Sat, 26 Dec 2009 05:13:39 +0000
Received: from [192.168.0.104] ([24.10.244.244]) 	by OMTA12.emeryville.ca.mail.comcast.net with comcast 	id MhDd1d00D5H651C8YhDfar; Sat, 26 Dec 2009 05:13:39 +0000
Message-ID: <4B359B91.1090109@byu.net>
Date: Sat, 26 Dec 2009 05:13:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: match pty.h to glibc
Content-Type: multipart/mixed;  boundary="------------040909080800000907060800"
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
X-SW-Source: 2009-q4/txt/msg00213.txt.bz2

This is a multi-part message in MIME format.
--------------040909080800000907060800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 876

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

As of glibc 2.8, pty.h now marks the last two arguments of openpty and
forkpty as const.  These functions are not standardized, and we aren't
altering the parameters, so I see no reason why we can't also make the
change.  OK to apply?

2009-12-26  Eric Blake  <ebb9@byu.net>

	* include/pty.h (openpty, forkpty): Mark last two arguments const,
	to match glibc 2.8.
	* libc/bsdlib.cc (openpty, forkpty): Likewise.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAks1m5AACgkQ84KuGfSFAYCTCQCgjmQaM56Acwh0eX9g6+yabGny
jB4An0ziKLGgy+svOXGZT27+sq1dfATn
=l343
-----END PGP SIGNATURE-----

--------------040909080800000907060800
Content-Type: text/plain;
 name="cygwin.patch35"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch35"
Content-length: 1780

From 730f55925137fb0bea116ac5ec3864d86aaa4ac6 Mon Sep 17 00:00:00 2001
From: Eric Blake <ebb9@byu.net>
Date: Fri, 25 Dec 2009 22:09:58 -0700
Subject: [PATCH] change pty.h signatures

---
 winsup/cygwin/ChangeLog      |    6 ++++++
 winsup/cygwin/include/pty.h  |    6 ++++--
 winsup/cygwin/libc/bsdlib.cc |    7 ++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/include/pty.h b/winsup/cygwin/include/pty.h
index e4b4da0..7b92a2b 100644
--- a/winsup/cygwin/include/pty.h
+++ b/winsup/cygwin/include/pty.h
@@ -8,8 +8,10 @@
 extern "C" {
 #endif

-int _EXFUN(openpty ,(int *, int *, char *, struct termios *, struct winsize *));
-int _EXFUN(forkpty ,(int *, char *, struct termios *, struct winsize *));
+int _EXFUN(openpty ,(int *, int *, char *, const struct termios *,
+		     const struct winsize *));
+int _EXFUN(forkpty ,(int *, char *, const struct termios *,
+		     const struct winsize *));

 #ifdef __cplusplus
 }
diff --git a/winsup/cygwin/libc/bsdlib.cc b/winsup/cygwin/libc/bsdlib.cc
index 61797e4..116b246 100644
--- a/winsup/cygwin/libc/bsdlib.cc
+++ b/winsup/cygwin/libc/bsdlib.cc
@@ -97,8 +97,8 @@ login_tty (int fd)
 }

 extern "C" int
-openpty (int *amaster, int *aslave, char *name, struct termios *termp,
-	 struct winsize *winp)
+openpty (int *amaster, int *aslave, char *name, const struct termios *termp,
+	 const struct winsize *winp)
 {
   int master, slave;
   char pts[TTY_NAME_MAX];
@@ -130,7 +130,8 @@ openpty (int *amaster, int *aslave, char *name, struct termios *termp,
 }

 extern "C" int
-forkpty (int *amaster, char *name, struct termios *termp, struct winsize *winp)
+forkpty (int *amaster, char *name, const struct termios *termp,
+	 const struct winsize *winp)
 {
   int master, slave, pid;

-- 
1.6.4.2


--------------040909080800000907060800--

Return-Path: <cygwin-patches-return-6610-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29189 invoked by alias); 3 Sep 2009 19:07:07 -0000
Received: (qmail 29169 invoked by uid 22791); 3 Sep 2009 19:07:04 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_52,J_CHICKENPOX_62,J_CHICKENPOX_82,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta01.emeryville.ca.mail.comcast.net (HELO QMTA01.emeryville.ca.mail.comcast.net) (76.96.30.16)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 03 Sep 2009 19:06:54 +0000
Received: from OMTA12.emeryville.ca.mail.comcast.net ([76.96.30.44]) 	by QMTA01.emeryville.ca.mail.comcast.net with comcast 	id cJla1c0080x6nqcA1K6dVD; Thu, 03 Sep 2009 19:06:37 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA12.emeryville.ca.mail.comcast.net with comcast 	id cK6r1c00L0Lg2Gw8YK6sHK; Thu, 03 Sep 2009 19:06:53 +0000
Message-ID: <4AA013D2.5060702@byu.net>
Date: Thu, 03 Sep 2009 19:07:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fcntl bug
References: <4A8F0944.5020004@byu.net>  <4A8F1819.9060209@sipxx.com>  <4A8F19DC.8060104@byu.net>  <20090822001027.GB8375@ednor.casa.cgf.cx>  <loom.20090824T170139-863@post.gmane.org>  <4A9B1A3B.9070600@byu.net> <20090831005538.GH2068@ednor.casa.cgf.cx>
In-Reply-To: <20090831005538.GH2068@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------060703040707090707090004"
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
X-SW-Source: 2009-q3/txt/msg00064.txt.bz2

This is a multi-part message in MIME format.
--------------060703040707090707090004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1342

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 8/30/2009 6:55 PM:
> On Sun, Aug 30, 2009 at 06:32:59PM -0600, Eric Blake wrote:
>> According to Eric Blake on 8/24/2009 9:15 AM:
>>> While we're at it, fcntl and dup2 both have another minor bug.  POSIX
>>> states that fcntl(0,F_DUPFD,10000000) should fail with EINVAL (not
>>> EBADF) and the similar dup2(0,10000000) should fail with EBADF (not
>>> EMFILE).
>> Ping.  Cygwin is currently failing a test in coreutils' 7.5 testsuite
>> because of this.
> 
> I have no intention of going to the effort of fixing these trivial
> problems.
> 
> If it is important to you then please provide a patch.

2009-09-03  Eric Blake  <ebb9@byu.net>

	* dtable.h (OPEN_MAX_MAX): New macro.
	* resource.cc (getrlimit) [RLIMIT_NOFILE]: Use it.
	* dtable.cc (dtable::extend): Likewise.
	* fcntl.cc (fcntl64): Obey POSIX rules.
	* syscalls.cc (dup2): Likewise.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqgE9IACgkQ84KuGfSFAYC8WgCgxBHm0hPfTe88K6m+pgr3qJVI
hsIAoMIiyeAGI10eC+b7A7eNaPjxUi+G
=Y9VB
-----END PGP SIGNATURE-----

--------------060703040707090707090004
Content-Type: text/plain;
 name="cygwin.patch18"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch18"
Content-length: 2707

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 3789ff5..bf6d6df 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -80,7 +80,7 @@ dtable::extend (int howmuch)
   if (howmuch <= 0)
     return 0;

-  if (new_size > (100 * NOFILE_INCR))
+  if (new_size > OPEN_MAX_MAX)
     {
       set_errno (EMFILE);
       return 0;
diff --git a/winsup/cygwin/dtable.h b/winsup/cygwin/dtable.h
index f685624..6949794 100644
--- a/winsup/cygwin/dtable.h
+++ b/winsup/cygwin/dtable.h
@@ -1,6 +1,6 @@
 /* dtable.h: fd table definition.

-   Copyright 2000, 2001, 2003, 2004, 2005, 2006, 2007, 2008 Red Hat, Inc.
+   Copyright 2000, 2001, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Red Hat, Inc.

 This file is part of Cygwin.

@@ -10,6 +10,8 @@ details. */

 /* Initial and increment values for cygwin's fd table */
 #define NOFILE_INCR    32
+/* Maximum size we allow expanding to.  */
+#define OPEN_MAX_MAX (100 * NOFILE_INCR)

 #include "thread.h"
 #include "sync.h"
diff --git a/winsup/cygwin/fcntl.cc b/winsup/cygwin/fcntl.cc
index 4426862..522f911 100644
--- a/winsup/cygwin/fcntl.cc
+++ b/winsup/cygwin/fcntl.cc
@@ -1,6 +1,7 @@
 /* fcntl.cc: fcntl syscall

-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2008 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2008,
+   2009 Red Hat, Inc.

 This file is part of Cygwin.

@@ -40,7 +41,13 @@ fcntl64 (int fd, int cmd, ...)
   switch (cmd)
     {
     case F_DUPFD:
-      res = dup2 (fd, cygheap_fdnew (((int) arg) - 1));
+      if ((int) arg >= OPEN_MAX_MAX)
+	{
+	  syscall_printf ("%d too large", (int) arg);
+	  set_errno (EINVAL);
+	}
+      else
+	res = dup2 (fd, cygheap_fdnew (((int) arg) - 1));
       break;
     case F_GETLK:
     case F_SETLK:
diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index ee17ac8..9a2acdd 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -143,7 +143,7 @@ getrlimit (int resource, struct rlimit *rlp)
       rlp->rlim_cur = getdtablesize ();
       if (rlp->rlim_cur < OPEN_MAX)
 	rlp->rlim_cur = OPEN_MAX;
-      rlp->rlim_max = 100 * NOFILE_INCR;
+      rlp->rlim_max = OPEN_MAX_MAX;
       break;
     case RLIMIT_CORE:
       rlp->rlim_cur = rlim_core;
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index fb17f1e..3798587 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -124,6 +124,12 @@ dup (int fd)
 int
 dup2 (int oldfd, int newfd)
 {
+  if (newfd >= OPEN_MAX_MAX)
+    {
+      syscall_printf ("-1 = dup2 (%d, %d) (%d too large)", oldfd, newfd, newfd);
+      set_errno (EINVAL);
+      return -1;
+    }
   return cygheap->fdtab.dup2 (oldfd, newfd);
 }


--------------060703040707090707090004--

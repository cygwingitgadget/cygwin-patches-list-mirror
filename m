Return-Path: <cygwin-patches-return-5688-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2687 invoked by alias); 10 Dec 2005 23:31:20 -0000
Received: (qmail 2676 invoked by uid 22791); 10 Dec 2005 23:31:20 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc13.comcast.net (HELO rwcrmhc12.comcast.net) (204.127.198.39)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 10 Dec 2005 23:31:18 +0000
Received: from [192.168.0.100] (c-67-172-242-110.hsd1.ut.comcast.net[67.172.242.110])           by comcast.net (rwcrmhc13) with ESMTP           id <20051210233116015004s8ure>; Sat, 10 Dec 2005 23:31:16 +0000
Message-ID: <439B652C.4010409@byu.net>
Date: Sat, 10 Dec 2005 23:31:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: d_ino deprecated in latest snapshot
References: <20051205212651.GA12440@trixie.casa.cgf.cx> <439B601C.4070207@byu.net> <20051210232558.GA24474@trixie.casa.cgf.cx>
In-Reply-To: <20051210232558.GA24474@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00030.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 12/10/2005 4:25 PM:
> 
> I'll make the change but have you completely given up on the concept of
> "a patch" now?  It seems like you could have tested this pretty easily
> by just making changes to the header and then rectified the behavior
> by submitting a patch.

2005-12-10  Eric Blake  <ebb9@byu.net>

	* include/sys/dirent.h (struct dirent): Deprecate d_ino member.


Index: cygwin/include/sys/dirent.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/dirent.h,v
retrieving revision 1.8
diff -u -p -r1.8 dirent.h
- --- cygwin/include/sys/dirent.h 5 Dec 2005 21:02:53 -0000       1.8
+++ cygwin/include/sys/dirent.h 10 Dec 2005 23:31:00 -0000
@@ -1,6 +1,6 @@
 /* Posix dirent.h for WIN32.

- -   Copyright 2001, 2002, 2003 Red Hat, Inc.
+   Copyright 2001, 2002, 2003, 2005 Red Hat, Inc.

    This software is a copyrighted work licensed under the terms of the
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
@@ -31,7 +31,7 @@ struct dirent
 struct dirent
 {
   long d_version;
- -  ino_t d_ino;
+  ino_t __deprecated_d_ino;
   long d_fd;
   unsigned long __ino32;
   char d_name[256];
@@ -42,7 +42,7 @@ struct dirent
   long d_version;
   long d_reserved[2];
   long d_fd;
- -  ino_t d_ino;
+  ino_t __deprecated_d_ino;
   char d_name[256];
 };
 #endif

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDm2Us84KuGfSFAYARArN0AJkBIjV9Bfa8SKIaPWua3vNg5zjkyACfbnIl
92NVWgVHnwItXoEHjCHq71M=
=uozg
-----END PGP SIGNATURE-----

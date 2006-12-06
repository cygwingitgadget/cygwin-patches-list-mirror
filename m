Return-Path: <cygwin-patches-return-6010-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14420 invoked by alias); 6 Dec 2006 13:26:10 -0000
Received: (qmail 14373 invoked by uid 22791); 6 Dec 2006 13:26:09 -0000
X-Spam-Check-By: sourceware.org
Received: from alnrmhc12.comcast.net (HELO alnrmhc12.comcast.net) (206.18.177.52)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 06 Dec 2006 13:26:02 +0000
Received: from [192.168.0.103] (c-67-186-254-72.hsd1.co.comcast.net[67.186.254.72])           by comcast.net (alnrmhc12) with ESMTP           id <20061206132601b1200t2648e>; Wed, 6 Dec 2006 13:26:01 +0000
Message-ID: <4576C4FB.6010703@byu.net>
Date: Wed, 06 Dec 2006 13:26:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.8) Gecko/20061025 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: get TIOCGWINSZ from <sys/ioctl.h>
Content-Type: multipart/mixed;  boundary="------------010500000200090209020000"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00028.txt.bz2

This is a multi-part message in MIME format.
--------------010500000200090209020000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 923

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Linux:
$ gcc -E - <<\EOF | tail -n 2
> #include<sys/ioctl.h>
> TIOCGWINSZ
> EOF
# 2 "<stdin>" 2
0x5413

On cygwin, prior to this patch:
$ gcc -E - <<\EOF | tail -n 2
> #include<sys/ioctl.h>
> TIOCGWINSZ
> EOF
# 2 "<stdin>" 2
TIOCGWINSZ

Should be safe to apply since neither TIOCGWINSZ nor <sys/ioctl.h> are
specified by POSIX, so we don't have to worry about namespace pollution.

2006-12-06  Eric Blake  <ebb9@byu.net>

	* include/sys/ioctl.h: Pick up termios.h, for TIOCGWINSZ.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdsT684KuGfSFAYARAiJSAKCEzDXdOwAFzVAQ4u5NcOnGg/IG+QCePQYh
XL+447Fbaq1/CovSiaHWdvY=
=mB+V
-----END PGP SIGNATURE-----

--------------010500000200090209020000
Content-Type: text/plain;
 name="cygwin.patch4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch4"
Content-length: 652

Index: cygwin/include/sys/ioctl.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/ioctl.h,v
retrieving revision 1.8
diff -u -p -r1.8 ioctl.h
--- cygwin/include/sys/ioctl.h	12 Aug 2005 02:39:13 -0000	1.8
+++ cygwin/include/sys/ioctl.h	6 Dec 2006 13:22:02 -0000
@@ -1,6 +1,6 @@
 /* sys/ioctl.h
 
-   Copyright 1998, 2001, 2002, 2003, 2004, 2005 Red Hat, Inc.
+   Copyright 1998, 2001, 2002, 2003, 2004, 2005, 2006 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -14,6 +14,7 @@ details. */
 #define _SYS_IOCTL_H
 
 #include <sys/cdefs.h>
+#include <sys/termios.h>
 
 __BEGIN_DECLS
 

--------------010500000200090209020000--

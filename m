Return-Path: <cygwin-patches-return-5906-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7823 invoked by alias); 2 Jul 2006 21:03:01 -0000
Received: (qmail 7813 invoked by uid 22791); 2 Jul 2006 21:03:00 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc13.comcast.net (HELO rwcrmhc13.comcast.net) (216.148.227.153)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 02 Jul 2006 21:02:58 +0000
Received: from [192.168.0.101] (c-24-10-241-225.hsd1.ut.comcast.net[24.10.241.225])           by comcast.net (rwcrmhc13) with ESMTP           id <20060702210256m13006m16je>; Sun, 2 Jul 2006 21:02:57 +0000
Message-ID: <44A8347F.2000206@byu.net>
Date: Sun, 02 Jul 2006 21:03:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Fix UINT{8,16}_C
Content-Type: multipart/mixed;  boundary="------------040904090506060304090904"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00001.txt.bz2

This is a multi-part message in MIME format.
--------------040904090506060304090904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 994

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to POSIX, UINT{8,16}_C should result in an integer constant with
"the same type as would an expression that is an object of the
corresponding type converted according to the integer promotions."  And
according to C, unsigned char promotes to signed int, when int is wider
than char.  Gnulib now tests for bugs in stdint.h, and these are the
remaining two issues that makes cygwin's version non-compliant:

2006-07-02  Eric Blake  <ebb9@byu.net>

	* include/stdint.h (UINT8_C, UINT16_C): Unsigned types smaller
	than int promote to signed int.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqDR/84KuGfSFAYARAnkuAJ9oKW4FEnOVPythNkGLs0Mw0+QQsgCbBwTy
VCM75i+6nr3jYZXs3qrhLZw=
=iYl2
-----END PGP SIGNATURE-----

--------------040904090506060304090904
Content-Type: text/plain;
 name="cygwin.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch2"
Content-length: 747

Index: cygwin/include/stdint.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
retrieving revision 1.6
diff -u -p -r1.6 stdint.h
--- cygwin/include/stdint.h	23 May 2005 13:13:00 -0000	1.6
+++ cygwin/include/stdint.h	2 Jul 2006 21:01:39 -0000
@@ -1,6 +1,6 @@
 /* stdint.h - integer types
 
-   Copyright 2003 Red Hat, Inc.
+   Copyright 2003, 2006 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -169,8 +169,8 @@ typedef unsigned long long uintmax_t;
 #define INT32_C(x) x ## L
 #define INT64_C(x) x ## LL
 
-#define UINT8_C(x) x ## U
-#define UINT16_C(x) x ## U
+#define UINT8_C(x) x
+#define UINT16_C(x) x
 #define UINT32_C(x) x ## UL
 #define UINT64_C(x) x ## ULL
 

--------------040904090506060304090904--

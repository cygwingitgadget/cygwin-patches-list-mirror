Return-Path: <cygwin-patches-return-6458-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23658 invoked by alias); 2 Apr 2009 05:47:26 -0000
Received: (qmail 23627 invoked by uid 22791); 2 Apr 2009 05:47:25 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f123.google.com (HELO mail-qy0-f123.google.com) (209.85.221.123)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 02 Apr 2009 05:47:19 +0000
Received: by qyk29 with SMTP id 29so778457qyk.18         for <cygwin-patches@cygwin.com>; Wed, 01 Apr 2009 22:47:17 -0700 (PDT)
Received: by 10.224.61.11 with SMTP id r11mr7831335qah.252.1238651236950;         Wed, 01 Apr 2009 22:47:16 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.253.194])         by mx.google.com with ESMTPS id 2sm831242qwi.33.2009.04.01.22.47.15         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 01 Apr 2009 22:47:16 -0700 (PDT)
Message-ID: <49D45162.8020805@users.sourceforge.net>
Date: Thu, 02 Apr 2009 05:47:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] <netdb.h> SUSv3 compliance
Content-Type: multipart/mixed;  boundary="------------010505030507030700020003"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------010505030507030700020003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 771

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

SUSv3&4 state:

> Inclusion of the <netdb.h> header may also make visible all symbols
> from <netinet/in.h>, <sys/socket.h>, and <inttypes.h>.

Having come across packages that assume this (at least in part), I would
like to make ours compatible.

<inttypes.h> must #include <stdint.h> per SUSv3, so that should be a
safe switch.  <cygwin/in.h> already has a #include <cygwin/socket.h>,
but I don't know if you want to assume that or not.

Patch attached.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAknUUWIACgkQpiWmPGlmQSMI9ACgkSxq6DAf7aedISjvD7FE1Ocm
AU4AoJ4LRzKDN3IU3bhP2aBwFFysct1Q
=DMTr
-----END PGP SIGNATURE-----

--------------010505030507030700020003
Content-Type: text/x-patch;
 name="cygwin-netdb.h-susv3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-netdb.h-susv3.patch"
Content-length: 692

2009-04-02  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/netdb.h: #include <inttypes.h>, <netinet/in.h>,
	and <sys/socket.h> per SUSv3.


Index: include/netdb.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/netdb.h,v
retrieving revision 1.10
diff -u -r1.10 netdb.h
--- include/netdb.h	1 Feb 2007 15:54:40 -0000	1.10
+++ include/netdb.h	2 Apr 2009 05:46:09 -0000
@@ -63,8 +63,9 @@
 extern "C" {
 #endif
 
-#include <stdint.h>
-#include <cygwin/socket.h>
+#include <inttypes.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
 
 /*
  * Structures returned by network data base library.  All addresses are

--------------010505030507030700020003--

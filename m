Return-Path: <cygwin-patches-return-6449-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13101 invoked by alias); 18 Mar 2009 02:13:32 -0000
Received: (qmail 13090 invoked by uid 22791); 18 Mar 2009 02:13:30 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_31,J_CHICKENPOX_32,J_CHICKENPOX_63,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f178.google.com (HELO mail-bw0-f178.google.com) (209.85.218.178)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 Mar 2009 02:13:24 +0000
Received: by bwz26 with SMTP id 26so354649bwz.2         for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2009 19:13:21 -0700 (PDT)
Received: by 10.103.240.15 with SMTP id s15mr302899mur.102.1237342400885;         Tue, 17 Mar 2009 19:13:20 -0700 (PDT)
Received: from ?192.168.0.101? (S0106001346f94b85.wp.shawcable.net [24.76.249.6])         by mx.google.com with ESMTPS id i5sm1338320mue.13.2009.03.17.19.13.18         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Tue, 17 Mar 2009 19:13:20 -0700 (PDT)
Message-ID: <49C058BC.5000407@users.sourceforge.net>
Date: Wed, 18 Mar 2009 02:13:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: log2, log2f (pending newlib patch)
Content-Type: multipart/mixed;  boundary="------------080700030209070502040607"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00047.txt.bz2

This is a multi-part message in MIME format.
--------------080700030209070502040607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 709

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Corresponding patch just sent to newlib@.  Sending this now as a
headsup; if the version.h patch doesn't apply by the time the newlib
patch is accepted, let me know and I'll respin this.

2009-03-17  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* cygwin.din: Export log2, log2f as functions.
	* posix.sgml: Add them to SUSv4 list.
	* include/cygwin/version.h: Bump API minor number.


Yaakov

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAknAWLwACgkQpiWmPGlmQSNCpACfYtginB1BefTWYc2CaIOj3KKi
SUEAoMn4TF9x5Z+LUTyRPwHO00oxjdU/
=jh8R
-----END PGP SIGNATURE-----

--------------080700030209070502040607
Content-Type: text/x-patch;
 name="cygwin-log2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-log2.patch"
Content-length: 1971

2009-03-17  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* cygwin.din: Export log2, log2f as functions.
	* posix.sgml: Add them to SUSv4 list.
	* include/cygwin/version.h: Bump API minor number.


Index: cygwin/cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.208
diff -u -r1.208 cygwin.din
--- cygwin/cygwin.din	15 Mar 2009 13:45:01 -0000	1.208
+++ cygwin/cygwin.din	18 Mar 2009 01:55:35 -0000
@@ -903,6 +903,8 @@
 _log1p = log1p NOSIGFE
 log1pf NOSIGFE
 _log1pf = log1pf NOSIGFE
+log2 NOSIGFE
+log2f NOSIGFE
 logb NOSIGFE
 _logb = logb NOSIGFE
 logbf NOSIGFE
Index: cygwin/posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.32
diff -u -r1.32 posix.sgml
--- cygwin/posix.sgml	15 Mar 2009 13:45:01 -0000	1.32
+++ cygwin/posix.sgml	18 Mar 2009 01:55:36 -0000
@@ -368,6 +368,8 @@
     log10f
     log1p
     log1pf
+    log2
+    log2f
     logb
     logbf
     logf
Index: cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.291
diff -u -r1.291 version.h
--- cygwin/include/cygwin/version.h	15 Mar 2009 13:45:02 -0000	1.291
+++ cygwin/include/cygwin/version.h	18 Mar 2009 01:55:36 -0000
@@ -356,12 +356,13 @@
       205: Export wscanf, fwscanf, swscanf, vwscanf, vfwscanf, vswscanf.
       206: Export wcscasecmp, wcsncasecmp.
       207: Export wcsdup.
+      208: Export log2, log2f.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 207
+#define CYGWIN_VERSION_API_MINOR 208
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible


--------------080700030209070502040607--

Return-Path: <cygwin-patches-return-6433-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10257 invoked by alias); 12 Mar 2009 05:47:46 -0000
Received: (qmail 10246 invoked by uid 22791); 12 Mar 2009 05:47:45 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_52,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f115.google.com (HELO mail-qy0-f115.google.com) (209.85.221.115)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Mar 2009 05:47:41 +0000
Received: by qyk13 with SMTP id 13so522968qyk.18         for <cygwin-patches@cygwin.com>; Wed, 11 Mar 2009 22:47:38 -0700 (PDT)
Received: by 10.224.67.76 with SMTP id q12mr12514376qai.279.1236836858540;         Wed, 11 Mar 2009 22:47:38 -0700 (PDT)
Received: from ?192.168.0.101? (S0106001346f94b85.wp.shawcable.net [24.76.249.6])         by mx.google.com with ESMTPS id 5sm810625ywd.39.2009.03.11.22.47.37         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 11 Mar 2009 22:47:38 -0700 (PDT)
Message-ID: <49B8A1F8.1030306@users.sourceforge.net>
Date: Thu, 12 Mar 2009 05:47:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: errno.h: ESTRPIPE
Content-Type: multipart/mixed;  boundary="------------070808010905040705020805"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00031.txt.bz2

This is a multi-part message in MIME format.
--------------070808010905040705020805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 459

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Corresponding patch just sent to newlib@.

2009-03-11  Yaakov Selkowitz <yselkowitz@users.sourceforge.net>

	* errno.cc (_sys_errlist): Add ESTRPIPE.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkm4ofgACgkQpiWmPGlmQSMrMACeJvUcrUQDnIrEVoiV58hruydi
Wb4AnRfbMgIVXEuH5qyvsrARXfJfWY7t
=4jCZ
-----END PGP SIGNATURE-----

--------------070808010905040705020805
Content-Type: text/x-patch;
 name="winsup-ESTRPIPE.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="winsup-ESTRPIPE.patch"
Content-length: 690

Index: cygwin/errno.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/errno.cc,v
retrieving revision 1.70
diff -u -r1.70 errno.cc
--- cygwin/errno.cc	16 Jan 2009 12:17:27 -0000	1.70
+++ cygwin/errno.cc	12 Mar 2009 05:42:24 -0000
@@ -287,7 +287,8 @@
 /* EOVERFLOW 139 */	  "Value too large for defined data type",
 /* ECANCELED 140 */	  "Operation canceled",
 /* ENOTRECOVERABLE 141 */ "State not recoverable",
-/* EOWNERDEAD 142 */	  "Previous owner died"
+/* EOWNERDEAD 142 */	  "Previous owner died",
+/* ESTRPIPE 143 */	  "Streams pipe error"
 };
 
 int NO_COPY_INIT _sys_nerr = sizeof (_sys_errlist) / sizeof (_sys_errlist[0]);

--------------070808010905040705020805--

Return-Path: <cygwin-patches-return-6518-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24612 invoked by alias); 27 Apr 2009 03:22:18 -0000
Received: (qmail 24600 invoked by uid 22791); 27 Apr 2009 03:22:17 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.147)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 27 Apr 2009 03:22:12 +0000
Received: by qw-out-1920.google.com with SMTP id 4so1442631qwk.20         for <cygwin-patches@cygwin.com>; Sun, 26 Apr 2009 20:22:10 -0700 (PDT)
Received: by 10.224.67.78 with SMTP id q14mr5193566qai.162.1240802530391;         Sun, 26 Apr 2009 20:22:10 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.253.194])         by mx.google.com with ESMTPS id 26sm5948949qwa.56.2009.04.26.20.22.08         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Sun, 26 Apr 2009 20:22:09 -0700 (PDT)
Message-ID: <49F524DF.9040107@users.sourceforge.net>
Date: Mon, 27 Apr 2009 03:22:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: sys/socket.h: define SOL_IPV6?
Content-Type: multipart/mixed;  boundary="------------030209040609070405000608"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00060.txt.bz2

This is a multi-part message in MIME format.
--------------030209040609070405000608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 381

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Does it make sense to define SOL_IPV6 now?  Patch attached if so.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkn1JN8ACgkQpiWmPGlmQSNx6gCeIIaTkZ1JfkQQ95mJoUtJNBXl
z58AoPudyZ7Xo0yxwggJEwLJEE9UMT9V
=qIUQ
-----END PGP SIGNATURE-----

--------------030209040609070405000608
Content-Type: text/x-patch;
 name="cygwin-socket-SOL_IPV6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-socket-SOL_IPV6.patch"
Content-length: 642

2009-04-26  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/cygwin/socket.h: Define SOL_IPV6.


Index: include/cygwin/socket.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/socket.h,v
retrieving revision 1.26
diff -u -r1.26 socket.h
--- include/cygwin/socket.h	9 Mar 2009 14:40:45 -0000	1.26
+++ include/cygwin/socket.h	27 Apr 2009 03:17:54 -0000
@@ -198,6 +198,7 @@
 
 /* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
 #define SOL_IP		0
+#define SOL_IPV6	41
 #define SOL_IPX		256
 #define SOL_AX25	257
 #define SOL_ATALK	258

--------------030209040609070405000608--

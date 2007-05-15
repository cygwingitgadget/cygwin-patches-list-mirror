Return-Path: <cygwin-patches-return-6081-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30676 invoked by alias); 15 May 2007 00:49:26 -0000
Received: (qmail 30662 invoked by uid 22791); 15 May 2007 00:49:25 -0000
X-Spam-Check-By: sourceware.org
Received: from sccrmhc11.comcast.net (HELO sccrmhc11.comcast.net) (204.127.200.81)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 15 May 2007 00:49:22 +0000
Received: from [192.168.0.103] (c-71-199-58-92.hsd1.ut.comcast.net[71.199.58.92])           by comcast.net (sccrmhc11) with ESMTP           id <20070515004919011005u260e>; Tue, 15 May 2007 00:49:20 +0000
Message-ID: <46490414.7020505@byu.net>
Date: Tue, 15 May 2007 00:49:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.5.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: export a few newlib functions
Content-Type: multipart/mixed;  boundary="------------050705060507030408050605"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00027.txt.bz2

This is a multi-part message in MIME format.
--------------050705060507030408050605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 647

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

As discussed this morning:

2007-05-14  Eric Blake  <ebb9@byu.net>

	* cygwin.din (asnprintf, dprint, _Exit, vasnprintf, vdprintf):
	Export.
	* include/cygwin/version.h: Bump API minor number.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGSQQT84KuGfSFAYARAlSiAKCUTfbe5GdJA2UKCnIA2/UqMKwA8wCfTQl4
MxcJ3HIrDkTwV70mqfY9QOQ=
=SA0B
-----END PGP SIGNATURE-----

--------------050705060507030408050605
Content-Type: text/plain;
 name="cygwin.patch8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch8"
Content-length: 2025

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.171
diff -u -p -r1.171 cygwin.din
--- cygwin.din	20 Feb 2007 15:48:04 -0000	1.171
+++ cygwin.din	15 May 2007 00:44:21 -0000
@@ -112,6 +112,7 @@ asinh NOSIGFE
 _asinh = asinh NOSIGFE
 asinhf NOSIGFE
 _asinhf = asinhf NOSIGFE
+asnprintf SIGFE
 asprintf SIGFE
 _asprintf = asprintf SIGFE
 asprintf_r = _asprintf_r SIGFE
@@ -275,6 +276,7 @@ dn_expand = __dn_expand SIGFE
 __dn_expand SIGFE
 dn_skipname = __dn_skipname SIGFE
 __dn_skipname SIGFE
+dprintf SIGFE
 drand48 NOSIGFE
 _drand48 = drand48 NOSIGFE
 drem NOSIGFE
@@ -344,6 +346,7 @@ execvp SIGFE
 _execvp = execvp SIGFE
 exit = cygwin_exit SIGFE
 _exit SIGFE
+_Exit SIGFE
 exp NOSIGFE
 _exp = exp NOSIGFE
 exp2 NOSIGFE
@@ -1599,10 +1602,12 @@ utmpname SIGFE
 _utmpname = utmpname SIGFE
 utmpxname SIGFE
 valloc SIGFE
+vasnprintf SIGFE
 vasprintf SIGFE
 _vasprintf = vasprintf SIGFE
 vasprintf_r = _vasprintf_r SIGFE
 _vasprintf_r SIGFE
+vdprintf SIGFE
 verr SIGFE
 verrx SIGFE
 vfiprintf SIGFE
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.241
diff -u -p -r1.241 version.h
--- include/cygwin/version.h	6 Mar 2007 14:48:25 -0000	1.241
+++ include/cygwin/version.h	15 May 2007 00:44:21 -0000
@@ -307,12 +307,13 @@ details. */
 	   mq_send, mq_setattr, mq_timedreceive, mq_timedsend, mq_unlink.
       166: Export sem_unlink.
       167: Add st_birthtim to struct stat.
+      168: Export asnprintf, dprintf, _Exit, vasnprintf, vdprintf.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 167
+#define CYGWIN_VERSION_API_MINOR 168
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------050705060507030408050605--

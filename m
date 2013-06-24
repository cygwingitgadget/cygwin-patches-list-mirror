Return-Path: <cygwin-patches-return-7891-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5852 invoked by alias); 24 Jun 2013 05:17:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5805 invoked by uid 89); 24 Jun 2013 05:17:21 -0000
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,SPF_PASS autolearn=ham version=3.3.1
Received: from mail-ie0-f174.google.com (HELO mail-ie0-f174.google.com) (209.85.223.174)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Mon, 24 Jun 2013 05:17:20 +0000
Received: by mail-ie0-f174.google.com with SMTP id 9so23497889iec.19        for <cygwin-patches@cygwin.com>; Sun, 23 Jun 2013 22:17:19 -0700 (PDT)
X-Received: by 10.42.52.6 with SMTP id h6mr10857557icg.5.1372051039459;        Sun, 23 Jun 2013 22:17:19 -0700 (PDT)
Received: from [192.168.0.101] (S0106000cf16f58b1.wp.shawcable.net. [24.79.212.134])        by mx.google.com with ESMTPSA id ri10sm12556392igc.1.2013.06.23.22.17.17        for <cygwin-patches@cygwin.com>        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Sun, 23 Jun 2013 22:17:18 -0700 (PDT)
Message-ID: <51C7D660.6010509@users.sourceforge.net>
Date: Mon, 24 Jun 2013 05:17:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Export rawmemchr
Content-Type: multipart/mixed; boundary="------------040106020805030208050106"
X-Virus-Found: No
X-SW-Source: 2013-q2/txt/msg00029.txt.bz2

This is a multi-part message in MIME format.
--------------040106020805030208050106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 74

Patch for Cygwin, pending approval of my newlib patch, attached.


Yaakov

--------------040106020805030208050106
Content-Type: text/x-patch;
 name="cygwin-rawmemchr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-rawmemchr.patch"
Content-length: 2367

2013-06-23  Yaakov Selkowitz  <yselkowitz@...>

	* common.din (rawmemchr): Export.
	* posix.sgml (std-gnu): Add rawmemchr.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: common.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/common.din,v
retrieving revision 1.4
diff -u -p -r1.4 common.din
--- common.din	21 May 2013 19:04:49 -0000	1.4
+++ common.din	24 Jun 2013 04:49:16 -0000
@@ -897,6 +897,7 @@ raise SIGFE
 rand NOSIGFE
 rand_r NOSIGFE
 random NOSIGFE
+rawmemchr NOSIGFE
 rcmd = cygwin_rcmd SIGFE
 rcmd_af = cygwin_rcmd_af SIGFE
 read SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.85
diff -u -p -r1.85 posix.sgml
--- posix.sgml	13 Jun 2013 12:50:28 -0000	1.85
+++ posix.sgml	24 Jun 2013 04:49:16 -0000
@@ -1145,6 +1145,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     pthread_getattr_np
     pthread_sigqueue
     ptsname_r
+    rawmemchr
     removexattr
     scandirat
     setxattr
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.383
diff -u -p -r1.383 version.h
--- include/cygwin/version.h	7 Jun 2013 09:21:53 -0000	1.383
+++ include/cygwin/version.h	24 Jun 2013 04:49:16 -0000
@@ -436,12 +436,13 @@ details. */
       265: Export __b64_ntop, __b64_pton.
       266: Export arc4random, arc4random_addrandom, arc4random_buf,
 	   arc4random_stir, arc4random_uniform.
+      267: Export rawmemchr.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 266
+#define CYGWIN_VERSION_API_MINOR 267
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: release/1.7.21
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/release/1.7.21,v
retrieving revision 1.5
diff -u -p -r1.5 1.7.21
--- release/1.7.21	19 Jun 2013 16:05:04 -0000	1.5
+++ release/1.7.21	24 Jun 2013 04:49:16 -0000
@@ -1,6 +1,7 @@
 What's new:
 -----------
 
+- New API: rawmemchr.
 
 Bug fixes:
 ----------

--------------040106020805030208050106--

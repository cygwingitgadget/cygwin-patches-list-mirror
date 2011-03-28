Return-Path: <cygwin-patches-return-7210-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10380 invoked by alias); 28 Mar 2011 03:38:23 -0000
Received: (qmail 10357 invoked by uid 22791); 28 Mar 2011 03:38:22 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 28 Mar 2011 03:38:18 +0000
Received: by yie16 with SMTP id 16so986510yie.2        for <cygwin-patches@cygwin.com>; Sun, 27 Mar 2011 20:38:17 -0700 (PDT)
Received: by 10.150.235.5 with SMTP id i5mr3471002ybh.26.1301283497678;        Sun, 27 Mar 2011 20:38:17 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id f5sm1154275ybh.28.2011.03.27.20.38.16        (version=SSLv3 cipher=OTHER);        Sun, 27 Mar 2011 20:38:17 -0700 (PDT)
Subject: [PATCH] Export strchrnul (pending newlib patch)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-KAAFr2foVOFaByF5SYCL"
Date: Mon, 28 Mar 2011 03:38:00 -0000
Message-ID: <1301283496.5408.8.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00065.txt.bz2


--=-KAAFr2foVOFaByF5SYCL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 82

Here's the Cygwin patch to export strchrnul(3) once accepted in newlib.


Yaakov


--=-KAAFr2foVOFaByF5SYCL
Content-Disposition: attachment; filename="winsup-strchrnul.patch"
Content-Type: text/x-patch; name="winsup-strchrnul.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1927

2011-03-27  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* cygwin.din (strchrnul): Export.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* posix.sgml (std-gnu): Add strchrnul.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.232
diff -u -r1.232 cygwin.din
--- cygwin.din	22 Feb 2011 01:32:42 -0000	1.232
+++ cygwin.din	28 Mar 2011 03:02:47 -0000
@@ -1583,6 +1583,7 @@
 _strcat = strcat NOSIGFE
 strchr NOSIGFE
 _strchr = strchr NOSIGFE
+strchrnul NOSIGFE
 strcmp NOSIGFE
 _strcmp = strcmp NOSIGFE
 strcoll NOSIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.53
diff -u -r1.53 posix.sgml
--- posix.sgml	10 Feb 2011 10:51:13 -0000	1.53
+++ posix.sgml	28 Mar 2011 03:02:47 -0000
@@ -1112,6 +1112,7 @@
     pow10f
     removexattr
     setxattr
+    strchrnul
     tdestroy
     timegm
     timelocal
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.336
diff -u -r1.336 version.h
--- include/cygwin/version.h	1 Mar 2011 22:35:00 -0000	1.336
+++ include/cygwin/version.h	28 Mar 2011 03:02:47 -0000
@@ -400,12 +400,13 @@
       234: Export program_invocation_name, program_invocation_short_name.
       235: Export madvise.
       236: Export pthread_yield, __xpg_strerror_r.
+      237: Export strchrnul.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 236
+#define CYGWIN_VERSION_API_MINOR 237
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-KAAFr2foVOFaByF5SYCL--

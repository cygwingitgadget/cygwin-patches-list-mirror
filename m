Return-Path: <cygwin-patches-return-7824-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29560 invoked by alias); 21 Feb 2013 05:15:59 -0000
Received: (qmail 29540 invoked by uid 22791); 21 Feb 2013 05:15:56 -0000
X-SWARE-Spam-Status: No, hits=-4.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f170.google.com (HELO mail-ia0-f170.google.com) (209.85.210.170)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 21 Feb 2013 05:15:51 +0000
Received: by mail-ia0-f170.google.com with SMTP id k20so8032967iak.29        for <cygwin-patches@cygwin.com>; Wed, 20 Feb 2013 21:15:50 -0800 (PST)
X-Received: by 10.42.180.65 with SMTP id bt1mr10307458icb.41.1361423750679;        Wed, 20 Feb 2013 21:15:50 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ee5sm9736563igc.0.2013.02.20.21.15.49        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Wed, 20 Feb 2013 21:15:50 -0800 (PST)
Date: Thu, 21 Feb 2013 05:15:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 64bit] lsaauth: skip 32bit DLL on 64bit target, part 2
Message-ID: <20130220231548.700127f9@YAAKOV04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/zyFcsvaBlQzsrF6QaiIzQaX"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00035.txt.bz2


--MP_/zyFcsvaBlQzsrF6QaiIzQaX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 190

The attached patch is a follow-up to my previous lsaauth patch. FWIW,
it worked as intended only because the toplevel Makefile provided
target_alias; this fixes make in the subdir.


Yaakov

--MP_/zyFcsvaBlQzsrF6QaiIzQaX
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lsaauth-64bit-part2.patch
Content-length: 1543

2013-02-21  Yaakov Selkowitz  <yselkowitz@...>

	* Makefile.in (target_alias): Define for previous commit.
	* configure.in: Skip check for i686-w64-mingw32-g++ on x86_64.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/lsaauth/Makefile.in,v
retrieving revision 1.6.2.3
diff -u -p -r1.6.2.3 Makefile.in
--- Makefile.in	15 Feb 2013 10:42:16 -0000	1.6.2.3
+++ Makefile.in	21 Feb 2013 03:55:54 -0000
@@ -28,6 +28,7 @@ INSTALL_DATA    := @INSTALL_DATA@
 
 CC              := @CC@
 CC_FOR_TARGET   := $(CC)
+target_alias    := @target_alias@
 
 MINGW32_CC	:= @MINGW32_CC@
 MINGW64_CC	:= @MINGW64_CC@
Index: configure.ac
===================================================================
RCS file: /cvs/src/src/winsup/lsaauth/configure.ac,v
retrieving revision 1.1.2.1
diff -u -p -r1.1.2.1 configure.ac
--- configure.ac	27 Nov 2012 08:56:07 -0000	1.1.2.1
+++ configure.ac	21 Feb 2013 03:55:54 -0000
@@ -25,10 +25,14 @@ AC_CANONICAL_SYSTEM
 
 LIB_AC_PROG_CC
 
-AC_CHECK_PROGS(MINGW32_CC, i686-w64-mingw32-gcc)
-AC_CHECK_PROGS(MINGW64_CC, x86_64-w64-mingw32-gcc)
+case "$target_cpu" in
+i?86)
+  AC_CHECK_PROGS(MINGW32_CC, i686-w64-mingw32-gcc)
+  test -z "$MINGW32_CC" && AC_MSG_ERROR([no acceptable mingw32 cc found in \$PATH])
+  ;;
+esac
 
-test -z "$MINGW32_CC" && AC_MSG_ERROR([no acceptable mingw32 cc found in \$PATH])
+AC_CHECK_PROGS(MINGW64_CC, x86_64-w64-mingw32-gcc)
 test -z "$MINGW64_CC" && AC_MSG_ERROR([no acceptable mingw64 cc found in \$PATH])
 
 AC_ARG_PROGRAM


--MP_/zyFcsvaBlQzsrF6QaiIzQaX--

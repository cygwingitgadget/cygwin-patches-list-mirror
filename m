Return-Path: <cygwin-patches-return-7303-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8636 invoked by alias); 4 May 2011 22:22:59 -0000
Received: (qmail 8626 invoked by uid 22791); 4 May 2011 22:22:58 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,TW_BN,TW_RX,TW_TR
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 04 May 2011 22:22:44 +0000
Received: by yie16 with SMTP id 16so763510yie.2        for <cygwin-patches@cygwin.com>; Wed, 04 May 2011 15:22:43 -0700 (PDT)
Received: by 10.151.5.12 with SMTP id h12mr1598908ybi.34.1304547763406;        Wed, 04 May 2011 15:22:43 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id c3sm505457ybn.24.2011.05.04.15.22.42        (version=SSLv3 cipher=OTHER);        Wed, 04 May 2011 15:22:42 -0700 (PDT)
Subject: [PATCH] update posix.sgml:std-notimpl
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-7BEMpK+hOLLxV0DTjLOb"
Date: Wed, 04 May 2011 22:22:00 -0000
Message-ID: <1304547767.6700.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00069.txt.bz2


--=-7BEMpK+hOLLxV0DTjLOb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 203

The bsd_signal, setcontext, and swapcontext symbols were declared
obsolete in POSIX.1-2004 and removed from POSIX.1-2008.  This patch
updates the std-notimpl section of posix.sgml accordingly.


Yaakov


--=-7BEMpK+hOLLxV0DTjLOb
Content-Disposition: attachment; filename="posix-notimpl.patch"
Content-Type: text/x-patch; name="posix-notimpl.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 809

2011-05-04  Yaakov Selkowitz  <yselkowitz@...>

	* posix.sgml (std-notimpl): Remove bsd_signal, setcontext, and
	swapcontext, marked obsolete in SUSv3 and not present in SUSv4.

Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.58
diff -u -r1.58 posix.sgml
--- posix.sgml	3 May 2011 01:13:37 -0000	1.58
+++ posix.sgml	4 May 2011 11:56:25 -0000
@@ -1273,7 +1273,6 @@
     atan2l
     atanhl
     atanl
-    bsd_signal
     cabsl
     cacoshl
     cacosl
@@ -1397,7 +1396,6 @@
     roundl
     scalblnl
     scalbnl
-    setcontext
     setnetent
     sigaltstack
     sigtimedwait
@@ -1411,7 +1409,6 @@
     strncasecmp_l
     strtold
     strxfrm_l
-    swabcontext
     tanhl
     tanl
     tcgetsid

--=-7BEMpK+hOLLxV0DTjLOb--

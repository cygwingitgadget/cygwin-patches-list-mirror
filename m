Return-Path: <cygwin-patches-return-7479-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32660 invoked by alias); 18 Aug 2011 18:54:24 -0000
Received: (qmail 32648 invoked by uid 22791); 18 Aug 2011 18:54:24 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-vx0-f171.google.com (HELO mail-vx0-f171.google.com) (209.85.220.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 18 Aug 2011 18:54:10 +0000
Received: by vxh13 with SMTP id 13so2445332vxh.2        for <cygwin-patches@cygwin.com>; Thu, 18 Aug 2011 11:54:09 -0700 (PDT)
Received: by 10.52.25.33 with SMTP id z1mr1120945vdf.187.1313693649826;        Thu, 18 Aug 2011 11:54:09 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id eq10sm2241671vdb.16.2011.08.18.11.54.08        (version=SSLv3 cipher=OTHER);        Thu, 18 Aug 2011 11:54:08 -0700 (PDT)
Subject: [PATCH] Fix warning in winsup/cygserver
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Thu, 18 Aug 2011 18:54:00 -0000
Content-Type: multipart/mixed; boundary="=-1pqJz7eMG8YGVpJLPpQu"
Message-ID: <1313693651.4916.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00055.txt.bz2


--=-1pqJz7eMG8YGVpJLPpQu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 251

The attached patch fixes the following warning:

/usr/src/cygwin/winsup/cygserver/sysv_shm.cc:71:0: warning:
"ACCESSPERMS" redefined
/usr/src/cygwin/newlib/libc/include/sys/stat.h:126:0: note: this is the
location of the previous definition


Yaakov


--=-1pqJz7eMG8YGVpJLPpQu
Content-Disposition: attachment; filename="cygserver-redefinition-warning.patch"
Content-Type: text/x-patch; name="cygserver-redefinition-warning.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 709

2011-08-18  Yaakov Selkowitz  <yselkowitz@...>

	* sysv_shm.cc (ACCESSPERMS): Remove to fix redefined warning, as
	this is now defined in <sys/stat.h>.


Index: sysv_shm.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygserver/sysv_shm.cc,v
retrieving revision 1.10
diff -u -p -r1.10 sysv_shm.cc
--- sysv_shm.cc	5 Nov 2007 15:45:52 -0000	1.10
+++ sysv_shm.cc	18 Aug 2011 18:32:23 -0000
@@ -68,7 +68,6 @@ __FBSDID("$FreeBSD: /repoman/r/ncvs/src/
 #endif
 #define btoc(b)	(((b) + PAGE_MASK) / PAGE_SIZE)
 #define round_page(p) ((((unsigned long)(p)) + PAGE_MASK) & ~(PAGE_MASK))
-#define ACCESSPERMS (0777)
 #ifdef __CYGWIN__
 #define GIANT_REQUIRED
 #else

--=-1pqJz7eMG8YGVpJLPpQu--

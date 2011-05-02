Return-Path: <cygwin-patches-return-7285-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10676 invoked by alias); 2 May 2011 16:07:50 -0000
Received: (qmail 10650 invoked by uid 22791); 2 May 2011 16:07:48 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-gx0-f171.google.com (HELO mail-gx0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 May 2011 16:07:33 +0000
Received: by gxk22 with SMTP id 22so2561015gxk.2        for <cygwin-patches@cygwin.com>; Mon, 02 May 2011 09:07:32 -0700 (PDT)
Received: by 10.150.136.20 with SMTP id j20mr6771589ybd.113.1304352452672;        Mon, 02 May 2011 09:07:32 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id w19sm1281722ybe.10.2011.05.02.09.07.30        (version=SSLv3 cipher=OTHER);        Mon, 02 May 2011 09:07:31 -0700 (PDT)
Subject: [PATCH] define _SC_SPIN_LOCKS
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-yPKTG3ZySPHrNgJMNGB3"
Date: Mon, 02 May 2011 16:07:00 -0000
Message-ID: <1304352457.6972.16.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00051.txt.bz2


--=-yPKTG3ZySPHrNgJMNGB3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 104

Corresponding patch to newlib just committed; this is the patch for
winsup/cygwin/sysconf.cc.


Yaakov


--=-yPKTG3ZySPHrNgJMNGB3
Content-Disposition: attachment; filename="winsup-sysconf-spinlocks.patch"
Content-Type: text/x-patch; name="winsup-sysconf-spinlocks.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 817

2011-05-02  Yaakov Selkowitz  <yselkowitz@...>

	* sysconf.cc (sca): Set _SC_SPIN_LOCKS to _POSIX_SPIN_LOCKS.

Index: sysconf.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v
retrieving revision 1.54
diff -u -r1.54 sysconf.cc
--- sysconf.cc	9 Aug 2010 16:47:47 -0000	1.54
+++ sysconf.cc	2 May 2011 15:40:44 -0000
@@ -172,7 +172,7 @@
   {cons, {c:RE_DUP_MAX}},		/*  73, _SC_RE_DUP_MAX */
   {cons, {c:_POSIX_SHELL}},		/*  74, _SC_SHELL */
   {cons, {c:-1L}},			/*  75, _SC_SPAWN */
-  {cons, {c:-1L}},			/*  76, _SC_SPIN_LOCKS */
+  {cons, {c:_POSIX_SPIN_LOCKS}},	/*  76, _SC_SPIN_LOCKS */
   {cons, {c:-1L}},			/*  77, _SC_SPORADIC_SERVER */
   {nsup, {c:0}},			/*  78, _SC_SS_REPL_MAX */
   {cons, {c:SYMLOOP_MAX}},		/*  79, _SC_SYMLOOP_MAX */

--=-yPKTG3ZySPHrNgJMNGB3--

Return-Path: <cygwin-patches-return-7787-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28437 invoked by alias); 6 Dec 2012 05:20:36 -0000
Received: (qmail 28426 invoked by uid 22791); 6 Dec 2012 05:20:32 -0000
X-SWARE-Spam-Status: No, hits=-4.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f179.google.com (HELO mail-ia0-f179.google.com) (209.85.210.179)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 06 Dec 2012 05:20:26 +0000
Received: by mail-ia0-f179.google.com with SMTP id o25so4386749iad.10        for <cygwin-patches@cygwin.com>; Wed, 05 Dec 2012 21:20:25 -0800 (PST)
Received: by 10.50.40.138 with SMTP id x10mr4635121igk.41.1354771225721;        Wed, 05 Dec 2012 21:20:25 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id gz10sm6342768igc.9.2012.12.05.21.20.24        (version=TLSv1/SSLv3 cipher=OTHER);        Wed, 05 Dec 2012 21:20:24 -0800 (PST)
Message-ID: <1354771229.6160.2.camel@YAAKOV04>
Subject: [PATCH] waitpid(2) WAIT_* macros
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Thu, 06 Dec 2012 05:20:00 -0000
Content-Type: multipart/mixed; boundary="=-fOI3HAu0HCAgQBSyS/fQ"
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
X-SW-Source: 2012-q4/txt/msg00064.txt.bz2


--=-fOI3HAu0HCAgQBSyS/fQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 232

WAIT_ANY and WAIT_MYPGRP are defined by glibc[1] as symbolic constants
for special values in the first argument to waitpid(2).  Patch attached.


Yaakov

[1]
http://www.gnu.org/software/libc/manual/html_node/Process-Completion.html

--=-fOI3HAu0HCAgQBSyS/fQ
Content-Disposition: attachment; filename="wait-macros.patch"
Content-Type: text/x-patch; name="wait-macros.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 634

2012-12-05  Yaakov Selkowitz  <yselkowitz@...>

	* include/cygwin/wait.h (WAIT_ANY): Define.
	(WAIT_MYPGRP): Define.

Index: include/cygwin/wait.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/wait.h,v
retrieving revision 1.3
diff -u -p -r1.3 wait.h
--- include/cygwin/wait.h	6 Oct 2011 16:02:35 -0000	1.3
+++ include/cygwin/wait.h	6 Dec 2012 05:15:03 -0000
@@ -11,6 +11,9 @@ details. */
 #ifndef _CYGWIN_WAIT_H
 #define _CYGWIN_WAIT_H
 
+#define WAIT_ANY	(pid_t)-1
+#define WAIT_MYPGRP	(pid_t)0
+
 #define WNOHANG 1
 #define WUNTRACED 2
 #define WCONTINUED 8

--=-fOI3HAu0HCAgQBSyS/fQ--

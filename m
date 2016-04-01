Return-Path: <cygwin-patches-return-8545-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78308 invoked by alias); 1 Apr 2016 23:40:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78209 invoked by uid 89); 1 Apr 2016 23:40:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 01 Apr 2016 23:39:56 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 141EFC049D68	for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2016 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u31NdqUx030275	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 1 Apr 2016 19:39:54 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/4] cygwin: update sysconf for new features
Date: Fri, 01 Apr 2016 23:40:00 -0000
Message-Id: <1459553988-14384-3-git-send-email-yselkowi@redhat.com>
In-Reply-To: <1459553988-14384-1-git-send-email-yselkowi@redhat.com>
References: <1459551179-9404-1-git-send-email-yselkowi@redhat.com> <1459553988-14384-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q2/txt/msg00020.txt.bz2

POSIX spawn and thread barriers have since been added.  Also fix a typo in
_POSIX2_C_DEV (result is the same).

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/sysconf.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index ae35c6e..0d33bcb 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -565,7 +565,7 @@ static struct
   {cons, {c:PTHREAD_DESTRUCTOR_ITERATIONS}},	/*  53, _SC_THREAD_DESTRUCTOR_ITERATIONS */
   {cons, {c:_POSIX_ADVISORY_INFO}},	/*  54, _SC_ADVISORY_INFO */
   {cons, {c:ATEXIT_MAX}},		/*  55, _SC_ATEXIT_MAX */
-  {cons, {c:-1L}},			/*  56, _SC_BARRIERS */
+  {cons, {c:_POSIX_BARRIERS}},		/*  56, _SC_BARRIERS */
   {cons, {c:BC_BASE_MAX}},		/*  57, _SC_BC_BASE_MAX */
   {cons, {c:BC_DIM_MAX}},		/*  58, _SC_BC_DIM_MAX */
   {cons, {c:BC_SCALE_MAX}},		/*  59, _SC_BC_SCALE_MAX */
@@ -584,7 +584,7 @@ static struct
   {cons, {c:_POSIX_REGEXP}},		/*  72, _SC_REGEXP */
   {cons, {c:RE_DUP_MAX}},		/*  73, _SC_RE_DUP_MAX */
   {cons, {c:_POSIX_SHELL}},		/*  74, _SC_SHELL */
-  {cons, {c:-1L}},			/*  75, _SC_SPAWN */
+  {cons, {c:_POSIX_SPAWN}},		/*  75, _SC_SPAWN */
   {cons, {c:_POSIX_SPIN_LOCKS}},	/*  76, _SC_SPIN_LOCKS */
   {cons, {c:-1L}},			/*  77, _SC_SPORADIC_SERVER */
   {nsup, {c:0}},			/*  78, _SC_SS_REPL_MAX */
@@ -618,7 +618,7 @@ static struct
   {cons, {c:_XOPEN_VERSION}},		/* 106, _SC_XOPEN_VERSION */
   {cons, {c:_POSIX2_CHAR_TERM}},	/* 107, _SC_2_CHAR_TERM */
   {cons, {c:_POSIX2_C_BIND}},		/* 108, _SC_2_C_BIND */
-  {cons, {c:_POSIX2_C_BIND}},		/* 109, _SC_2_C_DEV */
+  {cons, {c:_POSIX2_C_DEV}},		/* 109, _SC_2_C_DEV */
   {cons, {c:-1L}},			/* 110, _SC_2_FORT_DEV */
   {cons, {c:-1L}},			/* 111, _SC_2_FORT_RUN */
   {cons, {c:-1L}},			/* 112, _SC_2_LOCALEDEF */
-- 
2.7.4

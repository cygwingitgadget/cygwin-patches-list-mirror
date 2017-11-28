Return-Path: <cygwin-patches-return-8936-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42566 invoked by alias); 28 Nov 2017 10:10:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42548 invoked by uid 89); 28 Nov 2017 10:10:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KB_WAM_FROM_NAME_SINGLEWORD,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 10:10:42 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id A7894C04AC42	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-11.rdu2.redhat.com [10.10.120.11])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4058760602	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 10:10:41 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: define _POSIX_TIMEOUTS
Date: Tue, 28 Nov 2017 10:10:00 -0000
Message-Id: <20171128101032.16540-1-yselkowi@redhat.com>
X-SW-Source: 2017-q4/txt/msg00066.txt.bz2

Since commit 8128f5482f2b1889e2336488e9d45a33c9972d11, we have all the
non-tracing functions listed in posixoptions(7).  The tracing functions
are gated by their own option, and are obsolecent anyway.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 newlib/libc/include/sys/features.h | 2 +-
 winsup/cygwin/sysconf.cc           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/newlib/libc/include/sys/features.h b/newlib/libc/include/sys/features.h
index 084bf2183..2900b332f 100644
--- a/newlib/libc/include/sys/features.h
+++ b/newlib/libc/include/sys/features.h
@@ -464,7 +464,7 @@ extern "C" {
 #define _POSIX_THREAD_SAFE_FUNCTIONS		200809L
 /* #define _POSIX_THREAD_SPORADIC_SERVER	    -1 */
 #define _POSIX_THREADS				200809L
-/* #define _POSIX_TIMEOUTS			    -1 */
+#define _POSIX_TIMEOUTS				200809L
 #define _POSIX_TIMERS				200809L
 /* #define _POSIX_TRACE				    -1 */
 /* #define _POSIX_TRACE_EVENT_FILTER		    -1 */
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index a24a98501..ecd9aeb93 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -588,7 +588,7 @@ static struct
   {cons, {c:SYMLOOP_MAX}},		/*  79, _SC_SYMLOOP_MAX */
   {cons, {c:_POSIX_THREAD_CPUTIME}},	/*  80, _SC_THREAD_CPUTIME */
   {cons, {c:-1L}},			/*  81, _SC_THREAD_SPORADIC_SERVER */
-  {cons, {c:-1L}},			/*  82, _SC_TIMEOUTS */
+  {cons, {c:_POSIX_TIMEOUTS}},		/*  82, _SC_TIMEOUTS */
   {cons, {c:-1L}},			/*  83, _SC_TRACE */
   {cons, {c:-1L}},			/*  84, _SC_TRACE_EVENT_FILTER */
   {nsup, {c:0}},			/*  85, _SC_TRACE_EVENT_NAME_MAX */
-- 
2.15.0

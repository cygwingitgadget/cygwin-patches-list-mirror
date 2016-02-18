Return-Path: <cygwin-patches-return-8324-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123293 invoked by alias); 18 Feb 2016 05:21:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123276 invoked by uid 89); 18 Feb 2016 05:21:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Floating, 26,7, Hx-languages-length:2035, 267
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 18 Feb 2016 05:21:49 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (Postfix) with ESMTPS id 87A037EBA1	for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2016 05:21:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1I5Lkbp025885	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2016 00:21:46 -0500
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: accept SIGIOT as alias of SIGABRT
Date: Thu, 18 Feb 2016 05:21:00 -0000
Message-Id: <1455772898-11800-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q1/txt/msg00030.txt.bz2

	winsup/cygwin/
	* include/cygwin/signal.h (SIGIOT): Define SIGIOT in terms of SIGABRT.
	* strsig.cc (struct sigdesc): Ditto.

	winsup/doc/
	* utils.xml (kill): Document SIGIOT.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/cygwin/signal.h | 1 +
 winsup/cygwin/strsig.cc               | 3 ++-
 winsup/doc/utils.xml                  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/cygwin/signal.h
index 04ddb69..e876dec 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -358,6 +358,7 @@ struct sigaction
 #define	SIGILL	4	/* illegal instruction (not reset when caught) */
 #define	SIGTRAP	5	/* trace trap (not reset when caught) */
 #define	SIGABRT 6	/* used by abort */
+#define	SIGIOT	SIGABRT	/* synonym for SIGABRT on most systems */
 #define	SIGEMT	7	/* EMT instruction */
 #define	SIGFPE	8	/* floating point exception */
 #define	SIGKILL	9	/* kill (cannot be caught or ignored) */
diff --git a/winsup/cygwin/strsig.cc b/winsup/cygwin/strsig.cc
index 987e135..bb53e1b 100644
--- a/winsup/cygwin/strsig.cc
+++ b/winsup/cygwin/strsig.cc
@@ -26,7 +26,8 @@ struct sigdesc
   _s(SIGQUIT, "Quit"),				/*  3 */ \
   _s(SIGILL, "Illegal instruction"),		/*  4 */ \
   _s(SIGTRAP, "Trace/breakpoint trap"),		/*  5 */ \
-  _s(SIGABRT, "Aborted"),			/*  6 */ \
+  _s2(SIGABRT, "Aborted",			/*  6 */ \
+      SIGIOT, "Aborted"),				 \
   _s(SIGEMT, "EMT instruction"),		/*  7 */ \
   _s(SIGFPE, "Floating point exception"),	/*  8 */ \
   _s(SIGKILL, "Killed"),			/*  9 */ \
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index a00384e..501d248 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -741,6 +741,7 @@ SIGQUIT      3    quit
 SIGILL       4    illegal instruction (not reset when caught)
 SIGTRAP      5    trace trap (not reset when caught)
 SIGABRT      6    used by abort
+SIGIOT       6    another name for SIGABRT
 SIGEMT       7    EMT instruction
 SIGFPE       8    floating point exception
 SIGKILL      9    kill (cannot be caught or ignored)
-- 
2.7.0

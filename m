Return-Path: <cygwin-patches-return-8618-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16853 invoked by alias); 24 Aug 2016 18:20:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16811 invoked by uid 89); 24 Aug 2016 18:20:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=dying, Hx-spam-relays-external:CriticalPath, H*RU:CriticalPath, HCc:D*uk
X-HELO: rgout0403.bt.lon5.cpcloud.co.uk
Received: from rgout0403.bt.lon5.cpcloud.co.uk (HELO rgout0403.bt.lon5.cpcloud.co.uk) (65.20.0.216) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Aug 2016 18:20:18 +0000
X-OWM-Source-IP: 31.51.206.108 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2016.8.24.171817:17:7.944,ip=31.51.206.108,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __URI_NO_WWW, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_900_999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_1000_LESS, BODY_SIZE_2000_LESS, __FROM_DOMAIN_IN_RCPT, RDNS_SUSP, IN_REP_TO, REFERENCES, BODY_SIZE_7000_LESS, NO_URI_HTTPS, MSG_THREAD, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, LEGITIMATE_NEGATE
Received: from localhost.localdomain (31.51.206.108) by rgout04.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57BDD4BF0002994D; Wed, 24 Aug 2016 19:19:17 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Fix SetThreadName with current gdb
Date: Wed, 24 Aug 2016 18:20:00 -0000
Message-Id: <20160824181857.16904-1-jon.turney@dronecode.org.uk>
In-Reply-To: <20160822180848.351616-3-jon.turney@dronecode.org.uk>
References: <20160822180848.351616-3-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00026.txt.bz2

Wrap SetThreadName()'s call to RaiseException() in __try/__except/__endtry,
so that if the attached debugger doesn't know about MS_VC_EXCEPTION (e.g.
current gdb and probably strace as well) and continues exception processing,
we ignore it, rather than dying due an unhandled exception.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/miscfuncs.cc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index 5a63b26..7a79359 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -1134,5 +1134,10 @@ SetThreadName(DWORD dwThreadID, const char* threadName)
 #endif
     };
 
-  RaiseException (MS_VC_EXCEPTION, 0, sizeof (info)/sizeof (ULONG_PTR), (ULONG_PTR *) &info);
+  __try {
+    RaiseException (MS_VC_EXCEPTION, 0, sizeof (info)/sizeof (ULONG_PTR), (ULONG_PTR *) &info);
+  }
+  __except (NO_ERROR) {
+  }
+  __endtry
 }
-- 
2.8.3

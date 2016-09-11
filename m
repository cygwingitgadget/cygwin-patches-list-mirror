Return-Path: <cygwin-patches-return-8640-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72467 invoked by alias); 11 Sep 2016 14:56:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72449 invoked by uid 89); 11 Sep 2016 14:56:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.7 required=5.0 tests=AWL,BAYES_40,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=D*org.uk, sk:jontur, sk:jon.tur, jon.turney@dronecode.org.uk
X-HELO: rgout0302.bt.lon5.cpcloud.co.uk
Received: from rgout0302.bt.lon5.cpcloud.co.uk (HELO rgout0302.bt.lon5.cpcloud.co.uk) (65.20.0.208) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 11 Sep 2016 14:56:37 +0000
X-OWM-Source-IP: 86.141.129.68 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.9.11.130017:17:27.888,ip=86.141.129.68,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __URI_NO_WWW, __CP_URI_IN_BODY, __URI_IN_BODY, BODY_SIZE_1300_1399, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[68.129.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, __SINGLE_URI_TEXT, SINGLE_URI_IN_BODY, BODY_SIZE_2000_LESS, __FROM_DOMAIN_IN_RCPT, RDNS_SUSP, BODY_SIZE_7000_LESS, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.141.129.68) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57D1F2710057C43A; Sun, 11 Sep 2016 15:56:34 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Fix SetThreadName with gdb 7.10 on x86
Date: Sun, 11 Sep 2016 14:56:00 -0000
Message-Id: <20160911145623.287168-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00048.txt.bz2

Additionally to eccefd97, we need to ensure the exception handler is
installed for the _ljfault used to implement _try/_except to get called.

Also use the correct macro for x86 conditional compilation.

Addresses https://cygwin.com/ml/cygwin/2016-09/msg00143.html

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/miscfuncs.cc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index fbd024f..f90d6ef 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -1129,11 +1129,18 @@ SetThreadName(DWORD dwThreadID, const char* threadName)
       0x1000,                 /* type, must be 0x1000 */
       (ULONG_PTR) threadName, /* pointer to threadname */
       dwThreadID,             /* thread ID (+ flags on x86_64) */
-#ifdef __X86__
+#ifdef _X86_
       0,                      /* flags, must be zero */
 #endif
     };
 
+#ifdef _X86_
+  /* On x86, for __try/__except to work, we must ensure our exception handler is
+     installed, which may not be the case if this is being called during early
+     initialization. */
+  exception protect;
+#endif
+
   __try
     {
       RaiseException (MS_VC_EXCEPTION, 0, sizeof (info) / sizeof (ULONG_PTR),
-- 
2.8.3

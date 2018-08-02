Return-Path: <cygwin-patches-return-9157-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18824 invoked by alias); 2 Aug 2018 23:45:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18684 invoked by uid 89); 2 Aug 2018 23:45:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-25.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1516, Hx-spam-relays-external:ESMTPA
X-HELO: lb1-smtp-cloud8.xs4all.net
Received: from lb1-smtp-cloud8.xs4all.net (HELO lb1-smtp-cloud8.xs4all.net) (194.109.24.21) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Aug 2018 23:45:38 +0000
Received: from frodo.localdomain ([83.162.234.136])	by smtp-cloud8.xs4all.net with ESMTPA	id lNHdfByVjoj71lNHefjKKk; Fri, 03 Aug 2018 01:45:30 +0200
From: "J.H. van de Water" <houder@xs4all.nl>
To: cygwin-patches@cygwin.com
Cc: "J.H. van de Water" <houder@xs4all.nl>
Subject: [PATCH] Cygwin: fegetenv() in winsup/cygwin/fenv.cc should not disable exceptions!
Date: Thu, 02 Aug 2018 23:45:00 -0000
Message-Id: <1533253512-1717-1-git-send-email-houder@xs4all.nl>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00052.txt.bz2

fegetenv() in winsup/cygwin/fenv.cc

fnstenv MUST be followed by fldenv in fegetenv(), as the former disables all
exceptions in the x87 FPU, which is not appropriate here (fegetenv() ).
fldenv after fnstenv should reload the x87 FPU w/ the configuration that was
saved by fnstenv, i.e. a configuration that might have exceptions enabled.

Note: x86_64 uses SSE for floating-point, not the x87 FPU. However, because
feraiseexcept() attempts to provoke an exception using the x87 FPU, the bug
in fegetenv() will make this attempt futile here (x86_64).

Note: WoW uses the x87 FPU for floating-point, not SSE. Here anything that
would normally result in triggering an exception, not only feraiseexcept(),
will not be able to, as result of the bug in fegetenv().
---
 winsup/cygwin/fenv.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fenv.cc b/winsup/cygwin/fenv.cc
index bd3f904..eb5260c 100644
--- a/winsup/cygwin/fenv.cc
+++ b/winsup/cygwin/fenv.cc
@@ -141,7 +141,10 @@ fegetexcept (void)
 int
 fegetenv (fenv_t *envp)
 {
-  __asm__ volatile ("fnstenv %0" : "=m" (envp->_fpu) : );
+  /* fnstenv disables all exceptions in the x87 FPU; as this is not what is
+     desired here, reload the cfg saved from the x87 FPU, back to the FPU */
+  __asm__ volatile ("fnstenv %0"
+                    "fldenv %0" : "=m" (envp->_fpu) : );
   if (use_sse)
     __asm__ volatile ("stmxcsr %0" : "=m" (envp->_sse_mxcsr) : );
   return 0;
-- 
2.7.5

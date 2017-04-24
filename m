Return-Path: <cygwin-patches-return-8759-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58428 invoked by alias); 24 Apr 2017 09:33:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58384 invoked by uid 89); 24 Apr 2017 09:33:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=konw, HTo:U*cygwin-patches
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp2.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Apr 2017 09:33:17 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D27183FA8;	Mon, 24 Apr 2017 05:33:17 -0400 (EDT)
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6592E83FA7;	Mon, 24 Apr 2017 05:33:17 -0400 (EDT)
Received: from localhost.localdomain (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B16FA83FA5;	Mon, 24 Apr 2017 05:33:16 -0400 (EDT)
From: Daniel Santos <daniel.santos@pobox.com>
To: cygwin-patches@cygwin.com
Cc: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH] Possibly correct fix to strace phantom process entry
Date: Mon, 24 Apr 2017 09:33:00 -0000
Message-Id: <20170424093754.536-1-daniel.santos@pobox.com>
X-Pobox-Relay-ID: 0BC294F6-28D1-11E7-810E-C260AE2156B6-06139138!pb-smtp2.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00030.txt.bz2

The root cause of problem with strace causing long delays when any
process enumerates the process database appears to be calling
myself.thisproc () from child_info_spawn::handle_spawn() when we've
dynamically loaded cygwin1.dll.  It definately fixes the problem, but I
don't konw what other processes dynamically load cygwin1.dll and, thus,
what other side-effects that this may have.  Please verify correctness.

Please see discussion here: https://cygwin.com/ml/cygwin/2017-04/msg00240.html

Daniel

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 winsup/cygwin/dcrt0.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index ea6adcbbd..bbab08725 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -664,7 +664,8 @@ child_info_spawn::handle_spawn ()
   my_wr_proc_pipe = wr_proc_pipe;
   rd_proc_pipe = wr_proc_pipe = NULL;
 
-  myself.thisproc (h);
+  if (!dynamically_loaded)
+    myself.thisproc (h);
   __argc = moreinfo->argc;
   __argv = moreinfo->argv;
   envp = moreinfo->envp;
-- 
2.11.0

Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id C88E83858C27
 for <cygwin-patches@cygwin.com>; Wed,  3 Nov 2021 06:15:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C88E83858C27
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 1A36Efab010465;
 Wed, 3 Nov 2021 15:14:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1A36Efab010465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1635920086;
 bh=s0a+oJis1UvM+8mBBGF15rkaC62s+DsH1knNVXSgQxw=;
 h=From:To:Cc:Subject:Date:From;
 b=OpmsBznDN/uSyRIPgLBSxfxLDGMiMQpLryxppitkYtszZGbQ3Ote7pxxA9fJIIEuV
 FQgkdTMO5uTB4cqs5sfRcnj4APZI3llnBe54dx4r/3MXlNR0K5IgxFYwBJbN8GA3EL
 /WGYxqc8jq93y/jfAnyj5w19HlpUe9o4m5lSSckpDQik07Ot7lRtCggBbSap9Fw1T0
 PuoabDjz/0Rvz95msMQFZA+krrVt2DygheU0FOoRGQ01oTgAE/jJAFx90w1dgfFaEF
 RCjUE2tbLdfOJMk5YexFcNa7lGzKlGfuk3E1hfdHQnHEzPS708UN/3sHm2fxTRf+FV
 hBFppAFh/bhOA==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Prevent the exec'ed bash from exiting by
 Ctrl-C.
Date: Wed,  3 Nov 2021 15:14:42 +0900
Message-Id: <20211103061442.774-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 03 Nov 2021 06:15:17 -0000

- Currently, bash occasionally exits by Ctrl-C with the following
  scenario.
    1) Start bash in the command prompt.
    2) Run 'exec bash'.
    3) Press Ctrl-C several times.
  This patch fixes the issue.
---
 winsup/cygwin/sigproc.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8e70a9329..97211edcf 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -594,6 +594,14 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       p = myself;
     }
 
+  /* If myself is the stub process, send signal to the child process
+     rather than myself. The fact that myself->dwProcessId is not equal
+     to the current process id indicates myself is the stub process. */
+  if (its_me && myself->dwProcessId != GetCurrentProcessId ())
+    {
+      wait_for_completion = false;
+      its_me = false;
+    }
 
   if (its_me)
     sendsig = my_sendsig;
-- 
2.33.0


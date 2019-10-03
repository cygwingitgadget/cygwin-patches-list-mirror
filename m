Return-Path: <cygwin-patches-return-9729-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127817 invoked by alias); 3 Oct 2019 10:43:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127808 invoked by uid 89); 3 Oct 2019 10:43:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.2 required=5.0 tests=AWL,BAYES_40,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=armed, HDKIM-Filter:v2.10.3, H*F:D*ne.jp, UD:jp
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 03 Oct 2019 10:43:56 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x93AhdHl003836;	Thu, 3 Oct 2019 19:43:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x93AhdHl003836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1570099426;	bh=Q7FgWEwUZcb2MZBpgRQ9nEObDgQ2mCwNzQB4VR4yZCA=;	h=From:To:Cc:Subject:Date:From;	b=nP6grr/GoPTOsvZ/Xb0jdcranl+sx+VXla8/SsJlKAKfu8cO8tiO/k0GJ/NIpbkn4	 qdxlD1glomRuEodNFU71Ahs/EFzH4Q8AYvYGXL+0vKnpDY339Xus6gRoCti5BAD1yh	 3F9atcEizBzeKbT5sjKFWkZgbpYkgGMMnUnlB0Zgd3/oOMQRwyBK1+YOC0VX+5DfVu	 naLJWwDqAJDCkrpgAW3v3HHbct40vPRbpsra75BA8YIgDf8mmWSdRHb9W26M+WIoKX	 YG7qKxk0dB+/rACIeet5L4jHweoXvQmbyDabu3mu43ctVZWZ6B3doEKhMeHRP5VvIx	 FXCAfCxdql55Q==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: Fix signal handling issue introduced by PTY related change.
Date: Thu, 03 Oct 2019 10:43:00 -0000
Message-Id: <20191003104337.700-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00000.txt.bz2

- After commit 41864091014b63b0cb72ae98281fa53349b6ef77, there is a
  regression in signal handling reported in
  https://www.cygwin.com/ml/cygwin/2019-10/msg00010.html. This patch
  fixes the issue.
---
 winsup/cygwin/exceptions.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index db0fe0867..132fea427 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -949,7 +949,7 @@ _cygtls::interrupt_setup (siginfo_t& si, void *handler, struct sigaction& siga)
   if (incyg)
     set_signal_arrived ();
 
-  if (!have_execed && ch_spawn.iscygwin ())
+  if (!have_execed && !(myself->exec_sendsig && !ch_spawn.iscygwin ()))
     proc_subproc (PROC_CLEARWAIT, 1);
   sigproc_printf ("armed signal_arrived %p, signal %d",
 		  signal_arrived, si.si_signo);
-- 
2.21.0

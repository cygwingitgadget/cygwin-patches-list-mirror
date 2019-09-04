Return-Path: <cygwin-patches-return-9620-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72537 invoked by alias); 4 Sep 2019 13:48:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72423 invoked by uid 89); 4 Sep 2019 13:48:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 13:48:25 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x84DlhCJ015236;	Wed, 4 Sep 2019 22:47:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x84DlhCJ015236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567604871;	bh=Cp70ckbpED7B+M8VZo3CQ8/IatIuDnKJnMKr0qtuKzM=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=msGqxgdBR5JCLX9040W0ZYuThzEPgS8TxEW/nUwc8cLNlC++rdYW+xKQ6hjY2tNBa	 IQaN2M/D0PrqDgX+1EkRBUYs2g3AIoCcA0310OxiX3yva/Ae06ZSL2/W4oNXJMIUaR	 gwQGC6RrJtzPn7kFo6MjP+ho+B3fDeG5X4rXYtU/Twokz36tz5pb8X5y7PfF8lKhww	 IgzSvXN80rTc7d7Jje4DVGg9jWp8ZiG/jlSTAhhNs9yLEamEKRWD6d+aGwJ7nmMEWB	 hQwxZt02JllS9UPInhL4h005RgX17QPrWtqNjX+Tni80W8huOnodjcA8lUEx3YHkHv	 wU1MrzTdFKURQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/1] Cygwin: pty: Add a workaround for ^C handling.
Date: Wed, 04 Sep 2019 13:48:00 -0000
Message-Id: <20190904134742.1799-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190904134742.1799-1-takashi.yano@nifty.ne.jp>
References: <20190904134742.1799-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00140.txt.bz2

- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 sometimes cause random
  crash or freeze by pressing ^C while cygwin and non-cygwin
  processes are executed simultaneously in the same pty. This
  patch is a workaround for this issue.
---
 winsup/cygwin/fork.cc  | 1 -
 winsup/cygwin/spawn.cc | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index a3a7e7505..0a929dffd 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -213,7 +213,6 @@ frok::child (volatile char * volatile here)
      - terminate the current fork call even if the child is initialized. */
   sync_with_parent ("performed fork fixups and dynamic dll loading", true);
 
-  init_console_handler (myself->ctty > 0);
   ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
 
   pthread::atforkchild ();
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 4bb28c47b..15cba3610 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -635,6 +635,12 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       if (ptys)
 	ptys->fixup_after_attach (!iscygwin ());
 
+      if (!iscygwin ())
+	{
+	  init_console_handler (myself->ctty > 0);
+	  myself->ctty = 0;
+	}
+
     loop:
       /* When ruid != euid we create the new process under the current original
 	 account and impersonate in child, this way maintaining the different
-- 
2.21.0

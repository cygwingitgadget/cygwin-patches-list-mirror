Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id B76AB3858D1E
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 15:36:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B76AB3858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 21QFaL5A007634;
 Sun, 27 Feb 2022 00:36:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 21QFaL5A007634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645889786;
 bh=RZp2jAVdPyUkaTxxMpzyfe2XwOJ7kJCmUaanmpx3wYQ=;
 h=From:To:Cc:Subject:Date:From;
 b=Lzn8/RXuKOYLloN7yrN7n6Ne8bepGqgACKW/E15TIRQ8JymlX0/vjvzPqTC+b9RWy
 ZZJx1U8DEYy7STblxsMi/U+sWweRMMtMuOu7Vafm/WFmaqtdUkdGbLTU+MfjZEHWaZ
 L0/rIOiARJpxPPPXNDHNKO+pEfG7OG+7AtaIVuB5cANdUli/oB4aHHkqgpluAzi6nE
 i9F5owfosYptiVYFX/gbcDyaEyLLo44jHuif3FgUvmeWYBCxiVXndcTgffaguq3SR/
 icfcFooM+pbP6H1e557PmF27jH83sZuUmAkSsAB3R7wogCacz0T6rE25iW9evK1LHg
 TkU72tp68jsAA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Revert experimental code mixed accidentally.
Date: Sun, 27 Feb 2022 00:36:15 +0900
Message-Id: <20220226153615.1174-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 26 Feb 2022 15:36:45 -0000

- The commit "Cygwin: console: Restore CTRL_BREAK_EVENT handling."
  was accidentally mixed with experimental code in exceptions.cc.
  Due to this, non-cygwin app receives CTRL_C_EVENT twice in the
  following scenario.
   1) Run 'sleep 10 | <non-cygwin app>'
   2) Hit Ctrl-C.
   3) The non-cygwin app receives CTRL_C_EVENT twice.
  This patch reverts the code with the problem.
---
 winsup/cygwin/exceptions.cc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 73bf68939..6e0b862c7 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1174,8 +1174,14 @@ ctrl_c_handler (DWORD type)
        (to indicate that we have handled the signal).  At this point, type
        should be a CTRL_C_EVENT or CTRL_BREAK_EVENT. */
     {
+      int sig = SIGINT;
+      /* If intr and quit are both mapped to ^C, send SIGQUIT on ^BREAK */
+      if (type == CTRL_BREAK_EVENT
+	  && t->ti.c_cc[VINTR] == 3 && t->ti.c_cc[VQUIT] == 3)
+	sig = SIGQUIT;
       t->last_ctrl_c = GetTickCount64 ();
-      fhandler_termios::process_sigs ('\003', (tty *) t, ::cygheap->ctty);
+      t->kill_pgrp (sig);
+      t->output_stopped = false;
       t->last_ctrl_c = GetTickCount64 ();
       return TRUE;
     }
-- 
2.35.1


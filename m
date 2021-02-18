Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id D78B73861925
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 09:02:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D78B73861925
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 11I91bHH015892;
 Thu, 18 Feb 2021 18:01:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 11I91bHH015892
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: console: Fix SIGWINCH handling in Win7.
Date: Thu, 18 Feb 2021 18:01:27 +0900
Message-Id: <20210218090128.1459-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218090128.1459-1-takashi.yano@nifty.ne.jp>
References: <20210218090128.1459-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_SOMETLD_ARE_BAD_TLD,
 PDS_OTHER_BAD_TLD, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Thu, 18 Feb 2021 09:02:21 -0000

- If ENABLE_VIRTUAL_TERMINAL_INPUT is not set, changing window height
  does not generate WINDOW_BUFFER_SIZE_EVENT. This happens if console
  is in the legacy mode. Therefore, with this patch, the windows size
  is checked every time in cons_master_thread() if the cosole is in
  the legacy mode.
---
 winsup/cygwin/fhandler_console.cc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 5053cb053..4dee506dd 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -223,6 +223,21 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  ReleaseMutex (p->input_mutex);
 	  return;
 	}
+      /* If ENABLE_VIRTUAL_TERMINAL_INPUT is not set, changing
+	 window height does not generate WINDOW_BUFFER_SIZE_EVENT.
+	 Therefore, check windows size every time here. */
+      if (!wincap.has_con_24bit_colors () || con_is_legacy)
+	{
+	  SHORT y = con.dwWinSize.Y;
+	  SHORT x = con.dwWinSize.X;
+	  con.fillin (p->output_handle);
+	  if (y != con.dwWinSize.Y || x != con.dwWinSize.X)
+	    {
+	      con.scroll_region.Top = 0;
+	      con.scroll_region.Bottom = -1;
+	      ttyp->kill_pgrp (SIGWINCH);
+	    }
+	}
       for (i = 0; i < total_read; i++)
 	{
 	  const char c = input_rec[i].Event.KeyEvent.uChar.AsciiChar;
-- 
2.30.0


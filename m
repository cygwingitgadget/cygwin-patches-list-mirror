Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 32B953858402
 for <cygwin-patches@cygwin.com>; Thu, 18 Nov 2021 08:32:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 32B953858402
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 1AI8VuB7007443;
 Thu, 18 Nov 2021 17:32:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1AI8VuB7007443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637224322;
 bh=4lDZs8HoM9dy+40mziJk2BPPG1lwFTBeH237MHGEE7M=;
 h=From:To:Cc:Subject:Date:From;
 b=MGPVzSNuAkuLhTGPsvXG91TMqV90diCGgas8WzCHcYBnO/xAPTi6ATNo2iz9vOpwD
 mDxoWWXrF7SMf9349GPd4lPFvn+DhKOaKOAkkIThRjNiLhC0rZuyfpeUZaRc8UKvNC
 /jHGlMzKLnzfK/N9K4hpmzALy8+76gx6xe9KNlZPTBTU2Abx0ZfOFBlzUyXu4+FGwn
 f//cVp1xFxTAddWaVQiw4u0XWuqdu4iEQI2plFZOSAgKoSf7Cqcj29kIoUBVCc++ng
 Yzx76ArPCwEh7dtS16K8aVBQkzR0LSeuUfjrraALO47CCHpF9pxKsJMTyc5MVDRa5e
 x/P82JwokAzgA==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix interference issue regarding master
 thread.
Date: Thu, 18 Nov 2021 17:31:58 +0900
Message-Id: <20211118083158.1144-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 18 Nov 2021 08:32:27 -0000

- This patch fixes the issue that ReadConsoleInputW() call in the
  master thread interferes with the input process of non-cygwin apps.
---
 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index ea8d6e9e1..c838d15a2 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2042,6 +2042,7 @@ class dev_console
   char cons_rabuf[40];  // cannot get longer than char buf[40] in char_command
   char *cons_rapoi;
   bool cursor_key_app_mode;
+  bool disable_master_thread;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index f4241ee82..d9ed71af8 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -208,6 +208,12 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       DWORD total_read, n, i;
       INPUT_RECORD input_rec[INREC_SIZE];
 
+      if (con.disable_master_thread)
+	{
+	  cygwait (40);
+	  continue;
+	}
+
       WaitForSingleObject (p->input_mutex, INFINITE);
       total_read = 0;
       switch (cygwait (p->input_handle, (DWORD) 0))
@@ -427,6 +433,7 @@ fhandler_console::setup ()
       con.cons_rapoi = NULL;
       shared_console_info->tty_min_state.is_console = true;
       con.cursor_key_app_mode = false;
+      con.disable_master_thread = false;
     }
 }
 
@@ -480,6 +487,8 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
       else
 	flags |= ENABLE_MOUSE_INPUT;
+      if (shared_console_info)
+	con.disable_master_thread = false;
       break;
     case tty::native:
       if (t->c_lflag & ECHO)
@@ -492,6 +501,8 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 	flags &= ~ENABLE_ECHO_INPUT;
       if (t->c_lflag & ISIG)
 	flags |= ENABLE_PROCESSED_INPUT;
+      if (shared_console_info)
+	con.disable_master_thread = true;
       break;
     }
   SetConsoleMode (p->input_handle, flags);
-- 
2.33.0


Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id A55BF3858D35
 for <cygwin-patches@cygwin.com>; Sun, 20 Feb 2022 11:17:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A55BF3858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 21KBGko6020379;
 Sun, 20 Feb 2022 20:16:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 21KBGko6020379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645355811;
 bh=4bhgljP6egsgMWobuZ62OG9OUbdfEulxjJmqG28DtCg=;
 h=From:To:Cc:Subject:Date:From;
 b=ecInfI4yBPSHZQmdrducimyB/C227vglxdBVoJfhacf6VMhFdTeXqWqAq5UYZZk9C
 6hXoIpLPiTFt/EkS+PWYl4dUlQZpCcwVtMqHMj/hE2K5IzcSsWHBVWr6NvOsrikTem
 okPN19SiIeWXoJ47d1qiX9XoeNXrLxBdG0WKRW0XMLIFS+2new13NicVTmzV9eS+6E
 xs9zmDv5Mos//DzBVkInx9s5QiXIqF20gVvTDXdeHK/mrqDQwcWG+BvW1QNyeQg5G1
 KaNGCFSRribhkggu5Nu42r5mmQo0QAEjnf661CRW1caBpaqP0JdhTo2/6BUnTl0bIi
 Fa4E9apANeSlQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Call fix_tab_position() only if having
 broken tabs.
Date: Sun, 20 Feb 2022 20:16:36 +0900
Message-Id: <20220220111636.1000-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sun, 20 Feb 2022 11:17:21 -0000

- Calling fix_tab_position() is necessary in Windows 10 with xterm
  compatible mode enabled, because it has a problem that the tab
  positions will be broken when the window size is changed. Fortunately,
  this problem has been fixed in Windows 11. Therefore, with this patch,
  necessity of fix_tab_position() call is determined by referring to
  wincap.has_con_broken_tabs(), which is recently introduced.
---
 winsup/cygwin/fhandler_console.cc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 1dfe8e0c7..03ec88804 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -286,7 +286,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		{
 		  con.scroll_region.Top = 0;
 		  con.scroll_region.Bottom = -1;
-		  if (wincap.has_con_24bit_colors () && !con_is_legacy)
+		  if (wincap.has_con_24bit_colors () && !con_is_legacy
+		      && wincap.has_con_broken_tabs ())
 		    fix_tab_position (p->output_handle);
 		  ttyp->kill_pgrp (SIGWINCH);
 		}
@@ -664,7 +665,8 @@ fhandler_console::send_winch_maybe ()
     {
       con.scroll_region.Top = 0;
       con.scroll_region.Bottom = -1;
-      if (wincap.has_con_24bit_colors () && !con_is_legacy)
+      if (wincap.has_con_24bit_colors () && !con_is_legacy
+	  && wincap.has_con_broken_tabs ())
 	fix_tab_position (get_output_handle ());
       get_ttyp ()->kill_pgrp (SIGWINCH);
       return true;
@@ -2321,7 +2323,7 @@ fhandler_console::char_command (char c)
 		  if (con.args[i] == 1049)
 		    {
 		      con.screen_alternated = (c == 'h');
-		      need_fix_tab_position = true;
+		      need_fix_tab_position = wincap.has_con_broken_tabs ();
 		    }
 		  if (con.args[i] == 1) /* DECCKM */
 		    con.cursor_key_app_mode = (c == 'h');
-- 
2.35.1


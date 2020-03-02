Return-Path: <cygwin-patches-return-10154-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53169 invoked by alias); 2 Mar 2020 01:14:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53160 invoked by uid 89); 2 Mar 2020 01:14:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=col, 2048, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 01:14:01 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 0221D5nO031112;	Mon, 2 Mar 2020 10:13:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 0221D5nO031112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583111625;	bh=EwKiMpj0RRHNCapKQCWFG8rW6eCKBEvFTMVPUQu+r/8=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=qhF01xhH+ESdfWeFnAewRyGunBFFCdkhlqEBH6wHsxVo1wkzZqzVBr2FWDZ7W4kzP	 9h/rxkyPgAxQUK/wqiXwQz3ZAOvkMvyZBNKDMzGcpJx6ZEZOuBaxTbCj9hYkfoC9Br	 tc6SPH+J17KDLcPIEGzgn4eUICzd9p6BeyVefpUuVkc9Iah8ztuYiwNa0Q20ptffvj	 DRev+qBgWglg+3IGqe7A3G8u/5BtrU5d32DQA9ggshB2ALJ1U0OJ5fU3z+6mZcvHY1	 PekuvSHhpxkIF1yw/sBFlzCDq7yG7vBxB3KCp52c9D4hxXHnld1W20oKMV6Q/lyy/9	 fhy1wkvtXFMPg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/4] Cygwin: console: Revise the code to fix tab position.
Date: Mon, 02 Mar 2020 01:14:00 -0000
Message-Id: <20200302011258.592-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
References: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00260.txt

- This patch fixes the issue that the cursor position is broken if
  window size is changed while executing vim, less etc.
---
 winsup/cygwin/fhandler_console.cc | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 64e12b832..7c97a7868 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -417,19 +417,10 @@ fhandler_console::set_cursor_maybe ()
 void
 fhandler_console::fix_tab_position (void)
 {
-  char buf[2048] = {0,};
-  /* Save cursor position */
-  __small_sprintf (buf+strlen (buf), "\0337");
-  /* Clear all horizontal tabs */
-  __small_sprintf (buf+strlen (buf), "\033[3g");
-  /* Set horizontal tabs */
-  for (int col=8; col<con.dwWinSize.X; col+=8)
-    __small_sprintf (buf+strlen (buf), "\033[%d;%dH\033H", 1, col+1);
-  /* Restore cursor position */
-  __small_sprintf (buf+strlen (buf), "\0338");
+  /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
+     fixes the tab position. */
+  request_xterm_mode_output (false);
   request_xterm_mode_output (true);
-  DWORD dwLen;
-  WriteConsole (get_output_handle (), buf, strlen (buf), &dwLen, 0);
 }
 
 bool
-- 
2.21.0

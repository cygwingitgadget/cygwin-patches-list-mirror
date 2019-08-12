Return-Path: <cygwin-patches-return-9560-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53236 invoked by alias); 12 Aug 2019 13:48:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53137 invoked by uid 89); 12 Aug 2019 13:47:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=col, tabs, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 13:47:57 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x7CDlgv3024878;	Mon, 12 Aug 2019 22:47:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x7CDlgv3024878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565617669;	bh=RVY3gKe93L0yL0vcyL3nPluGdUXgbzg7LTcMbORt9k8=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=1q2oli9kIeD46e1JhjaN+TWJD8aGGSANQwzQKG+Dt9X0v8gwI8jUOIkwVh6W/np4p	 yi5L6YH80shpcq9fXXGM9A+MsiQAwtMMQ2x5LIjl6JcdAgVIulDPU9B6jfwb0eNKmA	 +i3Zh52G8uz8qj/vrQAdJvxUSX6+uIaX18ZVAKAGgj76A6lHFXpmAdKz0mlVy5IPBG	 JnMzne+tX15j2wKPHbdcPXgG5WxqA+/18Az11GGaMcKqOc5bygziW0wzSvZL9hOC0w	 wDzGRUmB3yitqOeLJA0CAV8a441OB4fwJ1FLOvsyEjGYQH6dPGIe5+thJEiQBn+ab8	 zW2Zwn1kC8n/A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: console: Add workaround for windows xterm compatible mode bug.
Date: Mon, 12 Aug 2019 13:48:00 -0000
Message-Id: <20190812134742.2151-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190812134742.2151-1-takashi.yano@nifty.ne.jp>
References: <20190812134742.2151-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00080.txt.bz2

- The horizontal tab positions are broken after resizing console window.
  This seems to be a bug of xterm compatible mode of windows console.
  This workaround fixes this problem.
---
 winsup/cygwin/fhandler_console.cc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 075593523..3d26a0b90 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -326,6 +326,25 @@ fhandler_console::send_winch_maybe ()
     {
       con.scroll_region.Top = 0;
       con.scroll_region.Bottom = -1;
+      if (wincap.has_con_24bit_colors ())
+	{
+	  /* Workaround for a bug of windows xterm compatible mode. */
+	  /* The horizontal tab positions are broken after resize. */
+	  DWORD dwLen;
+	  CONSOLE_SCREEN_BUFFER_INFO sbi;
+	  GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
+	  /* Clear all horizontal tabs */
+	  WriteConsole (get_output_handle (), "\033[3g", 4, &dwLen, 0);
+	  /* Set horizontal tabs */
+	  for (int col=8; col<con.dwWinSize.X; col+=8)
+	    {
+	      char buf[32];
+	      __small_sprintf (buf, "\033[%d;%dH\033H", 1, col+1);
+	      WriteConsole (get_output_handle (), buf, strlen (buf), &dwLen, 0);
+	    }
+	  /* Restore cursor position */
+	  SetConsoleCursorPosition (get_output_handle (), sbi.dwCursorPosition);
+	}
       get_ttyp ()->kill_pgrp (SIGWINCH);
       return true;
     }
-- 
2.21.0

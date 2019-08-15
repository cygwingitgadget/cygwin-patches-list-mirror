Return-Path: <cygwin-patches-return-9567-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15581 invoked by alias); 15 Aug 2019 05:02:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15571 invoked by uid 89); 15 Aug 2019 05:02:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 05:02:32 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x7F52Fin006491;	Thu, 15 Aug 2019 14:02:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x7F52Fin006491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565845343;	bh=IJqttle0gJU6N+q5r2cSST/S0Ud5Sd555Sg+QDjasSc=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=SNSmRak5KEOl/9w8NlYZ2mBuiTE5NuPwup7u+XvEMoY65LbDG/HTVEH/yoUx8fhnp	 qO6A44hxE5Gcewn79u0aZ+g1j8Pc91n62QD1cwTfAr+DNLDUfG11uFDs0WezD6CsMB	 TxkwxF9/TkQhDY9MlPA6N1a7BD+zU8ZBsu4XU4jbg0oyPszdcu/OdBMyLwbeKsBBQ1	 uTncYx4cGFu16hTys4UfMDU4iFz5rTXqkbyaOURaOIPZRjSov1yLvOUbM14mDjVhG2	 bDvgHqDhV99otit5BnL7bTmbGTV1BDa7Wy5bbH0v3VQgwvCeg1ckVJFU4MScVs5pzL	 R19kmI+wtsSAg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: console: Fix workaround for horizontal tab position
Date: Thu, 15 Aug 2019 05:02:00 -0000
Message-Id: <20190815050205.6331-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190815050205.6331-1-takashi.yano@nifty.ne.jp>
References: <20190815050205.6331-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00087.txt.bz2

- The workaround commit 33a21904a702191cebf0e81b4deba2dfa10a406c
  does not work as expected if window size is changed while screen
  is alternated. Fixed.
---
 winsup/cygwin/fhandler_console.cc | 47 +++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 4afb7efb7..67638055e 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -319,6 +319,25 @@ fhandler_console::set_cursor_maybe ()
     }
 }
 
+/* Workaround for a bug of windows xterm compatible mode. */
+/* The horizontal tab positions are broken after resize. */
+static void
+fix_tab_position (HANDLE h, SHORT width)
+{
+  char buf[2048] = {0,};
+  /* Save cursor position */
+  __small_sprintf (buf+strlen (buf), "\0337");
+  /* Clear all horizontal tabs */
+  __small_sprintf (buf+strlen (buf), "\033[3g");
+  /* Set horizontal tabs */
+  for (int col=8; col<width; col+=8)
+    __small_sprintf (buf+strlen (buf), "\033[%d;%dH\033H", 1, col+1);
+  /* Restore cursor position */
+  __small_sprintf (buf+strlen (buf), "\0338");
+  DWORD dwLen;
+  WriteConsole (h, buf, strlen (buf), &dwLen, 0);
+}
+
 bool
 fhandler_console::send_winch_maybe ()
 {
@@ -331,24 +350,7 @@ fhandler_console::send_winch_maybe ()
       con.scroll_region.Top = 0;
       con.scroll_region.Bottom = -1;
       if (wincap.has_con_24bit_colors ())
-	{
-	  /* Workaround for a bug of windows xterm compatible mode. */
-	  /* The horizontal tab positions are broken after resize. */
-	  DWORD dwLen;
-	  CONSOLE_SCREEN_BUFFER_INFO sbi;
-	  GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
-	  /* Clear all horizontal tabs */
-	  WriteConsole (get_output_handle (), "\033[3g", 4, &dwLen, 0);
-	  /* Set horizontal tabs */
-	  for (int col=8; col<con.dwWinSize.X; col+=8)
-	    {
-	      char buf[32];
-	      __small_sprintf (buf, "\033[%d;%dH\033H", 1, col+1);
-	      WriteConsole (get_output_handle (), buf, strlen (buf), &dwLen, 0);
-	    }
-	  /* Restore cursor position */
-	  SetConsoleCursorPosition (get_output_handle (), sbi.dwCursorPosition);
-	}
+	fix_tab_position (get_output_handle (), con.dwWinSize.X);
       get_ttyp ()->kill_pgrp (SIGWINCH);
       return true;
     }
@@ -1615,6 +1617,12 @@ static const wchar_t __vt100_conv[31] = {
 inline
 bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 {
+  bool need_fix_tab_position = false;
+  /* Check if screen will be alternated. */
+  if (wincap.has_con_24bit_colors ()
+      && memmem (buf, len*sizeof (WCHAR), L"\033[?1049", 7*sizeof (WCHAR)))
+    need_fix_tab_position = true;
+
   if (con.iso_2022_G1
 	? con.vt100_graphics_mode_G1
 	: con.vt100_graphics_mode_G0)
@@ -1633,6 +1641,9 @@ bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
       len -= done;
       buf += done;
     }
+  /* Call fix_tab_position() if screen has been alternated. */
+  if (need_fix_tab_position)
+    fix_tab_position (get_output_handle (), con.dwWinSize.X);
   return true;
 }
 
-- 
2.21.0

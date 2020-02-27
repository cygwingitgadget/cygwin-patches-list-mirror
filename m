Return-Path: <cygwin-patches-return-10135-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29009 invoked by alias); 27 Feb 2020 02:34:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29000 invoked by uid 89); 27 Feb 2020 02:34:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 27 Feb 2020 02:34:30 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 01R2XvJb001072;	Thu, 27 Feb 2020 11:34:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 01R2XvJb001072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582770843;	bh=EENsljYSJvBIyH7C/O3LXR90YyDTCKpQV3k7FJ8DG7c=;	h=From:To:Cc:Subject:Date:From;	b=P6xRz97Dhu4Imy49vOo1YNqT0FoxxJpKCi6mGjjoK5zk+Y+HjqQvjOzbsKEJHoMip	 pp10Cb97+kGFs4gHIsGL3ulwta87dY6uD22/oUvRwxax6Yrm4b4XUEUruWT68QjEo8	 jPI0Xgmk1wq9gW0CgX9vhyfwz6QaHDnDaiCzV0M1ClNX46C0LdCa2lsxtwb64ybGkg	 vxMNGrKEAoDOP74ph17cWYP/cpRAD3WzqrCZZeiJ59y9N8Tr8hMS6IchAmapMrPZTv	 rkI/n0GIzIBvZZxaNjgaNCoh/gL5naQZkL8AJ01+EE7ICXbEIXCrygSgG3IMHz4zOU	 H8RTa1wytftmQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Adjust the detailed behaviour of ESC sequences.
Date: Thu, 27 Feb 2020 02:34:00 -0000
Message-Id: <20200227023350.868-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00241.txt

- This patch makes some detailed behaviour of ESC sequences such as
  "CSI Ps L" (IL), "CSI Ps M" (DL) and "ESC M" (RI) in xterm mode
  match with real xterm.
---
 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 51 ++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 55f18aebd..c897380ae 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1861,6 +1861,7 @@ class dev_console
   bool saw_question_mark;
   bool saw_greater_than_sign;
   bool saw_space;
+  bool saw_exclamation_mark;
   bool vt100_graphics_mode_G0;
   bool vt100_graphics_mode_G1;
   bool iso_2022_G1;
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 4ab9bcab8..64e12b832 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2053,6 +2053,19 @@ fhandler_console::char_command (char c)
 	    {
 	      /* Use "CSI Ps T" instead */
 	      cursor_get (&x, &y);
+	      if (y < srTop || y > srBottom)
+		break;
+	      if (y == con.b.srWindow.Top
+		  && srBottom == con.b.srWindow.Bottom)
+		{
+		  /* Erase scroll down area */
+		  n = con.args[0] ? : 1;
+		  __small_sprintf (buf, "\033[%d;1H\033[J\033[%d;%dH",
+				   srBottom - (n-1) - con.b.srWindow.Top + 1,
+				   y + 1 - con.b.srWindow.Top, x + 1);
+		  WriteConsoleA (get_output_handle (),
+				 buf, strlen (buf), &wn, 0);
+		}
 	      __small_sprintf (buf, "\033[%d;%dr",
 			       y + 1 - con.b.srWindow.Top,
 			       srBottom + 1 - con.b.srWindow.Top);
@@ -2079,6 +2092,8 @@ fhandler_console::char_command (char c)
 	    {
 	      /* Use "CSI Ps S" instead */
 	      cursor_get (&x, &y);
+	      if (y < srTop || y > srBottom)
+		break;
 	      __small_sprintf (buf, "\033[%d;%dr",
 			       y + 1 - con.b.srWindow.Top,
 			       srBottom + 1 - con.b.srWindow.Top);
@@ -2137,6 +2152,16 @@ fhandler_console::char_command (char c)
 		fix_tab_position ();
 	    }
 	  break;
+	case 'p':
+	  if (con.saw_exclamation_mark) /* DECSTR Soft reset */
+	    {
+	      con.scroll_region.Top = 0;
+	      con.scroll_region.Bottom = -1;
+	    }
+	  wpbuf_put (c);
+	  /* Just send the sequence */
+	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  break;
 	default:
 	  /* Other escape sequences */
 	  wpbuf_put (c);
@@ -2970,6 +2995,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      con.saw_question_mark = false;
 	      con.saw_greater_than_sign = false;
 	      con.saw_space = false;
+	      con.saw_exclamation_mark = false;
 	    }
 	  else if (wincap.has_con_24bit_colors () && !con_is_legacy
 		   && wincap.has_con_broken_il_dl () && *src == 'M')
@@ -2979,13 +3005,17 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      cursor_get (&x, &y);
 	      if (y == srTop)
 		{
-		  /* Erase scroll down area */
-		  char buf[] = "\033[32768;1H\033[J\033[32768;32768";
-		  __small_sprintf (buf, "\033[%d;1H\033[J\033[%d;%dH",
-			     srBottom - con.b.srWindow.Top + 1,
-			     y + 1 - con.b.srWindow.Top, x + 1);
-		  WriteConsoleA (get_output_handle (),
-				 buf, strlen (buf), &n, 0);
+		  if (y == con.b.srWindow.Top
+		      && srBottom == con.b.srWindow.Bottom)
+		    {
+		      /* Erase scroll down area */
+		      char buf[] = "\033[32768;1H\033[J\033[32768;32768";
+		      __small_sprintf (buf, "\033[%d;1H\033[J\033[%d;%dH",
+				       srBottom - con.b.srWindow.Top + 1,
+				       y + 1 - con.b.srWindow.Top, x + 1);
+		      WriteConsoleA (get_output_handle (),
+				     buf, strlen (buf), &n, 0);
+		    }
 		  /* Substitute "CSI Ps T" */
 		  wpbuf_put ('[');
 		  wpbuf_put ('T');
@@ -2998,6 +3028,11 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    }
 	  else if (wincap.has_con_24bit_colors () && !con_is_legacy)
 	    { /* Only CSI is handled in xterm compatible mode. */
+	      if (*src == 'c') /* RIS Full reset */
+		{
+		  con.scroll_region.Top = 0;
+		  con.scroll_region.Bottom = -1;
+		}
 	      wpbuf_put (*src);
 	      /* Just send the sequence */
 	      DWORD n;
@@ -3169,6 +3204,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 		con.saw_question_mark = true;
 	      else if (*src == '>')
 		con.saw_greater_than_sign = true;
+	      else if (*src == '!')
+		con.saw_exclamation_mark = true;
 	      wpbuf_put (*src);
 	      /* ignore any extra chars between [ and first arg or command */
 	      src++;
-- 
2.21.0

Return-Path: <cygwin-patches-return-10157-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54871 invoked by alias); 2 Mar 2020 01:15:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54809 invoked by uid 89); 2 Mar 2020 01:15:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=pressed, Reverse, Reduce, osc
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 01:15:17 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 0221D5nU031112;	Mon, 2 Mar 2020 10:15:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 0221D5nU031112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583111713;	bh=NfXhcrazs7tVSEPfvvwJh/x8QswtfN1qw3pLs10I8Jo=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=ANcyFDfBJmdkpfmK+LudtJqCinXuUi7ZVBNAgeVdd5cF87WhqQ1pzFeqtUKPrPLtC	 Gs+IkNp0m+wv73043frY5Bq4bxOKu/CgDA3OS6Z91AE2KQD1rc5/w+pOFvgptzhuUv	 eJSQb2JEYUkpYy6/4NJ+T1wrAozJRLMtp4po9cDlTDlUa9xdWrQEiyB0OLKPmx9hzG	 bu+YA4MDWORepBJBw5unQWvP8N/Qk4N4ys/YWeTvzOCklzNBDPtu4hPAPMV4PKQYss	 SOK0ADHMMDRzWoEW8nekBXxoqa25nkCB1G4oQlucvROhUeXBrSfWIKyYLb6NIFkuYY	 bKjxaOuyfUZcA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 4/4] Cygwin: console: Add a workaround for "ESC 7" and "ESC 8".
Date: Mon, 02 Mar 2020 01:15:00 -0000
Message-Id: <20200302011258.592-5-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
References: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00263.txt

- In xterm compatible mode, "ESC 7" and "ESC 8" do not work properly
  in the senario:
   1) Execute /bin/ls /bin to fill screen.
   2) Sned CSI?1049h to alternate screen.
   3) Reduce window size.
   4) Send CSI?1049l to resume screen.
   5) Send "ESC 7" and "ESC 8".
  After sending "ESC 8", the cursor goes to incorrect position. This
  patch adds a workaround for this issue.
---
 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 53 +++++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index adaf19203..463bb83ab 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1869,6 +1869,7 @@ class dev_console
   bool alternate_charset_active;
   bool metabit;
   char backspace_keycode;
+  bool screen_alternated; /* For xterm compatible mode only */
 
   char my_title_buf [TITLESIZE + 1];
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 8b4687724..dffee240a 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -207,6 +207,8 @@ fhandler_console::setup ()
       con.dwLastCursorPosition.Y = -1;
       con.dwLastMousePosition.X = -1;
       con.dwLastMousePosition.Y = -1;
+      con.savex = con.savey = -1;
+      con.screen_alternated = false;
       con.dwLastButtonState = 0;	/* none pressed */
       con.last_button_code = 3;	/* released */
       con.underline_color = FOREGROUND_GREEN | FOREGROUND_BLUE;
@@ -2130,6 +2132,10 @@ fhandler_console::char_command (char c)
 	  break;
 	case 'h': /* DECSET */
 	case 'l': /* DECRST */
+	  if (c == 'h')
+	    con.screen_alternated = true;
+	  else
+	    con.screen_alternated = false;
 	  wpbuf_put (c);
 	  /* Just send the sequence */
 	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
@@ -2989,6 +2995,36 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      con.saw_space = false;
 	      con.saw_exclamation_mark = false;
 	    }
+	  else if (*src == '8')		/* DECRC Restore cursor position */
+	    {
+	      if (con.screen_alternated)
+		{
+		  /* For xterm mode only */
+		  DWORD n;
+		  /* Just send the sequence */
+		  wpbuf_put (*src);
+		  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+		}
+	      else if (con.savex >= 0 && con.savey >= 0)
+		cursor_set (false, con.savex, con.savey);
+	      con.state = normal;
+	      wpixput = 0;
+	    }
+	  else if (*src == '7')		/* DECSC Save cursor position */
+	    {
+	      if (con.screen_alternated)
+		{
+		  /* For xterm mode only */
+		  DWORD n;
+		  /* Just send the sequence */
+		  wpbuf_put (*src);
+		  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+		}
+	      else
+		cursor_get (&con.savex, &con.savey);
+	      con.state = normal;
+	      wpixput = 0;
+	    }
 	  else if (wincap.has_con_24bit_colors () && !con_is_legacy
 		   && wincap.has_con_broken_il_dl () && *src == 'M')
 	    { /* Reverse Index (scroll down) */
@@ -3019,12 +3055,15 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      wpixput = 0;
 	    }
 	  else if (wincap.has_con_24bit_colors () && !con_is_legacy)
-	    { /* Only CSI is handled in xterm compatible mode. */
+	    {
 	      if (*src == 'c') /* RIS Full reset */
 		{
 		  con.scroll_region.Top = 0;
 		  con.scroll_region.Bottom = -1;
 		}
+	      /* ESC sequences below (e.g. OSC, etc) are left to xterm
+		 emulation in xterm compatible mode, therefore, are not
+		 handled and just sent them. */
 	      wpbuf_put (*src);
 	      /* Just send the sequence */
 	      DWORD n;
@@ -3067,18 +3106,6 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      con.state = normal;
 	      wpixput = 0;
 	    }
-	  else if (*src == '8')		/* DECRC Restore cursor position */
-	    {
-	      cursor_set (false, con.savex, con.savey);
-	      con.state = normal;
-	      wpixput = 0;
-	    }
-	  else if (*src == '7')		/* DECSC Save cursor position */
-	    {
-	      cursor_get (&con.savex, &con.savey);
-	      con.state = normal;
-	      wpixput = 0;
-	    }
 	  else if (*src == 'R')		/* ? */
 	    {
 	      con.state = normal;
-- 
2.21.0

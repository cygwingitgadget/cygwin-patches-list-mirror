Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 978A0385736E
 for <cygwin-patches@cygwin.com>; Sun, 19 Jun 2022 04:14:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 978A0385736E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 25J4DpWv011343;
 Sun, 19 Jun 2022 13:13:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 25J4DpWv011343
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1655612036;
 bh=Fvp09sA9+AziDIUyMobZOyewUOEG7HGOi7LcVq3AZ9g=;
 h=From:To:Cc:Subject:Date:From;
 b=mnGykQ3wtRbZtXpYWoZNAvdZ5LR9Hz4hsYL993cB+XwEqEUphVKVpEUxlWV3WpuNa
 JF8xQvkwluU+WVfvnaKMSnU6z+9wcNQd8Dmpllx4U+CxQdq3sSH5gcuoV2N8gu+vJs
 x/xHlidTiq1NO69MrVMvKZvEuxWZZXoJnyd9480pmcYzB/CS2BaFnLCT5fsC0EFEGI
 GEWRBpkWoI0X+pS0lbDO7avfUXSy+TynzSp8UMpJoVMCqd/NbIJgPqCFLBWwsgUrme
 aOcQipB211Bt5XYaqg4kWvxJA7Pe4tOk/BW3vRdflhcEsWm543pHmu6M9loiHAg7D0
 Td1us05Io95bw==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Handle setting very long window title
 correctly.
Date: Sun, 19 Jun 2022 13:13:43 +0900
Message-Id: <20220619041343.11271-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sun, 19 Jun 2022 04:14:31 -0000

- Previously, the console code could not handle escape sequence
  setting window title longer than 256 byte correctly. This patch
  fixes the issue.
  Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251662.html
---
 winsup/cygwin/fhandler_console.cc | 90 ++++++++++++++++++++++---------
 winsup/cygwin/release/3.3.6       |  3 ++
 2 files changed, 69 insertions(+), 24 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 12c2c4f12..8f13c9f78 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -73,19 +73,59 @@ private:
   static const size_t WPBUF_LEN = 256u;
   char buf[WPBUF_LEN];
   size_t ixput;
+  HANDLE output_handle;
 public:
+  void init (HANDLE &handle)
+  {
+    output_handle = handle;
+    empty ();
+  }
   inline void put (char x)
   {
-    if (ixput < WPBUF_LEN)
-      buf[ixput++] = x;
+    if (ixput == WPBUF_LEN)
+      send ();
+    buf[ixput++] = x;
   }
   inline void empty () { ixput = 0u; }
-  inline void send (HANDLE &handle)
+  inline void send ()
   {
+    if (!output_handle)
+      {
+	empty ();
+	return;
+      }
+    mbtowc_p f_mbtowc =
+      (__MBTOWC == __ascii_mbtowc) ? __utf8_mbtowc : __MBTOWC;
     wchar_t bufw[WPBUF_LEN];
-    DWORD len = sys_mbstowcs (bufw, WPBUF_LEN, buf, ixput);
+    size_t len = 0;
+    mbstate_t ps;
+    memset (&ps, 0, sizeof (ps));
+    char *p = buf;
+    while (ixput)
+      {
+	int bytes = f_mbtowc (_REENT, bufw + len, p, ixput, &ps);
+	if (bytes < 0)
+	  {
+	    if ((size_t) ps.__count < ixput)
+	      { /* Discard one byte and retry. */
+		p++;
+		ixput--;
+		memset (&ps, 0, sizeof (ps));
+		continue;
+	      }
+	    /* Halfway through the multibyte char. */
+	    memmove (buf, p, ixput);
+	    break;
+	  }
+	else
+	  {
+	    len++;
+	    p += bytes;
+	    ixput -= bytes;
+	  }
+      }
     acquire_attach_mutex (mutex_timeout);
-    WriteConsoleW (handle, bufw, len, NULL, 0);
+    WriteConsoleW (output_handle, bufw, len, NULL, 0);
     release_attach_mutex ();
   }
 } wpbuf;
@@ -1485,6 +1525,7 @@ fhandler_console::open (int flags, mode_t)
     }
   set_output_handle (h);
   handle_set.output_handle = h;
+  wpbuf.init (get_output_handle ());
 
   setup_io_mutex ();
   handle_set.input_mutex = input_mutex;
@@ -2353,7 +2394,7 @@ fhandler_console::char_command (char c)
 	  wpbuf.put (c);
 	  if (wincap.has_con_esc_rep ())
 	    /* Just send the sequence */
-	    wpbuf.send (get_output_handle ());
+	    wpbuf.send ();
 	  else if (last_char && last_char != L'\n')
 	    {
 	      acquire_attach_mutex (mutex_timeout);
@@ -2367,7 +2408,7 @@ fhandler_console::char_command (char c)
 	  con.scroll_region.Bottom = con.args[1] ? con.args[1] - 1 : -1;
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle ());
+	  wpbuf.send ();
 	  break;
 	case 'L': /* IL */
 	  if (wincap.has_con_broken_il_dl ())
@@ -2400,7 +2441,7 @@ fhandler_console::char_command (char c)
 				srBottom + 1 - con.b.srWindow.Top);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
 	      wpbuf.put ('T');
-	      wpbuf.send (get_output_handle ());
+	      wpbuf.send ();
 	      __small_swprintf (bufw, L"\033[%d;%dr",
 				srTop + 1 - con.b.srWindow.Top,
 				srBottom + 1 - con.b.srWindow.Top);
@@ -2414,7 +2455,7 @@ fhandler_console::char_command (char c)
 	    {
 	      wpbuf.put (c);
 	      /* Just send the sequence */
-	      wpbuf.send (get_output_handle ());
+	      wpbuf.send ();
 	    }
 	  break;
 	case 'M': /* DL */
@@ -2437,7 +2478,7 @@ fhandler_console::char_command (char c)
 	      acquire_attach_mutex (mutex_timeout);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
 	      wpbuf.put ('S');
-	      wpbuf.send (get_output_handle ());
+	      wpbuf.send ();
 	      __small_swprintf (bufw, L"\033[%d;%dr",
 				srTop + 1 - con.b.srWindow.Top,
 				srBottom + 1 - con.b.srWindow.Top);
@@ -2451,7 +2492,7 @@ fhandler_console::char_command (char c)
 	    {
 	      wpbuf.put (c);
 	      /* Just send the sequence */
-	      wpbuf.send (get_output_handle ());
+	      wpbuf.send ();
 	    }
 	  break;
 	case 'J': /* ED */
@@ -2480,13 +2521,13 @@ fhandler_console::char_command (char c)
 	    }
 	  else
 	    /* Just send the sequence */
-	    wpbuf.send (get_output_handle ());
+	    wpbuf.send ();
 	  break;
 	case 'h': /* DECSET */
 	case 'l': /* DECRST */
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle ());
+	  wpbuf.send ();
 	  if (con.saw_question_mark)
 	    {
 	      bool need_fix_tab_position = false;
@@ -2515,7 +2556,7 @@ fhandler_console::char_command (char c)
 	    }
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle ());
+	  wpbuf.send ();
 	  break;
 	case 'm':
 	  if (con.saw_greater_than_sign)
@@ -2523,13 +2564,13 @@ fhandler_console::char_command (char c)
 	  /* Text attribute settings */
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle ());
+	  wpbuf.send ();
 	  break;
 	default:
 	  /* Other escape sequences */
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle ());
+	  wpbuf.send ();
 	  break;
 	}
       return;
@@ -3380,7 +3421,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		  /* For xterm mode only */
 		  /* Just send the sequence */
 		  wpbuf.put (*src);
-		  wpbuf.send (get_output_handle ());
+		  wpbuf.send ();
 		}
 	      else if (con.savex >= 0 && con.savey >= 0)
 		cursor_set (false, con.savex, con.savey);
@@ -3394,7 +3435,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		  /* For xterm mode only */
 		  /* Just send the sequence */
 		  wpbuf.put (*src);
-		  wpbuf.send (get_output_handle ());
+		  wpbuf.send ();
 		}
 	      else
 		cursor_get (&con.savex, &con.savey);
@@ -3427,7 +3468,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		}
 	      else
 		wpbuf.put (*src);
-	      wpbuf.send (get_output_handle ());
+	      wpbuf.send ();
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
@@ -3452,7 +3493,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		 handled and just sent them. */
 	      wpbuf.put (*src);
 	      /* Just send the sequence */
-	      wpbuf.send (get_output_handle ());
+	      wpbuf.send ();
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
@@ -3549,7 +3590,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    {
 	      wpbuf.put (*src);
 	      if (wincap.has_con_24bit_colors () && !con_is_legacy)
-		wpbuf.send (get_output_handle ());
+		wpbuf.send ();
 	      wpbuf.empty ();
 	      con.state = normal;
 	      src++;
@@ -3566,7 +3607,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    if (*src < ' ')
 	      {
 		if (wincap.has_con_24bit_colors () && !con_is_legacy)
-		  wpbuf.send (get_output_handle ());
+		  wpbuf.send ();
 		else if (*src == '\007' && con.state == gettitle)
 		  set_console_title (con.my_title_buf);
 		con.state = normal;
@@ -3591,7 +3632,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      /* Send OSC Ps; Pt BEL other than OSC Ps; ? BEL */
 	      if (wincap.has_con_24bit_colors () && !con_is_legacy
 		  && !con.saw_question_mark)
-		wpbuf.send (get_output_handle ());
+		wpbuf.send ();
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
@@ -3604,7 +3645,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      /* Send OSC Ps; Pt ST other than OSC Ps; ? ST */
 	      if (wincap.has_con_24bit_colors () && !con_is_legacy
 		  && !con.saw_question_mark)
-		wpbuf.send (get_output_handle ());
+		wpbuf.send ();
 	      con.state = normal;
 	    }
 	  else
@@ -3868,6 +3909,7 @@ fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
   setup_io_mutex ();
+  wpbuf.init (get_output_handle ());
 
   if (!execing)
     return;
diff --git a/winsup/cygwin/release/3.3.6 b/winsup/cygwin/release/3.3.6
index bccc5124c..49ac58ba4 100644
--- a/winsup/cygwin/release/3.3.6
+++ b/winsup/cygwin/release/3.3.6
@@ -14,3 +14,6 @@ Bug Fixes
 - Fix a regression that prevented Cygwin from starting if cygwin1.dll
   is in the root directory.
   Addresses: https://cygwin.com/pipermail/cygwin/2022-May/251548.html
+
+- Handle setting very long window title correctly in console.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251662.html
-- 
2.36.1


Return-Path: <HBBroeker@T-Online.de>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
 by server2.sourceware.org (Postfix) with ESMTPS id D04B5394B021
 for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2020 20:41:41 +0000 (GMT)
Received: from fwd05.aul.t-online.de (fwd05.aul.t-online.de [172.20.27.149])
 by mailout08.t-online.de (Postfix) with SMTP id 107324184ECA
 for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2020 21:41:40 +0100 (CET)
Received: from localhost.localdomain
 (SsZQHOZBYhrrqaaX09RPHW+Mm7IPLpa5uSWldFGJSpLOXvOzVI48yFHwYJx3Ay5QMe@[79.228.65.18])
 by fwd05.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jB2jp-2MDcNY0; Sun, 8 Mar 2020 21:41:29 +0100
From: Hans-Bernhard Broeker <HBBroeker@T-Online.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Do not bother passing optional argument to WriteConsoleA.
Date: Sun,  8 Mar 2020 21:41:14 +0100
Message-Id: <f943caafebffc61537d8d9f9329a8b1b1b6be2f5.1583611115.git.HBBroeker@T-Online.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1583611115.git.HBBroeker@T-Online.de>
References: <cover.1583611115.git.HBBroeker@T-Online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ID: SsZQHOZBYhrrqaaX09RPHW+Mm7IPLpa5uSWldFGJSpLOXvOzVI48yFHwYJx3Ay5QMe
X-TOI-MSGID: b1be80a8-c580-41d7-b3c5-7ecc3816c5a2
X-Spam-Status: No, score=-24.9 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 GIT_PATCH_0, GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, PDS_OTHER_BAD_TLD,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 08 Mar 2020 20:41:42 -0000

Passing a pointer to a local variable to WriteConsoleA is
not actually needed if we're not going to do anything with
what WriteConsoleA would put in there.

For the wpbuf class the pointer argument was made optional,
so it can be just left out; other call places now pass a
NULL pointer instead.  The local variables `wn' and `n'
are no unused, so they go away.
---
 winsup/cygwin/fhandler_console.cc | 51 ++++++++++++++-----------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 9d7a9e9ea..1c376291f 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2015,7 +2015,6 @@ fhandler_console::char_command (char c)
   if (wincap.has_con_24bit_colors () && !con_is_legacy)
     {
       /* For xterm compatible mode */
-      DWORD wn;
       switch (c)
 	{
 #if 0 /* These sequences, which are supported by real xterm, are
@@ -2044,17 +2043,17 @@ fhandler_console::char_command (char c)
 	  wpbuf.put (c);
 	  if (wincap.has_con_esc_rep ())
 	    /* Just send the sequence */
-	    wpbuf.send (get_output_handle (), &wn);
+	    wpbuf.send (get_output_handle ());
 	  else if (last_char && last_char != '\n')
 	    for (int i = 0; i < con.args[0]; i++)
-	      WriteConsoleA (get_output_handle (), &last_char, 1, &wn, 0);
+	      WriteConsoleA (get_output_handle (), &last_char, 1, 0, 0);
 	  break;
 	case 'r': /* DECSTBM */
 	  con.scroll_region.Top = con.args[0] ? con.args[0] - 1 : 0;
 	  con.scroll_region.Bottom = con.args[1] ? con.args[1] - 1 : -1;
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle (), &wn);
+	  wpbuf.send (get_output_handle ());
 	  break;
 	case 'L': /* IL */
 	  if (wincap.has_con_broken_il_dl ())
@@ -2072,27 +2071,27 @@ fhandler_console::char_command (char c)
 				   srBottom - (n-1) - con.b.srWindow.Top + 1,
 				   y + 1 - con.b.srWindow.Top, x + 1);
 		  WriteConsoleA (get_output_handle (),
-				 buf, strlen (buf), &wn, 0);
+				 buf, strlen (buf), 0, 0);
 		}
 	      __small_sprintf (buf, "\033[%d;%dr",
 			       y + 1 - con.b.srWindow.Top,
 			       srBottom + 1 - con.b.srWindow.Top);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
 	      wpbuf.put ('T');
-	      wpbuf.send (get_output_handle (), &wn);
+	      wpbuf.send (get_output_handle ());
 	      __small_sprintf (buf, "\033[%d;%dr",
 			       srTop + 1 - con.b.srWindow.Top,
 			       srBottom + 1 - con.b.srWindow.Top);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
 	      __small_sprintf (buf, "\033[%d;%dH",
 			       y + 1 - con.b.srWindow.Top, x + 1);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
 	    }
 	  else
 	    {
 	      wpbuf.put (c);
 	      /* Just send the sequence */
-	      wpbuf.send (get_output_handle (), &wn);
+	      wpbuf.send (get_output_handle ());
 	    }
 	  break;
 	case 'M': /* DL */
@@ -2105,22 +2104,22 @@ fhandler_console::char_command (char c)
 	      __small_sprintf (buf, "\033[%d;%dr",
 			       y + 1 - con.b.srWindow.Top,
 			       srBottom + 1 - con.b.srWindow.Top);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
 	      wpbuf.put ('S');
-	      wpbuf.send (get_output_handle (), &wn);
+	      wpbuf.send (get_output_handle ());
 	      __small_sprintf (buf, "\033[%d;%dr",
 			       srTop + 1 - con.b.srWindow.Top,
 			       srBottom + 1 - con.b.srWindow.Top);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
 	      __small_sprintf (buf, "\033[%d;%dH",
 			       y + 1 - con.b.srWindow.Top, x + 1);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
 	    }
 	  else
 	    {
 	      wpbuf.put (c);
 	      /* Just send the sequence */
-	      wpbuf.send (get_output_handle (), &wn);
+	      wpbuf.send (get_output_handle ());
 	    }
 	  break;
 	case 'J': /* ED */
@@ -2142,7 +2141,7 @@ fhandler_console::char_command (char c)
 	    }
 	  else
 	    /* Just send the sequence */
-	    wpbuf.send (get_output_handle (), &wn);
+	    wpbuf.send (get_output_handle ());
 	  break;
 	case 'h': /* DECSET */
 	case 'l': /* DECRST */
@@ -2152,7 +2151,7 @@ fhandler_console::char_command (char c)
 	    con.screen_alternated = false;
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle (), &wn);
+	  wpbuf.send (get_output_handle ());
 	  if (con.saw_question_mark)
 	    {
 	      bool need_fix_tab_position = false;
@@ -2172,13 +2171,13 @@ fhandler_console::char_command (char c)
 	    }
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle (), &wn);
+	  wpbuf.send (get_output_handle ());
 	  break;
 	default:
 	  /* Other escape sequences */
 	  wpbuf.put (c);
 	  /* Just send the sequence */
-	  wpbuf.send (get_output_handle (), &wn);
+	  wpbuf.send (get_output_handle ());
 	  break;
 	}
       return;
@@ -3014,10 +3013,9 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      if (con.screen_alternated)
 		{
 		  /* For xterm mode only */
-		  DWORD n;
 		  /* Just send the sequence */
 		  wpbuf.put (*src);
-		  wpbuf.send (get_output_handle (), &n);
+		  wpbuf.send (get_output_handle ());
 		}
 	      else if (con.savex >= 0 && con.savey >= 0)
 		cursor_set (false, con.savex, con.savey);
@@ -3029,10 +3027,9 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      if (con.screen_alternated)
 		{
 		  /* For xterm mode only */
-		  DWORD n;
 		  /* Just send the sequence */
 		  wpbuf.put (*src);
-		  wpbuf.send (get_output_handle (), &n);
+		  wpbuf.send (get_output_handle ());
 		}
 	      else
 		cursor_get (&con.savex, &con.savey);
@@ -3043,7 +3040,6 @@ fhandler_console::write (const void *vsrc, size_t len)
 		   && wincap.has_con_broken_il_dl () && *src == 'M')
 	    { /* Reverse Index (scroll down) */
 	      int x, y;
-	      DWORD n;
 	      cursor_get (&x, &y);
 	      if (y == srTop)
 		{
@@ -3056,7 +3052,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 				       srBottom - con.b.srWindow.Top + 1,
 				       y + 1 - con.b.srWindow.Top, x + 1);
 		      WriteConsoleA (get_output_handle (),
-				     buf, strlen (buf), &n, 0);
+				     buf, strlen (buf), 0, 0);
 		    }
 		  /* Substitute "CSI Ps T" */
 		  wpbuf.put ('[');
@@ -3064,7 +3060,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		}
 	      else
 		wpbuf.put (*src);
-	      wpbuf.send (get_output_handle (), &n);
+	      wpbuf.send (get_output_handle ());
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
@@ -3080,8 +3076,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		 handled and just sent them. */
 	      wpbuf.put (*src);
 	      /* Just send the sequence */
-	      DWORD n;
-	      wpbuf.send (get_output_handle (), &n);
+	      wpbuf.send (get_output_handle ());
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
-- 
2.21.0


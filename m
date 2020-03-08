Return-Path: <HBBroeker@t-online.de>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
 by server2.sourceware.org (Postfix) with ESMTPS id BBEB93943546
 for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2020 13:47:54 +0000 (GMT)
Received: from fwd32.aul.t-online.de (fwd32.aul.t-online.de [172.20.26.144])
 by mailout01.t-online.de (Postfix) with SMTP id 6DBE14284946
 for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2020 14:47:52 +0100 (CET)
Received: from [192.168.178.26]
 (bVaCC2ZFQhHPpe4aZfxp7By2JKTFQ3pppCVdMKYStwV3uJLsoZ5mXculVAIyo+VZtr@[79.228.65.18])
 by fwd32.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jAwHO-0AUslM0; Sun, 8 Mar 2020 14:47:42 +0100
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Subject: [PATCH 1/2] Collect handling of wpixput and wpbuf into a helper class.
References: <cover.1583611115.git.HBBroeker@T-Online.de>
To: cygwin-patches@cygwin.com
Message-ID: <4b2b3e5b-2f9c-43c4-3f18-64ad1f86b0bc@t-online.de>
Date: Sun, 8 Mar 2020 14:47:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1583611115.git.HBBroeker@T-Online.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-ID: bVaCC2ZFQhHPpe4aZfxp7By2JKTFQ3pppCVdMKYStwV3uJLsoZ5mXculVAIyo+VZtr
X-TOI-MSGID: b6feb28d-de38-49d3-8793-38583e2cc5fd
X-Spam-Status: No, score=-26.4 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 GIT_PATCH_0, GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, PDS_OTHER_BAD_TLD,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
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
X-List-Received-Date: Sun, 08 Mar 2020 13:47:56 -0000

Replace direct access to a pair of co-dependent variables
by calls to methods of a class that encapsulates their relation.

Also replace C #define by C++ class constant.
---
  winsup/cygwin/fhandler_console.cc | 141 ++++++++++++++++--------------
  1 file changed, 76 insertions(+), 65 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc 
b/winsup/cygwin/fhandler_console.cc
index c5f269168..9d7a9e9ea 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -59,17 +59,28 @@ static struct fhandler_base::rabuf_t con_ra;
   /* Write pending buffer for ESC sequence handling
     in xterm compatible mode */
-#define WPBUF_LEN 256
-static unsigned char wpbuf[WPBUF_LEN];
-static int wpixput;
  static unsigned char last_char;
  -static inline void
-wpbuf_put (unsigned char x)
+/* simple helper class to accumulate output in a buffer
+   and send that to the console on request: */
+static class write_pending_bufferOA
  {
-  if (wpixput < WPBUF_LEN)
-    wpbuf[wpixput++] = x;
-}
+private:
+  static const size_t WPBUF_LEN = 256u;
+  unsigned char buf[WPBUF_LEN];
+  size_t ixput;
+public:
+  inline void put (unsigned char x)
+  {
+    if (ixput < WPBUF_LEN)
+      buf[ixput++] = x;
+  }
+  inline void empty () { ixput = 0u; }
+  inline void send (HANDLE &handle, DWORD *wn = NULL)
+  {
+    WriteConsoleA (handle, buf, ixput, wn, 0);
+  }
+} wpbuf;
   static void
  beep ()
@@ -2030,10 +2041,10 @@ fhandler_console::char_command (char c)
  	  break;
  #endif
  	case 'b': /* REP */
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  if (wincap.has_con_esc_rep ())
  	    /* Just send the sequence */
-	    WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	    wpbuf.send (get_output_handle (), &wn);
  	  else if (last_char && last_char != '\n')
  	    for (int i = 0; i < con.args[0]; i++)
  	      WriteConsoleA (get_output_handle (), &last_char, 1, &wn, 0);
@@ -2041,9 +2052,9 @@ fhandler_console::char_command (char c)
  	case 'r': /* DECSTBM */
  	  con.scroll_region.Top = con.args[0] ? con.args[0] - 1 : 0;
  	  con.scroll_region.Bottom = con.args[1] ? con.args[1] - 1 : -1;
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  /* Just send the sequence */
-	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  wpbuf.send (get_output_handle (), &wn);
  	  break;
  	case 'L': /* IL */
  	  if (wincap.has_con_broken_il_dl ())
@@ -2067,8 +2078,8 @@ fhandler_console::char_command (char c)
  			       y + 1 - con.b.srWindow.Top,
  			       srBottom + 1 - con.b.srWindow.Top);
  	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
-	      wpbuf_put ('T');
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      wpbuf.put ('T');
+	      wpbuf.send (get_output_handle (), &wn);
  	      __small_sprintf (buf, "\033[%d;%dr",
  			       srTop + 1 - con.b.srWindow.Top,
  			       srBottom + 1 - con.b.srWindow.Top);
@@ -2079,9 +2090,9 @@ fhandler_console::char_command (char c)
  	    }
  	  else
  	    {
-	      wpbuf_put (c);
+	      wpbuf.put (c);
  	      /* Just send the sequence */
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      wpbuf.send (get_output_handle (), &wn);
  	    }
  	  break;
  	case 'M': /* DL */
@@ -2095,8 +2106,8 @@ fhandler_console::char_command (char c)
  			       y + 1 - con.b.srWindow.Top,
  			       srBottom + 1 - con.b.srWindow.Top);
  	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
-	      wpbuf_put ('S');
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      wpbuf.put ('S');
+	      wpbuf.send (get_output_handle (), &wn);
  	      __small_sprintf (buf, "\033[%d;%dr",
  			       srTop + 1 - con.b.srWindow.Top,
  			       srBottom + 1 - con.b.srWindow.Top);
@@ -2107,13 +2118,13 @@ fhandler_console::char_command (char c)
  	    }
  	  else
  	    {
-	      wpbuf_put (c);
+	      wpbuf.put (c);
  	      /* Just send the sequence */
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      wpbuf.send (get_output_handle (), &wn);
  	    }
  	  break;
  	case 'J': /* ED */
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  if (con.args[0] == 3 && wincap.has_con_broken_csi3j ())
  	    { /* Workaround for broken CSI3J in Win10 1809 */
  	      CONSOLE_SCREEN_BUFFER_INFO sbi;
@@ -2131,7 +2142,7 @@ fhandler_console::char_command (char c)
  	    }
  	  else
  	    /* Just send the sequence */
-	    WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	    wpbuf.send (get_output_handle (), &wn);
  	  break;
  	case 'h': /* DECSET */
  	case 'l': /* DECRST */
@@ -2139,9 +2150,9 @@ fhandler_console::char_command (char c)
  	    con.screen_alternated = true;
  	  else
  	    con.screen_alternated = false;
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  /* Just send the sequence */
-	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  wpbuf.send (get_output_handle (), &wn);
  	  if (con.saw_question_mark)
  	    {
  	      bool need_fix_tab_position = false;
@@ -2159,15 +2170,15 @@ fhandler_console::char_command (char c)
  	      con.scroll_region.Top = 0;
  	      con.scroll_region.Bottom = -1;
  	    }
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  /* Just send the sequence */
-	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  wpbuf.send (get_output_handle (), &wn);
  	  break;
  	default:
  	  /* Other escape sequences */
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  /* Just send the sequence */
-	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  wpbuf.send (get_output_handle (), &wn);
  	  break;
  	}
        return;
@@ -2874,7 +2885,7 @@ do_print:
  	  break;
  	case ESC:
  	  con.state = gotesc;
-	  wpbuf_put (*found);
+	  wpbuf.put (*found);
  	  break;
  	case DWN:
  	  cursor_get (&x, &y);
@@ -2989,7 +3000,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	case gotesc:
  	  if (*src == '[')		/* CSI Control Sequence Introducer */
  	    {
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      con.state = gotsquare;
  	      memset (con.args, 0, sizeof con.args);
  	      con.nargs = 0;
@@ -3005,13 +3016,13 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  		  /* For xterm mode only */
  		  DWORD n;
  		  /* Just send the sequence */
-		  wpbuf_put (*src);
-		  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+		  wpbuf.put (*src);
+		  wpbuf.send (get_output_handle (), &n);
  		}
  	      else if (con.savex >= 0 && con.savey >= 0)
  		cursor_set (false, con.savex, con.savey);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (*src == '7')		/* DECSC Save cursor position */
  	    {
@@ -3020,13 +3031,13 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  		  /* For xterm mode only */
  		  DWORD n;
  		  /* Just send the sequence */
-		  wpbuf_put (*src);
-		  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+		  wpbuf.put (*src);
+		  wpbuf.send (get_output_handle (), &n);
  		}
  	      else
  		cursor_get (&con.savex, &con.savey);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (wincap.has_con_24bit_colors () && !con_is_legacy
  		   && wincap.has_con_broken_il_dl () && *src == 'M')
@@ -3048,14 +3059,14 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  				     buf, strlen (buf), &n, 0);
  		    }
  		  /* Substitute "CSI Ps T" */
-		  wpbuf_put ('[');
-		  wpbuf_put ('T');
+		  wpbuf.put ('[');
+		  wpbuf.put ('T');
  		}
  	      else
-		wpbuf_put (*src);
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+		wpbuf.put (*src);
+	      wpbuf.send (get_output_handle (), &n);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (wincap.has_con_24bit_colors () && !con_is_legacy)
  	    {
@@ -3067,28 +3078,28 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  	      /* ESC sequences below (e.g. OSC, etc) are left to xterm
  		 emulation in xterm compatible mode, therefore, are not
  		 handled and just sent them. */
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      /* Just send the sequence */
  	      DWORD n;
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+	      wpbuf.send (get_output_handle (), &n);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (*src == ']')		/* OSC Operating System Command */
  	    {
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      con.rarg = 0;
  	      con.my_title_buf[0] = '\0';
  	      con.state = gotrsquare;
  	    }
  	  else if (*src == '(')		/* Designate G0 character set */
  	    {
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      con.state = gotparen;
  	    }
  	  else if (*src == ')')		/* Designate G1 character set */
  	    {
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      con.state = gotrparen;
  	    }
  	  else if (*src == 'M')		/* Reverse Index (scroll down) */
@@ -3096,7 +3107,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	      con.fillin (get_output_handle ());
  	      scroll_buffer_screen (0, 0, -1, -1, 0, 1);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (*src == 'c')		/* RIS Full Reset */
  	    {
@@ -3107,17 +3118,17 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  	      cursor_set (false, 0, 0);
  	      clear_screen (cl_buf_beg, cl_buf_beg, cl_buf_end, cl_buf_end);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (*src == 'R')		/* ? */
  	    {
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else
  	    {
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  src++;
  	  break;
@@ -3126,19 +3137,19 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  	    {
  	      if (con.nargs < MAXARGS)
  		con.args[con.nargs] = con.args[con.nargs] * 10 + *src - '0';
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      src++;
  	    }
  	  else if (*src == ';')
  	    {
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      src++;
  	      if (con.nargs < MAXARGS)
  		con.nargs++;
  	    }
  	  else if (*src == ' ')
  	    {
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      src++;
  	      con.saw_space = true;
  	      con.state = gotcommand;
@@ -3151,7 +3162,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	    con.nargs++;
  	  char_command (*src++);
  	  con.state = normal;
-	  wpixput = 0;
+	  wpbuf.empty();
  	  break;
  	case gotrsquare:
  	  if (isdigit (*src))
@@ -3162,7 +3173,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	    con.state = eatpalette;
  	  else
  	    con.state = eattitle;
-	  wpbuf_put (*src);
+	  wpbuf.put (*src);
  	  src++;
  	  break;
  	case eattitle:
@@ -3174,13 +3185,13 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  		if (*src == '\007' && con.state == gettitle)
  		  set_console_title (con.my_title_buf);
  		con.state = normal;
-		wpixput = 0;
+		wpbuf.empty();
  	      }
  	    else if (n < TITLESIZE)
  	      {
  		con.my_title_buf[n++] = *src;
  		con.my_title_buf[n] = '\0';
-		wpbuf_put (*src);
+		wpbuf.put (*src);
  	      }
  	    src++;
  	    break;
@@ -3188,13 +3199,13 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  	case eatpalette:
  	  if (*src == '\033')
  	    {
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      con.state = endpalette;
  	    }
  	  else if (*src == '\a')
  	    {
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  src++;
  	  break;
@@ -3204,14 +3215,14 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  	  else
  	    /* Sequence error (abort) */
  	    con.state = normal;
-	  wpixput = 0;
+	  wpbuf.empty();
  	  src++;
  	  break;
  	case gotsquare:
  	  if (*src == ';')
  	    {
  	      con.state = gotarg1;
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      if (con.nargs < MAXARGS)
  		con.nargs++;
  	      src++;
@@ -3226,7 +3237,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  		con.saw_greater_than_sign = true;
  	      else if (*src == '!')
  		con.saw_exclamation_mark = true;
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      /* ignore any extra chars between [ and first arg or command */
  	      src++;
  	    }
@@ -3239,7 +3250,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	  else
  	    con.vt100_graphics_mode_G0 = false;
  	  con.state = normal;
-	  wpixput = 0;
+	  wpbuf.empty();
  	  src++;
  	  break;
  	case gotrparen:	/* Designate G1 Character Set (ISO 2022) */
@@ -3248,7 +3259,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	  else
  	    con.vt100_graphics_mode_G1 = false;
  	  con.state = normal;
-	  wpixput = 0;
+	  wpbuf.empty();
  	  src++;
  	  break;
  	}
-- 
2.21.0


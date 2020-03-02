Return-Path: <cygwin-patches-return-10165-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126403 invoked by alias); 2 Mar 2020 23:07:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126384 invoked by uid 89); 2 Mar 2020 23:07:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPOOFED_FREEMAIL autolearn=ham version=3.3.1 spammy=designate, Operating, HANDLE, sbi
X-HELO: mailout01.t-online.de
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 23:07:31 +0000
Received: from fwd34.aul.t-online.de (fwd34.aul.t-online.de [172.20.26.145])	by mailout01.t-online.de (Postfix) with SMTP id 1ED1042662E1	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2020 00:07:29 +0100 (CET)
Received: from [192.168.178.26] (S9MkPsZLYhuz-LbNna-zaxNk1Cy8woW1Rdwprdhf-L+yw1AlSSv3a73vtlgEjxjwcd@[79.228.65.18]) by fwd34.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)	esmtp id 1j8u9l-17gFNo0; Tue, 3 Mar 2020 00:07:25 +0100
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Subject: [PATCH 1/1] Collect handling of wpixput and wpbuf into a helper class.
To: cygwin-patches@cygwin.com
Message-ID: <877f246b-08c2-6ccd-faac-6c90661212e5@t-online.de>
Date: Mon, 02 Mar 2020 23:07:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00271.txt

Replace direct access to a pair of co-dependent variables
by calls to methods of a class that encapsulates their relation.

Also replace C #define by C++ class constant.
---
  winsup/cygwin/fhandler_console.cc | 135 ++++++++++++++++--------------
  1 file changed, 70 insertions(+), 65 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc 
b/winsup/cygwin/fhandler_console.cc
index c5f269168..af2fb11a4 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -59,17 +59,22 @@ static struct fhandler_base::rabuf_t con_ra;
   /* Write pending buffer for ESC sequence handling
     in xterm compatible mode */
-#define WPBUF_LEN 256
-static unsigned char wpbuf[WPBUF_LEN];
-static int wpixput;
  static unsigned char last_char;
  -static inline void
-wpbuf_put (unsigned char x)
+// simple helper class to accumulate output in a buffer
+// and send that to the console on request:
+static class WritePendingBuf
  {
-  if (wpixput < WPBUF_LEN)
-    wpbuf[wpixput++] = x;
-}
+private:
+  static const size_t WPBUF_LEN = 256u;
+  unsigned char buf[WPBUF_LEN];
+  size_t ixput;
+
+public:
+  inline void put(unsigned char x) { if (ixput < WPBUF_LEN) { 
buf[ixput++] = x; } };
+  inline void empty() { ixput = 0u; };
+  inline void sendOut(HANDLE &handle, DWORD *wn) { WriteConsoleA 
(handle, buf, ixput, wn, 0); };
+} wpbuf;
   static void
  beep ()
@@ -2030,10 +2035,10 @@ fhandler_console::char_command (char c)
  	  break;
  #endif
  	case 'b': /* REP */
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  if (wincap.has_con_esc_rep ())
  	    /* Just send the sequence */
-	    WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	    wpbuf.sendOut( get_output_handle (), &wn);
  	  else if (last_char && last_char != '\n')
  	    for (int i = 0; i < con.args[0]; i++)
  	      WriteConsoleA (get_output_handle (), &last_char, 1, &wn, 0);
@@ -2041,9 +2046,9 @@ fhandler_console::char_command (char c)
  	case 'r': /* DECSTBM */
  	  con.scroll_region.Top = con.args[0] ? con.args[0] - 1 : 0;
  	  con.scroll_region.Bottom = con.args[1] ? con.args[1] - 1 : -1;
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  /* Just send the sequence */
-	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  wpbuf.sendOut( get_output_handle (), &wn);
  	  break;
  	case 'L': /* IL */
  	  if (wincap.has_con_broken_il_dl ())
@@ -2067,8 +2072,8 @@ fhandler_console::char_command (char c)
  			       y + 1 - con.b.srWindow.Top,
  			       srBottom + 1 - con.b.srWindow.Top);
  	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
-	      wpbuf_put ('T');
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      wpbuf.put ('T');
+	      wpbuf.sendOut( get_output_handle (), &wn);
  	      __small_sprintf (buf, "\033[%d;%dr",
  			       srTop + 1 - con.b.srWindow.Top,
  			       srBottom + 1 - con.b.srWindow.Top);
@@ -2079,9 +2084,9 @@ fhandler_console::char_command (char c)
  	    }
  	  else
  	    {
-	      wpbuf_put (c);
+	      wpbuf.put (c);
  	      /* Just send the sequence */
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      wpbuf.sendOut( get_output_handle (), &wn);
  	    }
  	  break;
  	case 'M': /* DL */
@@ -2095,8 +2100,8 @@ fhandler_console::char_command (char c)
  			       y + 1 - con.b.srWindow.Top,
  			       srBottom + 1 - con.b.srWindow.Top);
  	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
-	      wpbuf_put ('S');
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      wpbuf.put ('S');
+	      wpbuf.sendOut( get_output_handle (), &wn);
  	      __small_sprintf (buf, "\033[%d;%dr",
  			       srTop + 1 - con.b.srWindow.Top,
  			       srBottom + 1 - con.b.srWindow.Top);
@@ -2107,13 +2112,13 @@ fhandler_console::char_command (char c)
  	    }
  	  else
  	    {
-	      wpbuf_put (c);
+	      wpbuf.put (c);
  	      /* Just send the sequence */
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      wpbuf.sendOut( get_output_handle (), &wn);
  	    }
  	  break;
  	case 'J': /* ED */
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  if (con.args[0] == 3 && wincap.has_con_broken_csi3j ())
  	    { /* Workaround for broken CSI3J in Win10 1809 */
  	      CONSOLE_SCREEN_BUFFER_INFO sbi;
@@ -2131,7 +2136,7 @@ fhandler_console::char_command (char c)
  	    }
  	  else
  	    /* Just send the sequence */
-	    WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	    wpbuf.sendOut( get_output_handle (), &wn);
  	  break;
  	case 'h': /* DECSET */
  	case 'l': /* DECRST */
@@ -2139,9 +2144,9 @@ fhandler_console::char_command (char c)
  	    con.screen_alternated = true;
  	  else
  	    con.screen_alternated = false;
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  /* Just send the sequence */
-	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  wpbuf.sendOut( get_output_handle (), &wn);
  	  if (con.saw_question_mark)
  	    {
  	      bool need_fix_tab_position = false;
@@ -2159,15 +2164,15 @@ fhandler_console::char_command (char c)
  	      con.scroll_region.Top = 0;
  	      con.scroll_region.Bottom = -1;
  	    }
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  /* Just send the sequence */
-	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  wpbuf.sendOut( get_output_handle (), &wn);
  	  break;
  	default:
  	  /* Other escape sequences */
-	  wpbuf_put (c);
+	  wpbuf.put (c);
  	  /* Just send the sequence */
-	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  wpbuf.sendOut( get_output_handle (), &wn);
  	  break;
  	}
        return;
@@ -2874,7 +2879,7 @@ do_print:
  	  break;
  	case ESC:
  	  con.state = gotesc;
-	  wpbuf_put (*found);
+	  wpbuf.put (*found);
  	  break;
  	case DWN:
  	  cursor_get (&x, &y);
@@ -2989,7 +2994,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	case gotesc:
  	  if (*src == '[')		/* CSI Control Sequence Introducer */
  	    {
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      con.state = gotsquare;
  	      memset (con.args, 0, sizeof con.args);
  	      con.nargs = 0;
@@ -3005,13 +3010,13 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  		  /* For xterm mode only */
  		  DWORD n;
  		  /* Just send the sequence */
-		  wpbuf_put (*src);
-		  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+		  wpbuf.put (*src);
+		  wpbuf.sendOut( get_output_handle (), &n);
  		}
  	      else if (con.savex >= 0 && con.savey >= 0)
  		cursor_set (false, con.savex, con.savey);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (*src == '7')		/* DECSC Save cursor position */
  	    {
@@ -3020,13 +3025,13 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  		  /* For xterm mode only */
  		  DWORD n;
  		  /* Just send the sequence */
-		  wpbuf_put (*src);
-		  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+		  wpbuf.put (*src);
+		  wpbuf.sendOut( get_output_handle (), &n);
  		}
  	      else
  		cursor_get (&con.savex, &con.savey);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (wincap.has_con_24bit_colors () && !con_is_legacy
  		   && wincap.has_con_broken_il_dl () && *src == 'M')
@@ -3048,14 +3053,14 @@ fhandler_console::write (const void *vsrc, 
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
+	      wpbuf.sendOut( get_output_handle (), &n);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (wincap.has_con_24bit_colors () && !con_is_legacy)
  	    {
@@ -3067,28 +3072,28 @@ fhandler_console::write (const void *vsrc, 
size_t len)
  	      /* ESC sequences below (e.g. OSC, etc) are left to xterm
  		 emulation in xterm compatible mode, therefore, are not
  		 handled and just sent them. */
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      /* Just send the sequence */
  	      DWORD n;
-	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+	      wpbuf.sendOut( get_output_handle (), &n);
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
@@ -3096,7 +3101,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	      con.fillin (get_output_handle ());
  	      scroll_buffer_screen (0, 0, -1, -1, 0, 1);
  	      con.state = normal;
-	      wpixput = 0;
+	      wpbuf.empty();
  	    }
  	  else if (*src == 'c')		/* RIS Full Reset */
  	    {
@@ -3107,17 +3112,17 @@ fhandler_console::write (const void *vsrc, 
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
@@ -3126,19 +3131,19 @@ fhandler_console::write (const void *vsrc, 
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
@@ -3151,7 +3156,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	    con.nargs++;
  	  char_command (*src++);
  	  con.state = normal;
-	  wpixput = 0;
+	  wpbuf.empty();
  	  break;
  	case gotrsquare:
  	  if (isdigit (*src))
@@ -3162,7 +3167,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	    con.state = eatpalette;
  	  else
  	    con.state = eattitle;
-	  wpbuf_put (*src);
+	  wpbuf.put (*src);
  	  src++;
  	  break;
  	case eattitle:
@@ -3174,13 +3179,13 @@ fhandler_console::write (const void *vsrc, 
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
@@ -3188,13 +3193,13 @@ fhandler_console::write (const void *vsrc, 
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
@@ -3204,14 +3209,14 @@ fhandler_console::write (const void *vsrc, 
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
@@ -3226,7 +3231,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  		con.saw_greater_than_sign = true;
  	      else if (*src == '!')
  		con.saw_exclamation_mark = true;
-	      wpbuf_put (*src);
+	      wpbuf.put (*src);
  	      /* ignore any extra chars between [ and first arg or command */
  	      src++;
  	    }
@@ -3239,7 +3244,7 @@ fhandler_console::write (const void *vsrc, size_t len)
  	  else
  	    con.vt100_graphics_mode_G0 = false;
  	  con.state = normal;
-	  wpixput = 0;
+	  wpbuf.empty();
  	  src++;
  	  break;
  	case gotrparen:	/* Designate G1 Character Set (ISO 2022) */
@@ -3248,7 +3253,7 @@ fhandler_console::write (const void *vsrc, size_t len)
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

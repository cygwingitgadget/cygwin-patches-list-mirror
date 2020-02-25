Return-Path: <cygwin-patches-return-10119-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74781 invoked by alias); 25 Feb 2020 17:15:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 74575 invoked by uid 89); 25 Feb 2020 17:15:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=007, Operating, codes, NOR
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Feb 2020 17:15:20 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 01PHEi76028298;	Wed, 26 Feb 2020 02:14:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 01PHEi76028298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582650892;	bh=XkELhqYxfCAnyR4pBRF+W/u4aVmAXC6KZE2D65GoCxU=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=OmfjwnafO3z7lhfqUXmkZYN7qQUsNsRzyfUlWn/zztNP92IJ2YtdmG0yuUHZMP7fl	 BEFMXR/m7M9zmJrPKHuExECMvwOl+GzZOFv3xjyymGC3Osdlu0BgGRiZaIeANIYMkc	 U5ajBRiM9TObOz5lJ1XpY2DBEwI8NKSUzhyLWrjb2DH74VVHLo/DNIgXY24ZarZpH6	 ++JTj7DHXlhqZh6uhWz+E8aaoHmldPmklQaa5rRozQjegLmHmScRhPBx19+Ab9+p2+	 Wc5J8iVOhyZS3dJw4MdP67OfD48VOMDcAh/uIBUKiDXvqeFlu4MCBcgqGo8zsg81k+	 i+TDJBDQdc/nw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/2] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Date: Tue, 25 Feb 2020 17:15:00 -0000
Message-Id: <20200225171438.1243-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200225171438.1243-1-takashi.yano@nifty.ne.jp>
References: <20200225171438.1243-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00225.txt

- Cygwin console with xterm compatible mode causes problem reported
  in https://www.cygwin.com/ml/cygwin-patches/2020-q1/msg00212.html
  if background/foreground colors are set to gray/black respectively
  in Win10 1903/1909. This is caused by "CSI Ps L" (IL), "CSI Ps M"
  (DL) and "ESC M" (RI) control sequences which are broken. This
  patch adds a workaround for the issue. Also, workaround code for
  "CSI3J" and "CSI?1049h/l" are unified into the codes handling
  escape sequences above.
---
 winsup/cygwin/fhandler_console.cc | 182 ++++++++++++++++++++++++++----
 winsup/cygwin/wincap.cc           |  10 ++
 winsup/cygwin/wincap.h            |   2 +
 3 files changed, 171 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 328424a7d..b0d6bd9b7 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -57,6 +57,16 @@ bool NO_COPY fhandler_console::invisible_console;
    Only one console can exist in a process, therefore, static is suitable. */
 static struct fhandler_base::rabuf_t con_ra;
 
+/* Write pending buffer for ESC sequence handling
+   in xterm compatible mode */
+#define WPBUF_LEN 256
+static unsigned char wpbuf[WPBUF_LEN];
+static int wpixput;
+#define wpbuf_put(x) \
+  wpbuf[wpixput++] = x; \
+  if (wpixput > WPBUF_LEN) \
+    wpixput --;
+
 static void
 beep ()
 {
@@ -1776,24 +1786,6 @@ static const wchar_t __vt100_conv[31] = {
 inline bool
 fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 {
-  bool need_fix_tab_position = false;
-  /* Check if screen will be alternated. */
-  if (wincap.has_con_24bit_colors () && !con_is_legacy
-      && memmem (buf, len*sizeof (WCHAR), L"\033[?1049", 7*sizeof (WCHAR)))
-    need_fix_tab_position = true;
-  /* Workaround for broken CSI3J (ESC[3J) support in xterm compatible mode. */
-  if (wincap.has_con_24bit_colors () && !con_is_legacy &&
-      wincap.has_con_broken_csi3j ())
-    {
-      WCHAR *p = buf;
-      while ((p = (WCHAR *) memmem (p, (len - (p - buf))*sizeof (WCHAR),
-				    L"\033[3J", 4*sizeof (WCHAR))))
-	{
-	  memmove (p, p+4, (len - (p+4 - buf))*sizeof (WCHAR));
-	  len -= 4;
-	}
-    }
-
   if (con.iso_2022_G1
 	? con.vt100_graphics_mode_G1
 	: con.vt100_graphics_mode_G0)
@@ -1812,9 +1804,6 @@ fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
       len -= done;
       buf += done;
     }
-  /* Call fix_tab_position() if screen has been alternated. */
-  if (need_fix_tab_position)
-    fix_tab_position ();
   return true;
 }
 
@@ -2014,6 +2003,94 @@ fhandler_console::char_command (char c)
   char buf[40];
   int r, g, b;
 
+  if (wincap.has_con_24bit_colors () && !con_is_legacy)
+    {
+      /* For xterm compatible mode */
+      DWORD wn;
+      switch (c)
+	{
+	case 'r': /* DECSTBM */
+	  con.scroll_region.Top = con.args[0] ? con.args[0] - 1 : 0;
+	  con.scroll_region.Bottom = con.args[1] ? con.args[1] - 1 : -1;
+	  wpbuf_put (c);
+	  /* Just send the sequence */
+	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  break;
+	case 'L': /* IL */
+	  if (wincap.has_con_broken_il_dl ())
+	    {
+	      /* Use "CSI Ps T" instead */
+	      cursor_get (&x, &y);
+	      __small_sprintf (buf, "\033[%d;%dr", y + 1, srBottom + 1);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      wpbuf_put ('T');
+	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      __small_sprintf (buf, "\033[%d;%dr", srTop + 1, srBottom + 1);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      __small_sprintf (buf, "\033[%d;%dH", y + 1, x + 1);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	    }
+	  else
+	    {
+	      wpbuf_put (c);
+	      /* Just send the sequence */
+	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	    }
+	  break;
+	case 'M': /* DL */
+	  if (wincap.has_con_broken_il_dl ())
+	    {
+	      /* Use "CSI Ps S" instead */
+	      cursor_get (&x, &y);
+	      __small_sprintf (buf, "\033[%d;%dr", y + 1, srBottom + 1);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      wpbuf_put ('S');
+	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	      __small_sprintf (buf, "\033[%d;%dr", srTop + 1, srBottom + 1);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	      __small_sprintf (buf, "\033[%d;%dH", y + 1, x + 1);
+	      WriteConsoleA (get_output_handle (), buf, strlen (buf), &wn, 0);
+	    }
+	  else
+	    {
+	      wpbuf_put (c);
+	      /* Just send the sequence */
+	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	    }
+	  break;
+	case 'J': /* ED */
+	  wpbuf_put (c);
+	  /* Ignore CSI3J in Win10 1809 because it is broken. */
+	  if (con.args[0] != 3 || !wincap.has_con_broken_csi3j ())
+	    WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  break;
+	case 'h': /* DECSET */
+	case 'l': /* DECRST */
+	  wpbuf_put (c);
+	  /* Just send the sequence */
+	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  if (con.saw_question_mark)
+	    {
+	      bool need_fix_tab_position = false;
+	      for (int i = 0; i < con.nargs; i++)
+		if (con.args[i] == 1049)
+		  need_fix_tab_position = true;
+	      /* Call fix_tab_position() if screen has been alternated. */
+	      if (need_fix_tab_position)
+		fix_tab_position ();
+	    }
+	  break;
+	default:
+	  /* Other escape sequences */
+	  wpbuf_put (c);
+	  /* Just send the sequence */
+	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  break;
+	}
+      return;
+    }
+
+  /* For legacy cygwin treminal */
   switch (c)
     {
     case 'm':   /* Set Graphics Rendition */
@@ -2641,6 +2718,7 @@ fhandler_console::write_normal (const unsigned char *src,
   while (found < end
 	 && found - src < CONVERT_LIMIT
 	 && base_chars[*found] != IGN
+	 && base_chars[*found] != ESC
 	 && ((wincap.has_con_24bit_colors () && !con_is_legacy)
 	     || base_chars[*found] == NOR))
     {
@@ -2712,6 +2790,7 @@ do_print:
 	  break;
 	case ESC:
 	  con.state = gotesc;
+	  wpbuf_put (*found);
 	  break;
 	case DWN:
 	  cursor_get (&x, &y);
@@ -2826,6 +2905,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	case gotesc:
 	  if (*src == '[')		/* CSI Control Sequence Introducer */
 	    {
+	      wpbuf_put (*src);
 	      con.state = gotsquare;
 	      memset (con.args, 0, sizeof con.args);
 	      con.nargs = 0;
@@ -2833,18 +2913,48 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      con.saw_greater_than_sign = false;
 	      con.saw_space = false;
 	    }
+	  else if (wincap.has_con_24bit_colors () && !con_is_legacy
+		   && wincap.has_con_broken_il_dl () && *src == 'M')
+	    { /* Reverse Index (scroll down) */
+	      int x, y;
+	      cursor_get (&x, &y);
+	      if (y == 0)
+		{
+		  /* Substitute "CSI Ps T" */
+		  wpbuf_put ('[');
+		  wpbuf_put ('T');
+		}
+	      else
+		wpbuf_put (*src);
+	      DWORD n;
+	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+	      con.state = normal;
+	      wpixput = 0;
+	    }
+	  else if (wincap.has_con_24bit_colors () && !con_is_legacy)
+	    { /* Only CSI is handled in xterm compatible mode. */
+	      wpbuf_put (*src);
+	      /* Just send the sequence */
+	      DWORD n;
+	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
+	      con.state = normal;
+	      wpixput = 0;
+	    }
 	  else if (*src == ']')		/* OSC Operating System Command */
 	    {
+	      wpbuf_put (*src);
 	      con.rarg = 0;
 	      con.my_title_buf[0] = '\0';
 	      con.state = gotrsquare;
 	    }
 	  else if (*src == '(')		/* Designate G0 character set */
 	    {
+	      wpbuf_put (*src);
 	      con.state = gotparen;
 	    }
 	  else if (*src == ')')		/* Designate G1 character set */
 	    {
+	      wpbuf_put (*src);
 	      con.state = gotrparen;
 	    }
 	  else if (*src == 'M')		/* Reverse Index (scroll down) */
@@ -2852,6 +2962,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      con.fillin (get_output_handle ());
 	      scroll_buffer_screen (0, 0, -1, -1, 0, 1);
 	      con.state = normal;
+	      wpixput = 0;
 	    }
 	  else if (*src == 'c')		/* RIS Full Reset */
 	    {
@@ -2862,22 +2973,29 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      cursor_set (false, 0, 0);
 	      clear_screen (cl_buf_beg, cl_buf_beg, cl_buf_end, cl_buf_end);
 	      con.state = normal;
+	      wpixput = 0;
 	    }
 	  else if (*src == '8')		/* DECRC Restore cursor position */
 	    {
 	      cursor_set (false, con.savex, con.savey);
 	      con.state = normal;
+	      wpixput = 0;
 	    }
 	  else if (*src == '7')		/* DECSC Save cursor position */
 	    {
 	      cursor_get (&con.savex, &con.savey);
 	      con.state = normal;
+	      wpixput = 0;
 	    }
 	  else if (*src == 'R')		/* ? */
+	    {
 	      con.state = normal;
+	      wpixput = 0;
+	    }
 	  else
 	    {
 	      con.state = normal;
+	      wpixput = 0;
 	    }
 	  src++;
 	  break;
@@ -2885,10 +3003,12 @@ fhandler_console::write (const void *vsrc, size_t len)
 	  if (isdigit (*src))
 	    {
 	      con.args[con.nargs] = con.args[con.nargs] * 10 + *src - '0';
+	      wpbuf_put (*src);
 	      src++;
 	    }
 	  else if (*src == ';')
 	    {
+	      wpbuf_put (*src);
 	      src++;
 	      con.nargs++;
 	      if (con.nargs > MAXARGS)
@@ -2896,6 +3016,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    }
 	  else if (*src == ' ')
 	    {
+	      wpbuf_put (*src);
 	      src++;
 	      con.saw_space = true;
 	      con.state = gotcommand;
@@ -2909,6 +3030,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    con.nargs--;
 	  char_command (*src++);
 	  con.state = normal;
+	  wpixput = 0;
 	  break;
 	case gotrsquare:
 	  if (isdigit (*src))
@@ -2919,6 +3041,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    con.state = eatpalette;
 	  else
 	    con.state = eattitle;
+	  wpbuf_put (*src);
 	  src++;
 	  break;
 	case eattitle:
@@ -2930,20 +3053,28 @@ fhandler_console::write (const void *vsrc, size_t len)
 		if (*src == '\007' && con.state == gettitle)
 		  set_console_title (con.my_title_buf);
 		con.state = normal;
+		wpixput = 0;
 	      }
 	    else if (n < TITLESIZE)
 	      {
 		con.my_title_buf[n++] = *src;
 		con.my_title_buf[n] = '\0';
+		wpbuf_put (*src);
 	      }
 	    src++;
 	    break;
 	  }
 	case eatpalette:
 	  if (*src == '\033')
-	    con.state = endpalette;
+	    {
+	      wpbuf_put (*src);
+	      con.state = endpalette;
+	    }
 	  else if (*src == '\a')
-	    con.state = normal;
+	    {
+	      con.state = normal;
+	      wpixput = 0;
+	    }
 	  src++;
 	  break;
 	case endpalette:
@@ -2952,12 +3083,14 @@ fhandler_console::write (const void *vsrc, size_t len)
 	  else
 	    /* Sequence error (abort) */
 	    con.state = normal;
+	  wpixput = 0;
 	  src++;
 	  break;
 	case gotsquare:
 	  if (*src == ';')
 	    {
 	      con.state = gotarg1;
+	      wpbuf_put (*src);
 	      con.nargs++;
 	      if (con.nargs > MAXARGS)
 		con.nargs--;
@@ -2971,6 +3104,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		con.saw_question_mark = true;
 	      else if (*src == '>')
 		con.saw_greater_than_sign = true;
+	      wpbuf_put (*src);
 	      /* ignore any extra chars between [ and first arg or command */
 	      src++;
 	    }
@@ -2983,6 +3117,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	  else
 	    con.vt100_graphics_mode_G0 = false;
 	  con.state = normal;
+	  wpixput = 0;
 	  src++;
 	  break;
 	case gotrparen:	/* Designate G1 Character Set (ISO 2022) */
@@ -2991,6 +3126,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	  else
 	    con.vt100_graphics_mode_G1 = false;
 	  con.state = normal;
+	  wpixput = 0;
 	  src++;
 	  break;
 	}
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index a52262b89..714a6d49f 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -43,6 +43,7 @@ wincaps wincap_vista __attribute__((section (".cygwin_dll_common"), shared)) = {
     no_msv1_0_s4u_logon_in_wow64:true,
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -71,6 +72,7 @@ wincaps wincap_7 __attribute__((section (".cygwin_dll_common"), shared)) = {
     no_msv1_0_s4u_logon_in_wow64:true,
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -99,6 +101,7 @@ wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -127,6 +130,7 @@ wincaps wincap_8_1 __attribute__((section (".cygwin_dll_common"), shared)) = {
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -155,6 +159,7 @@ wincaps  wincap_10_1507 __attribute__((section (".cygwin_dll_common"), shared))
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -183,6 +188,7 @@ wincaps wincap_10_1703 __attribute__((section (".cygwin_dll_common"), shared)) =
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -211,6 +217,7 @@ wincaps wincap_10_1709 __attribute__((section (".cygwin_dll_common"), shared)) =
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -239,6 +246,7 @@ wincaps wincap_10_1803 __attribute__((section (".cygwin_dll_common"), shared)) =
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -267,6 +275,7 @@ wincaps wincap_10_1809 __attribute__((section (".cygwin_dll_common"), shared)) =
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
     has_con_broken_csi3j:true,
+    has_con_broken_il_dl:false,
   },
 };
 
@@ -295,6 +304,7 @@ wincaps wincap_10_1903 __attribute__((section (".cygwin_dll_common"), shared)) =
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
     has_con_broken_csi3j:false,
+    has_con_broken_il_dl:true,
   },
 };
 
diff --git a/winsup/cygwin/wincap.h b/winsup/cygwin/wincap.h
index 11902d976..f85a88877 100644
--- a/winsup/cygwin/wincap.h
+++ b/winsup/cygwin/wincap.h
@@ -37,6 +37,7 @@ struct wincaps
     unsigned no_msv1_0_s4u_logon_in_wow64	: 1;
     unsigned has_con_24bit_colors		: 1;
     unsigned has_con_broken_csi3j		: 1;
+    unsigned has_con_broken_il_dl		: 1;
   };
 };
 
@@ -97,6 +98,7 @@ public:
   bool	IMPLEMENT (no_msv1_0_s4u_logon_in_wow64)
   bool	IMPLEMENT (has_con_24bit_colors)
   bool	IMPLEMENT (has_con_broken_csi3j)
+  bool	IMPLEMENT (has_con_broken_il_dl)
 
   void disable_case_sensitive_dirs ()
   {
-- 
2.21.0

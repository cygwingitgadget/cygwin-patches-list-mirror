Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 875713857C47
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 03:35:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 875713857C47
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 07R3ZInf000635;
 Thu, 27 Aug 2020 12:35:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 07R3ZInf000635
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Replace WriteConsoleA() with WriteConsoleW().
Date: Thu, 27 Aug 2020 12:35:03 +0900
Message-Id: <20200827033504.1949-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_SOMETLD_ARE_BAD_TLD,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Thu, 27 Aug 2020 03:35:59 -0000

- To allow sending non-ASCII chars to console, all WriteConsoleA()
  are replaced by WriteConsoleW().
  Addresses:
  https://cygwin.com/pipermail/cygwin-patches/2020q3/010476.html
---
 winsup/cygwin/fhandler_console.cc | 89 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 02a5996a1..33e40a9f9 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -59,7 +59,7 @@ static struct fhandler_base::rabuf_t con_ra;
 
 /* Write pending buffer for ESC sequence handling
    in xterm compatible mode */
-static unsigned char last_char;
+static wchar_t last_char;
 
 /* simple helper class to accumulate output in a buffer
    and send that to the console on request: */
@@ -67,18 +67,20 @@ static class write_pending_buffer
 {
 private:
   static const size_t WPBUF_LEN = 256u;
-  unsigned char buf[WPBUF_LEN];
+  char buf[WPBUF_LEN];
   size_t ixput;
 public:
-  inline void put (unsigned char x)
+  inline void put (char x)
   {
     if (ixput < WPBUF_LEN)
       buf[ixput++] = x;
   }
   inline void empty () { ixput = 0u; }
-  inline void send (HANDLE &handle, DWORD *wn = NULL)
+  inline void send (HANDLE &handle)
   {
-    WriteConsoleA (handle, buf, ixput, wn, 0);
+    wchar_t bufw[WPBUF_LEN];
+    DWORD len = sys_mbstowcs (bufw, WPBUF_LEN, buf, ixput);
+    WriteConsoleW (handle, bufw, len, NULL, 0);
   }
 } wpbuf;
 
@@ -291,7 +293,7 @@ fhandler_console::request_xterm_mode_input (bool req)
 	  dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
 	  SetConsoleMode (get_handle (), dwMode);
 	  if (con.cursor_key_app_mode) /* Restore DECCKM */
-	    WriteConsoleA (get_output_handle (), "\033[?1h", 5, NULL, 0);
+	    WriteConsoleW (get_output_handle (), L"\033[?1h", 5, NULL, 0);
 	}
     }
   else
@@ -1793,6 +1795,9 @@ fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
       if (buf[i] >= (unsigned char) '`' && buf[i] <= (unsigned char) '~')
 	buf[i] = __vt100_conv[buf[i] - (unsigned char) '`'];
 
+  if (len > 0)
+    last_char = buf[len-1];
+
   while (len > 0)
     {
       DWORD nbytes = len > MAX_WRITE_CHARS ? MAX_WRITE_CHARS : len;
@@ -2001,6 +2006,7 @@ fhandler_console::char_command (char c)
 {
   int x, y, n;
   char buf[40];
+  wchar_t bufw[40];
   int r, g, b;
 
   if (wincap.has_con_24bit_colors () && !con_is_legacy)
@@ -2035,9 +2041,9 @@ fhandler_console::char_command (char c)
 	  if (wincap.has_con_esc_rep ())
 	    /* Just send the sequence */
 	    wpbuf.send (get_output_handle ());
-	  else if (last_char && last_char != '\n')
+	  else if (last_char && last_char != L'\n')
 	    for (int i = 0; i < con.args[0]; i++)
-	      WriteConsoleA (get_output_handle (), &last_char, 1, 0, 0);
+	      WriteConsoleW (get_output_handle (), &last_char, 1, 0, 0);
 	  break;
 	case 'r': /* DECSTBM */
 	  con.scroll_region.Top = con.args[0] ? con.args[0] - 1 : 0;
@@ -2058,25 +2064,25 @@ fhandler_console::char_command (char c)
 		{
 		  /* Erase scroll down area */
 		  n = con.args[0] ? : 1;
-		  __small_sprintf (buf, "\033[%d;1H\033[J\033[%d;%dH",
-				   srBottom - (n-1) - con.b.srWindow.Top + 1,
-				   y + 1 - con.b.srWindow.Top, x + 1);
-		  WriteConsoleA (get_output_handle (),
-				 buf, strlen (buf), 0, 0);
+		  __small_swprintf (bufw, L"\033[%d;1H\033[J\033[%d;%dH",
+				    srBottom - (n-1) - con.b.srWindow.Top + 1,
+				    y + 1 - con.b.srWindow.Top, x + 1);
+		  WriteConsoleW (get_output_handle (),
+				 bufw, wcslen (bufw), 0, 0);
 		}
-	      __small_sprintf (buf, "\033[%d;%dr",
-			       y + 1 - con.b.srWindow.Top,
-			       srBottom + 1 - con.b.srWindow.Top);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
+	      __small_swprintf (bufw, L"\033[%d;%dr",
+				y + 1 - con.b.srWindow.Top,
+				srBottom + 1 - con.b.srWindow.Top);
+	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
 	      wpbuf.put ('T');
 	      wpbuf.send (get_output_handle ());
-	      __small_sprintf (buf, "\033[%d;%dr",
-			       srTop + 1 - con.b.srWindow.Top,
-			       srBottom + 1 - con.b.srWindow.Top);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
-	      __small_sprintf (buf, "\033[%d;%dH",
-			       y + 1 - con.b.srWindow.Top, x + 1);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
+	      __small_swprintf (bufw, L"\033[%d;%dr",
+				srTop + 1 - con.b.srWindow.Top,
+				srBottom + 1 - con.b.srWindow.Top);
+	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
+	      __small_swprintf (bufw, L"\033[%d;%dH",
+				y + 1 - con.b.srWindow.Top, x + 1);
+	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
 	    }
 	  else
 	    {
@@ -2092,19 +2098,19 @@ fhandler_console::char_command (char c)
 	      cursor_get (&x, &y);
 	      if (y < srTop || y > srBottom)
 		break;
-	      __small_sprintf (buf, "\033[%d;%dr",
-			       y + 1 - con.b.srWindow.Top,
-			       srBottom + 1 - con.b.srWindow.Top);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
+	      __small_swprintf (bufw, L"\033[%d;%dr",
+				y + 1 - con.b.srWindow.Top,
+				srBottom + 1 - con.b.srWindow.Top);
+	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
 	      wpbuf.put ('S');
 	      wpbuf.send (get_output_handle ());
-	      __small_sprintf (buf, "\033[%d;%dr",
-			       srTop + 1 - con.b.srWindow.Top,
-			       srBottom + 1 - con.b.srWindow.Top);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
-	      __small_sprintf (buf, "\033[%d;%dH",
-			       y + 1 - con.b.srWindow.Top, x + 1);
-	      WriteConsoleA (get_output_handle (), buf, strlen (buf), 0, 0);
+	      __small_swprintf (bufw, L"\033[%d;%dr",
+				srTop + 1 - con.b.srWindow.Top,
+				srBottom + 1 - con.b.srWindow.Top);
+	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
+	      __small_swprintf (bufw, L"\033[%d;%dH",
+				y + 1 - con.b.srWindow.Top, x + 1);
+	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
 	    }
 	  else
 	    {
@@ -2838,7 +2844,6 @@ fhandler_console::write_normal (const unsigned char *src,
 	  break;
 	default:
 	  found += ret;
-	  last_char = *(found - 1);
 	  break;
 	}
     }
@@ -3056,12 +3061,12 @@ fhandler_console::write (const void *vsrc, size_t len)
 		      && srBottom == con.b.srWindow.Bottom)
 		    {
 		      /* Erase scroll down area */
-		      char buf[] = "\033[32768;1H\033[J\033[32768;32768";
-		      __small_sprintf (buf, "\033[%d;1H\033[J\033[%d;%dH",
-				       srBottom - con.b.srWindow.Top + 1,
-				       y + 1 - con.b.srWindow.Top, x + 1);
-		      WriteConsoleA (get_output_handle (),
-				     buf, strlen (buf), 0, 0);
+		      wchar_t buf[] = L"\033[32768;1H\033[J\033[32768;32768";
+		      __small_swprintf (buf, L"\033[%d;1H\033[J\033[%d;%dH",
+					srBottom - con.b.srWindow.Top + 1,
+					y + 1 - con.b.srWindow.Top, x + 1);
+		      WriteConsoleW (get_output_handle (),
+				     buf, wcslen (buf), 0, 0);
 		    }
 		  /* Substitute "CSI Ps T" */
 		  wpbuf.put ('[');
-- 
2.28.0


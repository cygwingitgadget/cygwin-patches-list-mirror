Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 0043F385BF81
 for <cygwin-patches@cygwin.com>; Sat, 30 May 2020 09:25:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0043F385BF81
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 04U9P85G028886;
 Sat, 30 May 2020 18:25:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 04U9P85G028886
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Make cursor keys work in vim under ConEmu.
Date: Sat, 30 May 2020 18:25:03 +0900
Message-Id: <20200530092503.1142-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_SOMETLD_ARE_BAD_TLD,
 PDS_OTHER_BAD_TLD, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 30 May 2020 09:25:35 -0000

- After commit 774b8996d1f3e535e8267be4eb8e751d756c2cec, cursor
  keys do not work in vim under ConEmu without cygwin-connector.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 76ad2aab0..b2957e4ee 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2040,6 +2040,7 @@ class dev_console
   char *cons_rapoi;
   LONG xterm_mode_input;
   LONG xterm_mode_output;
+  bool cursor_key_app_mode;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 3930c6068..5cb4343ea 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -243,6 +243,7 @@ fhandler_console::setup ()
       con.backspace_keycode = CERASE;
       con.cons_rapoi = NULL;
       shared_console_info->tty_min_state.is_console = true;
+      con.cursor_key_app_mode = false;
     }
 }
 
@@ -289,6 +290,8 @@ fhandler_console::request_xterm_mode_input (bool req)
 	  GetConsoleMode (get_handle (), &dwMode);
 	  dwMode |= ENABLE_VIRTUAL_TERMINAL_INPUT;
 	  SetConsoleMode (get_handle (), dwMode);
+	  if (con.cursor_key_app_mode) /* Restore DECCKM */
+	    WriteConsoleA (get_output_handle (), "\033[?1h", 5, NULL, 0);
 	}
     }
   else
@@ -2150,10 +2153,6 @@ fhandler_console::char_command (char c)
 	  break;
 	case 'h': /* DECSET */
 	case 'l': /* DECRST */
-	  if (c == 'h')
-	    con.screen_alternated = true;
-	  else
-	    con.screen_alternated = false;
 	  wpbuf.put (c);
 	  /* Just send the sequence */
 	  wpbuf.send (get_output_handle ());
@@ -2161,8 +2160,15 @@ fhandler_console::char_command (char c)
 	    {
 	      bool need_fix_tab_position = false;
 	      for (int i = 0; i < con.nargs; i++)
-		if (con.args[i] == 1049)
-		  need_fix_tab_position = true;
+		{
+		  if (con.args[i] == 1049)
+		    {
+		      con.screen_alternated = (c == 'h');
+		      need_fix_tab_position = true;
+		    }
+		  if (con.args[i] == 1) /* DECCKM */
+		    con.cursor_key_app_mode = (c == 'h');
+		}
 	      /* Call fix_tab_position() if screen has been alternated. */
 	      if (need_fix_tab_position)
 		fix_tab_position ();
@@ -2174,6 +2180,7 @@ fhandler_console::char_command (char c)
 	      con.scroll_region.Top = 0;
 	      con.scroll_region.Bottom = -1;
 	      con.savex = con.savey = -1;
+	      con.cursor_key_app_mode = false;
 	    }
 	  wpbuf.put (c);
 	  /* Just send the sequence */
@@ -3077,6 +3084,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		  con.scroll_region.Top = 0;
 		  con.scroll_region.Bottom = -1;
 		  con.savex = con.savey = -1;
+		  con.cursor_key_app_mode = false;
 		}
 	      /* ESC sequences below (e.g. OSC, etc) are left to xterm
 		 emulation in xterm compatible mode, therefore, are not
-- 
2.26.2


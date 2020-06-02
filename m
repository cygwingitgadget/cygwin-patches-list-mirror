Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 81AAB3851C26
 for <cygwin-patches@cygwin.com>; Tue,  2 Jun 2020 12:45:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 81AAB3851C26
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 052CikNV010039;
 Tue, 2 Jun 2020 21:44:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 052CikNV010039
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix screen distortion after less for native apps
 again.
Date: Tue,  2 Jun 2020 21:44:40 +0900
Message-Id: <20200602124440.1925-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 02 Jun 2020 12:45:32 -0000

- Commit c4b060e3fe3bed05b3a69ccbcc20993ad85e163d seems to be not
  enough. Fixed again.
---
 winsup/cygwin/fhandler_tty.cc | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index bcc7648f3..742fa7e33 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1394,10 +1394,6 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
 	    nlen = p0 - buf;
 	}
     }
-  if (!nlen) /* Nothing to be synchronized */
-    goto cleanup;
-  if (get_ttyp ()->switch_to_pcon_out && !is_echo)
-    goto cleanup;
   /* Remove ESC sequence which returns results to console
      input buffer. Without this, cursor position report
      is put into the input buffer as a garbage. */
@@ -1413,6 +1409,10 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
       memmove (p0, p0+4, nlen - (p0+4 - buf));
       nlen -= 4;
     }
+  if (!nlen) /* Nothing to be synchronized */
+    goto cleanup;
+  if (get_ttyp ()->switch_to_pcon_out && !is_echo)
+    goto cleanup;
 
   /* If the ESC sequence ESC[?3h or ESC[?3l which clears console screen
      buffer is pushed, set need_redraw_screen to trigger redraw screen. */
@@ -1504,6 +1504,15 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   reset_switch_to_pcon ();
 
+  bool screen_alternated_orig = get_ttyp ()->screen_alternated;
+  /* Push slave output to pseudo console screen buffer */
+  if (get_pseudo_console () && !screen_alternated_orig)
+    {
+      acquire_output_mutex (INFINITE);
+      push_to_pcon_screenbuffer ((char *)ptr, len, false);
+      release_output_mutex ();
+    }
+
   bool output_to_pcon =
     get_ttyp ()->switch_to_pcon_out && !get_ttyp ()->screen_alternated;
 
@@ -1564,7 +1573,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   restore_reattach_pcon ();
 
   /* Push slave output to pseudo console screen buffer */
-  if (get_pseudo_console ())
+  if (get_pseudo_console () && screen_alternated_orig)
     {
       acquire_output_mutex (INFINITE);
       push_to_pcon_screenbuffer ((char *)ptr, len, false);
-- 
2.26.2


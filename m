Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id A8CDA386F432
 for <cygwin-patches@cygwin.com>; Mon,  1 Jun 2020 06:16:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A8CDA386F432
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 0516GCfG009321;
 Mon, 1 Jun 2020 15:16:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 0516GCfG009321
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix screen distortion after using less for
 native apps.
Date: Mon,  1 Jun 2020 15:16:18 +0900
Message-Id: <20200601061618.893-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Mon, 01 Jun 2020 06:16:54 -0000

- If the output of non-cygwin apps is browsed using less, screen is
  ocasionally distorted after less exits. This frequently happens
  if cmd.exe is executed after less. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e434b7878..bcc7648f3 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1372,7 +1372,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
 	  p0 = (char *) memmem (p1, nlen - (p1-buf), "\033[?1049h", 8);
 	  if (p0)
 	    {
-	      //p0 += 8;
+	      p0 += 8;
 	      get_ttyp ()->screen_alternated = true;
 	      if (get_ttyp ()->switch_to_pcon_out)
 		do_not_reset_switch_to_pcon = true;
@@ -1384,7 +1384,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
 	  p1 = (char *) memmem (p0, nlen - (p0-buf), "\033[?1049l", 8);
 	  if (p1)
 	    {
-	      p1 += 8;
+	      //p1 += 8;
 	      get_ttyp ()->screen_alternated = false;
 	      do_not_reset_switch_to_pcon = false;
 	      memmove (p0, p1, buf+nlen - p1);
@@ -1504,7 +1504,10 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   reset_switch_to_pcon ();
 
-  UINT target_code_page = get_ttyp ()->switch_to_pcon_out ?
+  bool output_to_pcon =
+    get_ttyp ()->switch_to_pcon_out && !get_ttyp ()->screen_alternated;
+
+  UINT target_code_page = output_to_pcon ?
     GetConsoleOutputCP () : get_ttyp ()->term_code_page;
   ssize_t nlen;
   char *buf = convert_mb_str (target_code_page, (size_t *) &nlen,
@@ -1513,11 +1516,11 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   /* If not attached to this pseudo console, try to attach temporarily. */
   pid_restore = 0;
   bool fallback = false;
-  if (get_ttyp ()->switch_to_pcon_out && pcon_attached_to != get_minor ())
+  if (output_to_pcon && pcon_attached_to != get_minor ())
     if (!try_reattach_pcon ())
       fallback = true;
 
-  if (get_ttyp ()->switch_to_pcon_out && !fallback &&
+  if (output_to_pcon && !fallback &&
       (memmem (buf, nlen, "\033[6n", 4) || memmem (buf, nlen, "\033[0c", 4)))
     {
       get_ttyp ()->pcon_in_empty = false;
@@ -1530,12 +1533,12 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   if (!(get_ttyp ()->ti.c_oflag & OPOST) ||
       !(get_ttyp ()->ti.c_oflag & ONLCR))
     flags |= DISABLE_NEWLINE_AUTO_RETURN;
-  if (get_ttyp ()->switch_to_pcon_out && !fallback)
+  if (output_to_pcon && !fallback)
     {
       GetConsoleMode (get_output_handle (), &dwMode);
       SetConsoleMode (get_output_handle (), dwMode | flags);
     }
-  HANDLE to = (get_ttyp ()->switch_to_pcon_out && !fallback) ?
+  HANDLE to = (output_to_pcon && !fallback) ?
     get_output_handle () : get_output_handle_cyg ();
   acquire_output_mutex (INFINITE);
   if (!process_opost_output (to, buf, nlen, false))
@@ -1555,7 +1558,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   release_output_mutex ();
   mb_str_free (buf);
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-  if (get_ttyp ()->switch_to_pcon_out && !fallback)
+  if (output_to_pcon && !fallback)
     SetConsoleMode (get_output_handle (), dwMode | flags);
 
   restore_reattach_pcon ();
-- 
2.26.2


Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 6C6663857C75
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 11:15:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6C6663857C75
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 10SBERd0025778;
 Thu, 28 Jan 2021 20:14:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 10SBERd0025778
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: console: Make read() thread-safe.
Date: Thu, 28 Jan 2021 20:14:08 +0900
Message-Id: <20210128111409.581-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128111409.581-1-takashi.yano@nifty.ne.jp>
References: <20210128111409.581-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 28 Jan 2021 11:15:13 -0000

- Currently read() is somehow not thread-safe. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_console.cc | 7 +++----
 winsup/cygwin/select.cc           | 3 ---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 02d0ac052..8324faaa2 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -572,9 +572,7 @@ wait_retry:
 
       int ret;
       acquire_attach_mutex (INFINITE);
-      acquire_input_mutex (INFINITE);
       ret = process_input_message ();
-      release_input_mutex ();
       release_attach_mutex ();
       switch (ret)
 	{
@@ -632,6 +630,7 @@ fhandler_console::process_input_message (void)
   if (!shared_console_info)
     return input_error;
 
+  acquire_input_mutex (INFINITE);
   termios *ti = &(get_ttyp ()->ti);
 
   fhandler_console::input_states stat = input_processing;
@@ -641,6 +640,7 @@ fhandler_console::process_input_message (void)
   if (!PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read))
     {
       termios_printf ("PeekConsoleInput failed, %E");
+      release_input_mutex ();
       return input_error;
     }
 
@@ -984,9 +984,7 @@ fhandler_console::process_input_message (void)
       if (toadd)
 	{
 	  ssize_t ret;
-	  release_input_mutex ();
 	  line_edit_status res = line_edit (toadd, nread, *ti, &ret);
-	  acquire_input_mutex (INFINITE);
 	  if (res == line_edit_signalled)
 	    {
 	      stat = input_signalled;
@@ -1007,6 +1005,7 @@ out:
   DWORD discard_len = min (total_read, i + 1);
   if (discard_len)
     ReadConsoleInputW (get_handle (), input_rec, discard_len, &dummy);
+  release_input_mutex ();
   return stat;
 }
 
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index dc75a2dbf..a4f401403 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1083,17 +1083,14 @@ peek_console (select_record *me, bool)
 	}
       else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
 	break;
-      fh->acquire_input_mutex (INFINITE);
       if (fhandler_console::input_winch == fh->process_input_message ()
 	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
 	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
 	{
 	  set_sig_errno (EINTR);
-	  fh->release_input_mutex ();
 	  release_attach_mutex ();
 	  return -1;
 	}
-      fh->release_input_mutex ();
     }
   release_attach_mutex ();
   if (fh->input_ready || fh->get_cons_readahead_valid ())
-- 
2.30.0


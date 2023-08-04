Return-Path: <SRS0=Ickq=DV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1001.nifty.com (mta-snd01011.nifty.com [106.153.227.43])
	by sourceware.org (Postfix) with ESMTPS id 7090F3858C2D
	for <cygwin-patches@cygwin.com>; Fri,  4 Aug 2023 08:55:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7090F3858C2D
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1001.nifty.com with ESMTP
          id <20230804085504209.NRBU.19115.localhost.localdomain@nifty.com>;
          Fri, 4 Aug 2023 17:55:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Thomas Wolff <towo@towo.net>
Subject: [PATCH] Cygwin: pty: Fix thread safety of readahead buffer handling in pty master.
Date: Fri,  4 Aug 2023 17:54:49 +0900
Message-Id: <20230804085449.863-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, though readahead buffer handling in pty master was not
fully thread-safe, accept_input() was called from peek_pipe() thread
in select.cc. This caused the problem reported in:
https://cygwin.com/pipermail/cygwin/2023-July/253984.html

The mechanism of the problem is:
1) accept_input() which is called from peek_pipe() thread calls
   eat_readahead(-1) before reading readahead buffer. This allows
   writing to the readahead buffer from another (main) thread.
2) The main thread calls fhandler_pty_master::write() just after
   eat_readahead(-1) was called and before reading the readahead
   buffer by accept_input() called from peek_pipe() thread. This
   overwrites the readahead buffer.
3) The read result from readahead buffer which was overwritten is
   sent to the slave.

This patch makes readahead buffer handling fully thread-safe using
input_mutex to resolve this issue.

Fixes: 7b03b0d8cee0 ("select.cc (peek_pipe): Call flush_to_slave whenever we're checking for a pty master.")
Reported-by: Thomas Wolff <towo@towo.net>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc           | 10 +++++-----
 winsup/cygwin/local_includes/fhandler.h |  8 ++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 8b8c42bc1..db3b77ecf 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -436,8 +436,10 @@ static int osi;
 void
 fhandler_pty_master::flush_to_slave ()
 {
+  WaitForSingleObject (input_mutex, mutex_timeout);
   if (get_readahead_valid () && !(get_ttyp ()->ti.c_lflag & ICANON))
     accept_input ();
+  ReleaseMutex (input_mutex);
 }
 
 void
@@ -523,8 +525,6 @@ fhandler_pty_master::accept_input ()
   DWORD bytes_left;
   int ret = 1;
 
-  WaitForSingleObject (input_mutex, mutex_timeout);
-
   char *p = rabuf () + raixget ();
   bytes_left = eat_readahead (-1);
 
@@ -625,7 +625,6 @@ fhandler_pty_master::accept_input ()
   if (write_to == get_output_handle ())
     SetEvent (input_available_event); /* Set input_available_event only when
 					 the data is written to cyg pipe. */
-  ReleaseMutex (input_mutex);
   return ret;
 }
 
@@ -2235,9 +2234,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    {
 	      /* This accept_input() call is needed in order to transfer input
 		 which is not accepted yet to non-cygwin pipe. */
+	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      if (get_readahead_valid ())
 		accept_input ();
-	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      acquire_attach_mutex (mutex_timeout);
 	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
 						  get_ttyp (),
@@ -2305,9 +2304,10 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 					  get_ttyp (), input_available_event);
       release_attach_mutex ();
     }
-  ReleaseMutex (input_mutex);
 
   line_edit_status status = line_edit (p, len, ti, &ret);
+  ReleaseMutex (input_mutex);
+
   if (status > line_edit_signalled && status != line_edit_pipe_full)
     ret = -1;
   return ret;
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 661fe23dc..03b51a7e4 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2572,6 +2572,14 @@ public:
   int tcgetpgrp ();
   void flush_to_slave ();
   void discard_input ();
+  void acquire_input_mutex_if_necessary (DWORD ms)
+  {
+    WaitForSingleObject (input_mutex, ms);
+  }
+  void release_input_mutex_if_necessary (void)
+  {
+    ReleaseMutex (input_mutex);
+  }
 
   fhandler_pty_master (void *) {}
 
-- 
2.39.0


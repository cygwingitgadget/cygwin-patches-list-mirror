Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 86B28385800F
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 14:12:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 86B28385800F
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 10SEBeIZ020745;
 Thu, 28 Jan 2021 23:12:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 10SEBeIZ020745
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 1/2] Cygwin: console: Make read() thread-safe.
Date: Thu, 28 Jan 2021 23:11:32 +0900
Message-Id: <20210128141133.734-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128141133.734-1-takashi.yano@nifty.ne.jp>
References: <20210128141133.734-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 28 Jan 2021 14:12:35 -0000

- Currently read() is somehow not thread-safe. This patch fixes
  the issue.
---
 winsup/cygwin/fhandler.h          | 10 ++++++++++
 winsup/cygwin/fhandler_console.cc | 11 ++++++-----
 winsup/cygwin/fhandler_termios.cc |  2 ++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index a4c1a3816..2fad7d33c 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1905,6 +1905,8 @@ class fhandler_termios: public fhandler_base
   tty_min *_tc;
   tty *get_ttyp () {return (tty *) tc ();}
   int eat_readahead (int n);
+  virtual void acquire_input_mutex_if_necessary (DWORD ms) {};
+  virtual void release_input_mutex_if_necessary (void) {};
 
  public:
   tty_min*& tc () {return _tc;}
@@ -2212,6 +2214,14 @@ private:
   void __release_input_mutex (const char *fn, int ln);
   DWORD __acquire_output_mutex (const char *fn, int ln, DWORD ms);
   void __release_output_mutex (const char *fn, int ln);
+  void acquire_input_mutex_if_necessary (DWORD ms)
+  {
+    acquire_input_mutex (ms);
+  }
+  void release_input_mutex_if_necessary (void)
+  {
+    release_input_mutex ();
+  }
 
   char *&rabuf ();
   size_t &ralen ();
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 02d0ac052..0b404411e 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -571,31 +571,34 @@ wait_retry:
 #define buf ((char *) pv)
 
       int ret;
-      acquire_attach_mutex (INFINITE);
       acquire_input_mutex (INFINITE);
+      acquire_attach_mutex (INFINITE);
       ret = process_input_message ();
-      release_input_mutex ();
       release_attach_mutex ();
       switch (ret)
 	{
 	case input_error:
+	  release_input_mutex ();
 	  goto err;
 	case input_processing:
+	  release_input_mutex ();
 	  continue;
 	case input_ok: /* input ready */
 	  break;
 	case input_signalled: /* signalled */
+	  release_input_mutex ();
 	  goto sig_exit;
 	case input_winch:
+	  release_input_mutex ();
 	  continue;
 	default:
 	  /* Should not come here */
+	  release_input_mutex ();
 	  goto err;
 	}
     }
 
   /* Check console read-ahead buffer filled from terminal requests */
-  acquire_input_mutex (INFINITE);
   while (con.cons_rapoi && *con.cons_rapoi && buflen)
     {
       buf[copied_chars++] = *con.cons_rapoi++;
@@ -984,9 +987,7 @@ fhandler_console::process_input_message (void)
       if (toadd)
 	{
 	  ssize_t ret;
-	  release_input_mutex ();
 	  line_edit_status res = line_edit (toadd, nread, *ti, &ret);
-	  acquire_input_mutex (INFINITE);
 	  if (res == line_edit_signalled)
 	    {
 	      stat = input_signalled;
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 36bc6255f..9fbace95c 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -332,7 +332,9 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 
 	  termios_printf ("got interrupt %d, sending signal %d", c, sig);
 	  eat_readahead (-1);
+	  release_input_mutex_if_necessary ();
 	  tc ()->kill_pgrp (sig);
+	  acquire_input_mutex_if_necessary (INFINITE);
 	  ti.c_lflag &= ~FLUSHO;
 	  sawsig = true;
 	  goto restart_output;
-- 
2.30.0


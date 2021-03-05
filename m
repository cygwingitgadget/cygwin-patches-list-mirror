Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 35D5B3858001
 for <cygwin-patches@cygwin.com>; Fri,  5 Mar 2021 09:02:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 35D5B3858001
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 125920NR016823;
 Fri, 5 Mar 2021 18:02:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 125920NR016823
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Discard input already accepted on interrupt.
Date: Fri,  5 Mar 2021 18:01:50 +0900
Message-Id: <20210305090150.1593-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 05 Mar 2021 09:02:30 -0000

- Currently, input already accepted is not discarded on interrupt
  by VINTR, VQUIT and VSUSP keys. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h          |  2 ++
 winsup/cygwin/fhandler_termios.cc |  5 ++++-
 winsup/cygwin/fhandler_tty.cc     | 23 +++++++++++++++++++++++
 winsup/cygwin/tty.cc              |  1 +
 winsup/cygwin/tty.h               |  1 +
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 9b85d1ee9..4da35b7f5 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1921,6 +1921,7 @@ class fhandler_termios: public fhandler_base
   int eat_readahead (int n);
   virtual void acquire_input_mutex_if_necessary (DWORD ms) {};
   virtual void release_input_mutex_if_necessary (void) {};
+  virtual void discard_input () {};
 
  public:
   tty_min*& tc () {return _tc;}
@@ -2451,6 +2452,7 @@ public:
   void fixup_after_exec ();
   int tcgetpgrp ();
   void flush_to_slave ();
+  void discard_input ();
 
   fhandler_pty_master (void *) {}
 
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index ae35fe894..b487acab3 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -333,7 +333,10 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 
 	  termios_printf ("got interrupt %d, sending signal %d", c, sig);
 	  if (!(ti.c_lflag & NOFLSH))
-	    eat_readahead (-1);
+	    {
+	      eat_readahead (-1);
+	      discard_input ();
+	    }
 	  release_input_mutex_if_necessary ();
 	  tc ()->kill_pgrp (sig);
 	  acquire_input_mutex_if_necessary (INFINITE);
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 930501d01..244147a80 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -391,6 +391,21 @@ fhandler_pty_master::flush_to_slave ()
     accept_input ();
 }
 
+void
+fhandler_pty_master::discard_input ()
+{
+  DWORD bytes_in_pipe;
+  char buf[1024];
+  DWORD n;
+
+  WaitForSingleObject (input_mutex, INFINITE);
+  while (::bytes_available (bytes_in_pipe, from_master_cyg) && bytes_in_pipe)
+    ReadFile (from_master_cyg, buf, sizeof(buf), &n, NULL);
+  ResetEvent (input_available_event);
+  get_ttyp ()->discard_input = true;
+  ReleaseMutex (input_mutex);
+}
+
 DWORD
 fhandler_pty_common::__acquire_output_mutex (const char *fn, int ln,
 					     DWORD ms)
@@ -2150,6 +2165,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	}
 
       WaitForSingleObject (input_mutex, INFINITE);
+      if ((ti.c_lflag & ISIG) && !(ti.c_iflag & IGNBRK)
+	  && !(ti.c_lflag & NOFLSH) && memchr (buf, '\003', nlen))
+	get_ttyp ()->discard_input = true;
       DWORD n;
       WriteFile (to_slave, buf, nlen, &n, NULL);
       ReleaseMutex (input_mutex);
@@ -3709,6 +3727,8 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
       while (PeekConsoleInputA (from, r, INREC_SIZE, &n) && n)
 	{
 	  ReadConsoleInputA (from, r, n, &n);
+	  if (ttyp->discard_input)
+	    continue;
 	  int len = 0;
 	  char *ptr = buf;
 	  for (DWORD i = 0; i < n; i++)
@@ -3773,6 +3793,8 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	{
 	  DWORD n = MIN (bytes_in_pipe, NT_MAX_PATH);
 	  ReadFile (from, buf, n, &n, NULL);
+	  if (ttyp->discard_input)
+	    continue;
 	  char *ptr = buf;
 	  if (dir == tty::to_nat)
 	    {
@@ -3803,4 +3825,5 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
   else if (transfered)
     SetEvent (input_available_event);
   ttyp->pcon_input_state = dir;
+  ttyp->discard_input = false;
 }
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index eaab573e0..3c016315c 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -253,6 +253,7 @@ tty::init ()
   pcon_input_state = to_cyg;
   last_sig = 0;
   mask_flusho = false;
+  discard_input = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index b74120416..f041250a3 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -131,6 +131,7 @@ private:
   bool req_xfer_input;
   xfer_dir pcon_input_state;
   bool mask_flusho;
+  bool discard_input;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.30.1


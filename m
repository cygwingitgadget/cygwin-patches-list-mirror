Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 4A07A393C845
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 08:45:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4A07A393C845
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 11J8iEEw005989;
 Fri, 19 Feb 2021 17:44:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 11J8iEEw005989
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: pty: Make FLUSHO and Ctrl-O work.
Date: Fri, 19 Feb 2021 17:44:01 +0900
Message-Id: <20210219084402.1072-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219084402.1072-1-takashi.yano@nifty.ne.jp>
References: <20210219084402.1072-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 19 Feb 2021 08:45:03 -0000

- Previously, FLUSHO feature was implemented incompletely. With
  this patch, FLUSHO and Ctrl-O (VDISCARD) get working.
---
 winsup/cygwin/fhandler.h      |  1 +
 winsup/cygwin/fhandler_tty.cc | 17 +++++++++++------
 winsup/cygwin/select.cc       |  5 +++++
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index faa910692..5d095d384 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2467,6 +2467,7 @@ public:
   bool to_be_read_from_pcon (void);
   void get_master_thread_param (master_thread_param_t *p);
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
+  void set_mask_flusho (bool m) { get_ttyp ()->mask_flusho = m; }
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e4c35ea41..d30041af1 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -612,8 +612,8 @@ fhandler_pty_master::process_slave_output (char *buf, size_t len, int pktmode_on
 	      rc = -1;
 	      goto out;
 	    }
-	  /* DISCARD (FLUSHO) and tcflush can finish here. */
-	  if ((get_ttyp ()->ti.c_lflag & FLUSHO || !buf))
+	  /* tclush can finish here. */
+	  if (!buf)
 	    goto out;
 
 	  if (is_nonblocking ())
@@ -671,8 +671,9 @@ fhandler_pty_master::process_slave_output (char *buf, size_t len, int pktmode_on
 
       termios_printf ("bytes read %u", n);
 
-      if (get_ttyp ()->ti.c_lflag & FLUSHO || !buf)
-	continue;
+      if (!buf || ((get_ttyp ()->ti.c_lflag & FLUSHO)
+		   && !get_ttyp ()->mask_flusho))
+	continue; /* Discard read data */
 
       memcpy (optr, outbuf, n);
       optr += n;
@@ -691,6 +692,8 @@ fhandler_pty_master::process_slave_output (char *buf, size_t len, int pktmode_on
     }
 
 out:
+  if (buf)
+    set_mask_flusho (false);
   termios_printf ("returning %d", rc);
   return rc;
 }
@@ -2036,7 +2039,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 {
   ssize_t ret;
   char *p = (char *) ptr;
-  termios ti = tc ()->ti;
+  termios &ti = tc ()->ti;
 
   bg_check_types bg = bg_check (SIGTTOU);
   if (bg <= bg_eof)
@@ -2193,7 +2196,7 @@ fhandler_pty_master::tcflush (int queue)
 
   if (queue == TCIFLUSH || queue == TCIOFLUSH)
     ret = process_slave_output (NULL, OUT_BUFFER_SIZE, 0);
-  else if (queue == TCIFLUSH || queue == TCIOFLUSH)
+  if (queue == TCOFLUSH || queue == TCIOFLUSH)
     {
       /* do nothing for now. */
     }
@@ -2929,6 +2932,8 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr,
 {
   ssize_t towrite = len;
   BOOL res = TRUE;
+  if (ttyp->ti.c_lflag & FLUSHO)
+    return res; /* Discard write data */
   while (towrite)
     {
       if (!is_echo)
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 085de6deb..c8f288c27 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -710,6 +710,11 @@ peek_pipe (select_record *s, bool from_select)
     }
 
 out:
+  if (fh->get_major () == DEV_PTYM_MAJOR)
+    {
+      fhandler_pty_master *fhm = (fhandler_pty_master *) fh;
+      fhm->set_mask_flusho (s->read_ready);
+    }
   h = fh->get_output_handle_cyg ();
   if (s->write_selected && dev != FH_PIPER)
     {
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 7627cd6c7..eaab573e0 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -252,6 +252,7 @@ tty::init ()
   req_xfer_input = false;
   pcon_input_state = to_cyg;
   last_sig = 0;
+  mask_flusho = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 4ef1e04c9..b74120416 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -130,6 +130,7 @@ private:
   bool master_is_running_as_service;
   bool req_xfer_input;
   xfer_dir pcon_input_state;
+  bool mask_flusho;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.30.0


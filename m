Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id E1DDB4B19689
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 12:25:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E1DDB4B19689
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E1DDB4B19689
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773750322; cv=none;
	b=YzYukz3PulKdVMuVk62//W5Bh+q3yX8Z4DhaiBRda4Ro4+E3u+iZYLcQ9nhILc8rdKhmXAxdBy+SOTqgqtAx2W+gEwqvJryFYQsAejqx8b2sDEcW5PQz0tyjSHLsvCjvortYeY9l67j+QTAMxihgk13aACIMzwOOXqFrcXUjw/E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773750322; c=relaxed/simple;
	bh=qNl/dPNcjLXPL/phO2e1BTgl42V8/Gt7Yr3ruPfC4/U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=XM9JPMRBDr3+FhIm7gs4CSnmbARKZNC+V1twhhmFcezxo9nFwaxiL9SteHk3McQ6a+yu8i5p1xzlJ262WdDC2Ywzot4gHeLP4in1szHaScjFm2HFOl+o1OKQ796Phersg38tWMFF2qQdFqYlLAE5XAqa/cxvCEghA4yqQTYlVjc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E1DDB4B19689
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WYHhxKvJ
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260317122518978.NPRV.36235.HP-Z230@nifty.com>;
          Tue, 17 Mar 2026 21:25:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 4/6] Cygwin: pty: Apply line_edit() for transferred input to to_cyg
Date: Tue, 17 Mar 2026 21:23:08 +0900
Message-ID: <20260317122433.721-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
 <20260317122433.721-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773750319;
 bh=CNpAq4jOl4FchN9tTyIYUfSfQfU1uNP2L3txSnEOuJc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WYHhxKvJ/LDwz8jVipqBjpCX3w9HA3RCCmzfUdI1WDazkeAzU67H4706kKF/dJtYaOLQyYmB
 4volk4M19VJWMxrSEJ9bAV278VISdAGqXG3gREfGhkBA+L0+zmLOLSNEv939YSRxVzP/DsLm+8
 hjt621MU86olP3Jdqcvhnu6boXmEkMj4PzYWxc/1FwFB2qTK81zH/jDCzeQXfAvgIAtbNv5nyU
 LEUVSGWbjIpu3KkVZesyfkwidSq9OOnWSqnVa4Q/WPy8PzdAJmo2MiGirH+VQzlO3qpd1lWkd/
 qhkopqkIAt98iKIIL3E7B9rSv1aF4Tx1Fa6LA8SPOU+NY9Fw==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The typeahead input while non-cygwin app is running is put into
the pipe directly by transfer_input(). So, if the shell sets the
terminal canonical mode, erase char (such as backspace) fails to
erase chars transferred by transfer_input(). With this patch,
transferred input in the pipe is read and passed to line_edit()
to handle erase chars such as VERASE, VKILL, etc.

Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc           | 40 +++++++++++++++++++++++--
 winsup/cygwin/local_includes/fhandler.h |  2 ++
 winsup/cygwin/local_includes/tty.h      |  1 +
 winsup/cygwin/tty.cc                    |  1 +
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index bde88ab0e..1be853993 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2734,6 +2734,28 @@ reply:
   return 0;
 }
 
+void
+fhandler_pty_master::apply_line_edit_to_transferred_input ()
+{
+  const size_t pipesize = fhandler_pty_common::pipesize;
+  if (get_ttyp ()->input_transferred_to_cyg)
+    {
+      char buf[pipesize];
+      DWORD n;
+      ReadFile (from_master, buf, pipesize, &n, NULL);
+      char *p = buf;
+      while (n)
+	{
+	  ssize_t ret;
+	  line_edit (p, n, get_ttyp ()->ti, &ret);
+	  n -= ret;
+	  p += ret;
+	}
+      SetEvent (input_available_event);
+      get_ttyp ()->input_transferred_to_cyg = false;
+    }
+}
+
 static DWORD
 pty_master_thread (VOID *arg)
 {
@@ -2924,8 +2946,15 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
     {
       p->ttyp->fwd_last_time = GetTickCount64 ();
       DWORD n;
-      p->ttyp->fwd_not_empty =
-	::bytes_available (n, p->from_slave_nat) && n;
+      while (true)
+	{
+	  p->ttyp->fwd_not_empty =
+	    ::bytes_available (n, p->from_slave_nat) && n;
+	  if (p->ttyp->fwd_not_empty || p->ttyp->stop_fwd_thread)
+	    break;
+	  p->master->apply_line_edit_to_transferred_input ();
+	  Sleep (1);
+	}
       if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
@@ -4005,6 +4034,7 @@ fhandler_pty_master::get_master_fwd_thread_param (master_fwd_thread_param_t *p)
   p->from_slave_nat = from_slave_nat;
   p->output_mutex = output_mutex;
   p->ttyp = get_ttyp ();
+  p->master = this;
   SetEvent (thread_param_copied_event);
 }
 
@@ -4193,7 +4223,11 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 			     so no data available in cyg pipe. */
     ResetEvent (input_available_event);
   else if (transfered) /* There is data transfered to cyg pipe. */
-    SetEvent (input_available_event);
+    {
+      ttyp->input_transferred_to_cyg = true;
+      while (ttyp->input_transferred_to_cyg)
+	yield ();
+    }
   ttyp->pty_input_state = dir;
   ttyp->discard_input = false;
 }
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 16f55b4f7..f24ae199e 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2551,6 +2551,7 @@ public:
     HANDLE from_slave_nat;
     HANDLE output_mutex;
     tty *ttyp;
+    fhandler_pty_master *master;
   };
 private:
   int pktmode;			// non-zero if pty in a packet mode.
@@ -2627,6 +2628,7 @@ public:
   void get_master_thread_param (master_thread_param_t *p);
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   bool need_send_ctrl_c_event ();
+  void apply_line_edit_to_transferred_input ();
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 9485e24c5..6e4460e30 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -141,6 +141,7 @@ private:
   xfer_dir pty_input_state;
   bool discard_input;
   bool stop_fwd_thread;
+  volatile bool input_transferred_to_cyg;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index acc21c0ca..046c02ad1 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -255,6 +255,7 @@ tty::init ()
   last_sig = 0;
   discard_input = false;
   stop_fwd_thread = false;
+  input_transferred_to_cyg = false;
 }
 
 HANDLE
-- 
2.51.0


Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id E623E4BAD14F
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 14:10:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E623E4BAD14F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E623E4BAD14F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773756661; cv=none;
	b=ucn2MBQ5bDg2WjNFJdxy9rOejoXRnjjDea8zcQXpDH4iAk1liTpDf5+LofKF9jpyFst5bkYXBEsRIfklMGKVrifTN3rxlXugINGh8KvmC5G5zEnOmru3449GQYVcUPpksliclGvPJerQz5sRzX/I256eaw4mJDL53kK9tjGLWdM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773756661; c=relaxed/simple;
	bh=o0QHCg0zCmfPhoWvCXHFeaIE9xhbU3DKDnDiMUFyi+E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BSJ5550uNi5DdlX+8uUnbO8ulB3cA1p0EWZ5INRuaVfcSELJkoywj36eW0P0jleW+7RvoAVdtgqrtu2qWopItk1+4AlQTF1Yq3R11WPgvlHMTPWpa717r+5ipxArHgCrpTCK6FfLYq98ar7rKORkSdiN75B67rmK5c9q/ipSfCg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E623E4BAD14F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FCGrqZ2N
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260317141053979.DCVR.127398.HP-Z230@nifty.com>;
          Tue, 17 Mar 2026 23:10:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 4/6] Cygwin: pty: Apply line_edit() for transferred input to to_cyg
Date: Tue, 17 Mar 2026 23:10:33 +0900
Message-ID: <20260317141043.410-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773756654;
 bh=cwaVII0diiuRt2EWY5BEROQzlAjW+NnJ7yMCqWXKEbs=;
 h=From:To:Cc:Subject:Date;
 b=FCGrqZ2Nud+ptWIaGBfzBgn8930N8i658lTf5tKiMLSX/siRXrINGzRePWF0JGBAVXVerWR7
 PPddisDxqTzPFiB66TfZP5zabZHbMOQ8o3SMjc0KipYlcIbcGZcZysm1cfrYVflE5vTEhhloIw
 kbvBHV7t9s59+/RR5hQ9s5R3nYxQWauR9j8llCvvneNHRNBbYNAubrBc/PWKz4GgpZ6ZQLxESz
 R7nD/GZFxn8DfG9soyLnOFkkkC4bj5hvw+4QBIS4HEW4MZ9dJJBl80wqoIY9JHRMLt7TVZ3Z2R
 7WmcD7TSi0LNAjoK5x2AmjNkZMmJJgsGt4mDRrmPnDJCICIA==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/pty.cc           | 64 +++++++++++++++----------
 winsup/cygwin/local_includes/fhandler.h |  2 +
 winsup/cygwin/local_includes/tty.h      |  1 +
 winsup/cygwin/tty.cc                    |  1 +
 4 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index bde88ab0e..8a8c670d4 100644
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
 
@@ -4130,26 +4160,8 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	      ptr = mbbuf;
 	      len = nlen;
 	    }
-	  /* Call WriteFile() line by line */
-	  char *p0 = ptr;
-	  char *p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr));
-	  char *p_lf = (char *) memchr (p0, '\n', len - (p0 - ptr));
-	  while (p_cr || p_lf)
-	    {
-	      char *p1 =
-		p_cr ?  (p_lf ? ((p_cr + 1 == p_lf)
-				 ?  p_lf : min(p_cr, p_lf)) : p_cr) : p_lf;
-	      *p1 = '\n';
-	      n = p1 - p0 + 1;
-	      if (n && WriteFile (to, p0, n, &n, NULL) && n)
-		transfered = true;
-	      p0 = p1 + 1;
-	      p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr));
-	      p_lf = (char *) memchr (p0, '\n', len - (p0 - ptr));
-	    }
-	  n = len - (p0 - ptr);
-	  if (n && WriteFile (to, p0, n, &n, NULL) && n)
-	    transfered = true;
+	  if (len && WriteFile (to, ptr, len, &n, NULL) && n)
+	    transfered = true;;
 	}
     }
   else
@@ -4188,13 +4200,17 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
     }
   CloseHandle (to);
 
+  ttyp->pty_input_state = dir;
   /* Fix input_available_event which indicates availability in cyg pipe. */
   if (dir == tty::to_nat) /* all data is transfered to nat pipe,
 			     so no data available in cyg pipe. */
     ResetEvent (input_available_event);
   else if (transfered) /* There is data transfered to cyg pipe. */
-    SetEvent (input_available_event);
-  ttyp->pty_input_state = dir;
+    {
+      ttyp->input_transferred_to_cyg = true;
+      while (ttyp->input_transferred_to_cyg)
+	yield ();
+    }
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


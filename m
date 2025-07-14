Return-Path: <SRS0=YxEH=Z3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id CED963858D37
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 02:15:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CED963858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CED963858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752459305; cv=none;
	b=s+Eryk203vpe/9QU//Sc3vLo4WL6rhoUMO3T7sK6nY5bk6jpRIVGPg4fuAKdX48LfCSR0tGoiudSHEDbgpswQZ16KGJ5m8qA8+k+BpYAQY14MU0HZi8k+z/8KRRUip3tvgpGsa2/QeKTVcZraQZ/uWrVKRSlH8yOV0v/UoWt478=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752459305; c=relaxed/simple;
	bh=nhY5rEeklKv5jZkMPnsRqn8V9q4XtvYnuZ1f5U6Yeu0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=G/gvQFjmPoysMVKTrXnavnAKT1Aj0Az6Yj3tEBdBh1IHM3v13RUgQ9LKbhE6v8sKpZwbCIDNmin+7OL57nBtjonyuYeiLjGtEuqXQUCwXhnMyoj72Ujw8oyB5hN7zy+hgXtWQjuSXvPWWC5kcq7ifBLhrmhNZYCgSY1kOuGx9c4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CED963858D37
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=irD/65+0
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20250714021502096.GSYD.45927.localhost.localdomain@nifty.com>;
          Mon, 14 Jul 2025 11:15:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christoph Reiter <reiter.christoph@gmail.com>
Subject: [PATCH] Cygwin: pty: TCIFLUSH also clears readahead buffer in the master
Date: Mon, 14 Jul 2025 11:14:34 +0900
Message-ID: <20250714021442.1828-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1752459302;
 bh=v2SK6iM4LrIzzuXG3sov9RKuK5LoyC5BdMxkx3Qyet0=;
 h=From:To:Cc:Subject:Date;
 b=irD/65+0KpMlnOHqEP4WN1mbuT63w6cJw7sXe26zgcS1EYjBsxd4SNqQFTTC7H+mBUsFgA8B
 mg2IEL7tLg9NDTluY2a+6ytNiVOs7GR4OYrbPZSvQPEXyksflnsKx8nUC6N/jEDxC2WKLuiUB0
 D2hPE4KDt78TaFfmcSXDztQP5FzIW6TUJK3lGRBPUkw5tLOC/7rJER9ApRRCIC/TkfpJ6DxkPn
 SSPuv9lkoXp49oijzEnZlEGjuAdPX4DeFtYABD2iAbRR4gjJyqjO4QST6GYLh7lKErjzjTEKao
 bHjoOVLqJovh0DXj5CupLc0BbWUKkJDLotaRoFByk1GEwvig==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, TCIFLUSH flushed the pipe to_slave which transfers
input from master to slave. However, this was not sufficiant.
The master side holds input data before accept_input() in the
read-ahead buffer. So, if input data before 'enter' key can be
leaked into slave input after TCIFLUSH.

With this patch, TCIFLUSH requests master to flush read-ahead
buffer via master control pipe. To realize this, add cmd filed
to pipe_request structure so that the flush request can be
distinguished from existing pipe handle request.

Addresses: https://cygwin.com/pipermail/cygwin/2025-July/258442.html
Fixes: 41946df6111b (" (fhandler_tty_slave::tcflush): Implement input queue flushing by calling read with NULL buffer.")
Reported-by: Christoph Reiter <reiter.christoph@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc           | 31 +++++++++++++++++++++----
 winsup/cygwin/local_includes/fhandler.h |  1 +
 winsup/cygwin/release/3.6.4             |  3 +++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index b882b903e..77a363eb0 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -42,7 +42,14 @@ extern "C" int sscanf (const char *, const char *, ...);
   } while (0)
 
 /* pty master control pipe messages */
+enum pipe_request_cmd {
+  GET_HANDLES,
+  FLUSH_INPUT,
+  QUIT
+};
+
 struct pipe_request {
+  pipe_request_cmd cmd;
   DWORD pid;
 };
 
@@ -871,7 +878,7 @@ fhandler_pty_slave::open (int flags, mode_t)
     }
   else
     {
-      pipe_request req = { GetCurrentProcessId () };
+      pipe_request req = { GET_HANDLES, GetCurrentProcessId () };
       pipe_reply repl;
       DWORD len;
 
@@ -1139,7 +1146,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		      __small_sprintf (pipe,
 			       "\\\\.\\pipe\\cygwin-%S-pty%d-master-ctl",
 			       &cygheap->installation_key, get_minor ());
-		      pipe_request req = { GetCurrentProcessId () };
+		      pipe_request req = { GET_HANDLES, GetCurrentProcessId () };
 		      pipe_reply repl;
 		      DWORD len;
 		      if (!CallNamedPipe (pipe, &req, sizeof req,
@@ -1606,6 +1613,14 @@ fhandler_pty_slave::tcflush (int queue)
 
   if (queue == TCIFLUSH || queue == TCIOFLUSH)
     {
+      char pipe[MAX_PATH];
+      __small_sprintf (pipe,
+		       "\\\\.\\pipe\\cygwin-%S-pty%d-master-ctl",
+		       &cygheap->installation_key, get_minor ());
+      pipe_request req = { FLUSH_INPUT, GetCurrentProcessId () };
+      pipe_reply repl;
+      DWORD n;
+      CallNamedPipe (pipe, &req, sizeof req, &repl, sizeof repl, &n, 500);
       size_t len = UINT_MAX;
       read (NULL, len);
       ret = ((int) len) >= 0 ? 0 : -1;
@@ -2036,7 +2051,7 @@ fhandler_pty_master::close (int flag)
       if (master_ctl && get_ttyp ()->master_pid == myself->pid)
 	{
 	  char buf[MAX_PATH];
-	  pipe_request req = { (DWORD) -1 };
+	  pipe_request req = { QUIT, GetCurrentProcessId () };
 	  pipe_reply repl;
 	  DWORD len;
 
@@ -2542,13 +2557,18 @@ fhandler_pty_master::pty_master_thread (const master_thread_param_t *p)
 	  termios_printf ("RevertToSelf, %E");
 	  goto reply;
 	}
-      if (req.pid == (DWORD) -1)	/* Request to finish thread. */
+      if (req.cmd == QUIT) /* Request to finish thread. */
 	{
 	  /* Check if the requesting process is the master process itself. */
 	  if (pid == GetCurrentProcessId ())
 	    exit = true;
 	  goto reply;
 	}
+      if (req.cmd == FLUSH_INPUT)
+	{
+	  p->master->eat_readahead (-1);
+	  goto reply;
+	}
       if (NT_SUCCESS (allow))
 	{
 	  client = OpenProcess (PROCESS_DUP_HANDLE, FALSE, pid);
@@ -3801,6 +3821,7 @@ fhandler_pty_master::get_master_thread_param (master_thread_param_t *p)
   p->to_slave = get_output_handle ();
   p->master_ctl = master_ctl;
   p->input_available_event = input_available_event;
+  p->master = this;
   SetEvent (thread_param_copied_event);
 }
 
@@ -3842,7 +3863,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
       __small_sprintf (pipe,
 		       "\\\\.\\pipe\\cygwin-%S-pty%d-master-ctl",
 		       &cygheap->installation_key, ttyp->get_minor ());
-      pipe_request req = { GetCurrentProcessId () };
+      pipe_request req = { GET_HANDLES, GetCurrentProcessId () };
       pipe_reply repl;
       DWORD len;
       if (!CallNamedPipe (pipe, &req, sizeof req,
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 04e2ca4c3..4db2964fe 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2542,6 +2542,7 @@ public:
     HANDLE to_slave;
     HANDLE master_ctl;
     HANDLE input_available_event;
+    fhandler_pty_master *master;
   };
   /* Parameter set for the static function pty_master_fwd_thread() */
   struct master_fwd_thread_param_t {
diff --git a/winsup/cygwin/release/3.6.4 b/winsup/cygwin/release/3.6.4
index 4338214a6..fbc61c811 100644
--- a/winsup/cygwin/release/3.6.4
+++ b/winsup/cygwin/release/3.6.4
@@ -28,3 +28,6 @@ Fixes:
 
 - Fix ACL operations on directories.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-July/258433.html
+
+- Make TCIFLUSH also flush read-ahead data in the master.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-July/258442.html
-- 
2.45.1


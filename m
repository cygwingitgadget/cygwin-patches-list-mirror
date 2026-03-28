Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 298784BA900C
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:57:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 298784BA900C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 298784BA900C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774695442; cv=none;
	b=WmdMZ/uNyrR1a3Z3Hnbr9G43hhzv6+ghPLtRDTnLmLaNBANUL/pM18lEXTy9XdEWRPYfRN6c4JrgRJZM4p5Fpjzmf/biQecX/8yhSorQkr8+K0OuAoWxv6dXImBucScxmnf5K0TcOAAJzEA6SoAWu/LWsmnIdJOA4sKLE4sLdwU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774695442; c=relaxed/simple;
	bh=G4jXxDr0ceH4M5ulhlaPKStR9uDJkL6CZceATa69NRA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=nvfscCuyw+VXHpn/l1ccwVMPcjWMS/FuqkJYBcHchkdLBKlAr7u2SqMaVUiMdagcta+JGIvZ+FbQq6JgK15LwWfsNfLem9ordNQyzaR2l8ZJw794IzyNb81coJVxuaFS7WZo38hV1XmbpDlWrnfI8fUQgHrnLsKRDFAmSQFmpmQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 298784BA900C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dWTGhCjm
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260328105719422.LDDI.58584.HP-Z230@nifty.com>;
          Sat, 28 Mar 2026 19:57:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 5/7] Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
Date: Sat, 28 Mar 2026 19:55:49 +0900
Message-ID: <20260328105632.1916-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
 <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774695439;
 bh=S1LbaRnKTc5lrysey5fO1BYf9/hLZ7/uyZ40RLk8kQQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dWTGhCjmBBRR5eznnoToMUzpqHINtdeY2GHMD2xkmrvhLt7RdaRrMorAiy3JbTogNoVaaXG+
 7Nq8JnfdbCPTAy+wskt88KE1pRIsXeDdlpNgF7veRiHxt6ZwbL3SOhJ3mNagOL+hFbFHCltnBW
 9OTjWr8Tfq/LOfSGoYYM3aQYsyynASKdzp7UeXlGfqAz3KSfphDvj5PrX/2qMmn6BRDpPqwpJV
 2YIc8EwzvTpuvbyOQbtIyHW8i4WuY0wp+5WdB4GssYTCodvSuDd3bxTMwzMXQlbH2MqkM9vy69
 UThdtCuuF5S/+SxiFRdR3zQi81fHHf3syvlIZcgWuyOSq8VQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The master process (e.g. mintty) temporarily attaches to the pseudo
console's conhost in `transfer_input()` so it can read
INPUT_RECORDs via `ReadConsoleInputA()`. During that brief window,
`get_console_process_id()` inside `get_winpid_to_hand_over()` calls
`GetConsoleProcessList()`, which sees the master among the console's
attached processes and may select it as the handover target. That is
wrong because the master will detach immediately after the read.

Until now, `attach_mutex` was a process-local unnamed mutex, so
the slave's `get_winpid_to_hand_over()` could not serialize with
the master's temporary attachment. Make `attach_mutex` a
cross-process named mutex (`ATTACH_MUTEX`) shared within the PTY,
and acquire it around the `get_console_process_id()` calls in
`get_winpid_to_hand_over()`. This ensures the console process list
enumeration never observes the master while it is temporarily
attached.

Fixes: 1e6c51d74136 ("Cygwin: pty: Reorganize the code path of setting up and closing pcon.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc      | 16 ++++++++++++++--
 winsup/cygwin/local_includes/tty.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index beb3747d7..f1d459414 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -774,6 +774,12 @@ fhandler_pty_slave::open (int flags, mode_t)
       errmsg = "open pipe switch mutex failed, %E";
       goto err;
     }
+  if (!(attach_mutex
+	= get_ttyp ()->open_mutex (ATTACH_MUTEX, MAXIMUM_ALLOWED)))
+    {
+      errmsg = "open attach mutex failed, %E";
+      goto err;
+    }
   shared_name (buf, INPUT_AVAILABLE_EVENT, get_minor ());
   if (!(input_available_event = OpenEvent (MAXIMUM_ALLOWED, TRUE, buf)))
     {
@@ -2523,6 +2529,9 @@ void
 fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 {
   create_invisible_console ();
+  /* attach_mutex is initialized not only in the fork() case, but also in
+     the exec() case, since fixup_after_exec() calls fixup_after_fork(). */
+  attach_mutex = get_ttyp ()->open_mutex (ATTACH_MUTEX, MAXIMUM_ALLOWED);
 
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
@@ -3159,8 +3168,9 @@ fhandler_pty_master::setup ()
   if (!(pipe_sw_mutex = CreateMutex (&sa, FALSE, buf)))
     goto err;
 
-  if (!attach_mutex)
-    attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
+  errstr = shared_name (buf, ATTACH_MUTEX, unit);
+  if (!(attach_mutex = CreateMutex (&sa, FALSE, buf)))
+    goto err;
 
   /* Create master control pipe which allows the master to duplicate
      the pty pipe handles to processes which deserve it. */
@@ -3712,6 +3722,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
       if (ttyp->nat_pipe_owner_pid == GetCurrentProcessId ())
 	current_pid = GetCurrentProcessId ();
+      acquire_attach_mutex (mutex_timeout);
       switch_to = get_console_process_id (current_pid,
 					  false, true, true, true);
       if (!switch_to)
@@ -3720,6 +3731,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
       if (!switch_to && ttyp->pcon_activated)
 	switch_to = get_console_process_id (current_pid,
 					    false, false, false, false);
+      release_attach_mutex ();
     }
   return switch_to;
 }
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index cd1e202f1..962697782 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -22,6 +22,7 @@ details. */
 #define OUTPUT_MUTEX		"cygtty.output.mutex"
 #define INPUT_MUTEX		"cygtty.input.mutex"
 #define PIPE_SW_MUTEX		"cygtty.pipe_sw.mutex"
+#define ATTACH_MUTEX		"cygtty.attach.mutex"
 #define TTY_SLAVE_ALIVE		"cygtty.slave_alive"
 #define TTY_SLAVE_READING	"cygtty.slave_reading"
 
-- 
2.51.0


Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 9362C4C318AA
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 16:02:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9362C4C318AA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9362C4C318AA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774022551; cv=none;
	b=TNHW5CTnWGDD19VKffH9UjW2V7peKxx6wiqDjuWXz+GnwBG//EWYX12UaaOj/FtOvvf/N9NTFZXO7d6amnMPrJPhvz5G/VvbdlJKeDcDhcPpN+oWdiNx6LdGHgtXyfPMKZpZJnXOBYY2T++mruXy4a7vK02oNCtLRjkibvJDSFc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774022551; c=relaxed/simple;
	bh=TdKN5COqnVG89Qu1Q/4YBvlfNFJzXcC/hBWXJgwnt8A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=I4odtGl1Gf1m3aZI6euhAhbxwAXZDMMw7eL5i38tgFxGAwxKg+FoxIbrQGl/3vuRio77qBa/l+UxEZuyrzrXI2UAnJdlYSbnwBggy9uJaOGhM8botjhlHdy5giri4yFnsiaAvJDyPIZt4FEfpl7ysYOTKAlUaAxHdmy1kM4Ybbw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9362C4C318AA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oqNEH+PA
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260320160228940.HLTJ.14880.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 01:02:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 5/6] Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
Date: Sat, 21 Mar 2026 01:01:09 +0900
Message-ID: <20260320160143.1548-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
References: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
 <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774022548;
 bh=NjapuvRLRr/r9iojB3Bw9Jtx4/fgdNiga26TpeKfg90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oqNEH+PAJWdsaWpYh+YBEiu9pZjQoXCAK1XoaLQCrsofgkn3ccfOMCK/uqUdn0pepcDQMfqE
 xIqp55gXA1DH1U1wq9zwvyHPGUILu8YHywirG84hYCNYsU8dOG17UroGXW7xdEz8opX5uucEW7
 oyr2VSvZwX4FJQknwCKbTCj0Zdeisusf8flvqVKhCXYhYoIKkU1+oLfVceX3uqHaoanJPT4shM
 kXHbZ3ciNI46ST3MECJiDHMjhU5MdH50Q87FmAykm6mVo/UZmHg1lzUYJsyuDE8N+XhIcf7otD
 hoTaPoipVYSfNtK+ml2H8WQzb2GkNQoipC+DVk3NV0OUDiKg==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, attach_mutex is shared only in the same process. As a
result, if the master process of pty attaches to pseudo console
temporarily, get_winpid_to_hand_over() may wrongly find the master
process to hand over the pseudo console. make attach_mutex shared
within the PTY and guard get_winpid_to_hand_over() with it.

Fixes: 1e6c51d74136 ("Cygwin: pty: Reorganize the code path of setting up and closing pcon.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc      | 14 ++++++++++++--
 winsup/cygwin/local_includes/tty.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 2a0e0d2f7..0de6ec007 100644
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
@@ -2533,6 +2539,7 @@ void
 fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 {
   create_invisible_console ();
+  attach_mutex = get_ttyp ()->open_mutex (ATTACH_MUTEX, MAXIMUM_ALLOWED);
 
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
@@ -3164,8 +3171,9 @@ fhandler_pty_master::setup ()
   if (!(pipe_sw_mutex = CreateMutex (&sa, FALSE, buf)))
     goto err;
 
-  if (!attach_mutex)
-    attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
+  errstr = shared_name (buf, ATTACH_MUTEX, unit);
+  if (!(attach_mutex = CreateMutex (&sa, FALSE, buf)))
+    goto err;
 
   /* Create master control pipe which allows the master to duplicate
      the pty pipe handles to processes which deserve it. */
@@ -3725,6 +3733,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
       if (ttyp->nat_pipe_owner_pid == GetCurrentProcessId ())
 	current_pid = GetCurrentProcessId ();
+      acquire_attach_mutex (mutex_timeout);
       switch_to = get_console_process_id (current_pid,
 					  false, true, true, true);
       if (!switch_to)
@@ -3733,6 +3742,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
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


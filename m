Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 9DE784BBC0C8
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 12:25:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9DE784BBC0C8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9DE784BBC0C8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773750333; cv=none;
	b=Zg7YyrOXL74M7MlxMJoRdLxc1IBt78/tenxKAP2Ut4AYuA7q56q7T4X19veVYWkBY3Ksqzzs1Xx1TlSunH9P172ZCJEMI8eH5QkMyb6/8vW1NcZtUzSrL2sSZnigY4IWPpTTgFfejVndLfiYyL8DpgdZ0VKGTDiFmjsV6+XMQR8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773750333; c=relaxed/simple;
	bh=jH3rM/pkKIv9CU+echKSV1cB5Uzuu7JD4C/Tr0Dzkt8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=EfO8ZLzN0vF97inyzPUz8iO1JaZ/DgqH+Y9thFpPuidFXZXF4HR9sEhnvof4i8ir2SoIZNRiZwSbFJ4pzVCBQ7hlk+psIrO/o7etXRmnO7Ot9PjtaAaTeWLo+WchaFRO0A45f9tF3O9SWSjSxMNeuCSuHc/7FbP2f8LW3uVRKuM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9DE784BBC0C8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QGMdX48l
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260317122530842.NPTC.36235.HP-Z230@nifty.com>;
          Tue, 17 Mar 2026 21:25:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 5/6] Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
Date: Tue, 17 Mar 2026 21:23:09 +0900
Message-ID: <20260317122433.721-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
 <20260317122433.721-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773750330;
 bh=VqYA5U55E2vcQXcZT3l8NyRopOpWiv3es6mBHTWun3k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QGMdX48lDB+GknLk5XulRw4DsoyZ9A8LC/pPhVfdw3UP+XFdwiCn4ySoDN6hO+nm7tDKveoJ
 hDxYcb4ij/CzswITbzQLdT7GUXx/U2/GiQIv6nkYhCHgYH+UIoGt98ku4sUPxqhTY8Keom0BBV
 JDYcEvx64vOmxyrccM52vbnFFA56Zs6lEZz8vblLceO9rzJotXMLHn5PiJ7wvUF2w5ltpGZ0BT
 8MzDxYCSz9spiA8YxdnVlppC/xRAvZu/yWLd03U/fkD6K8VjmqJmeplHbEAHhp2pnMbQU0c3mf
 RsruF6Bk8Rgx1PN84KKHBp97i63ekgW0j9/BpUCOvrdiBZ3w==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 1be853993..149e8e2cd 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -773,6 +773,12 @@ fhandler_pty_slave::open (int flags, mode_t)
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
@@ -2538,6 +2544,7 @@ void
 fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 {
   create_invisible_console ();
+  attach_mutex = get_ttyp ()->open_mutex (ATTACH_MUTEX, MAXIMUM_ALLOWED);
 
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
@@ -3160,8 +3167,9 @@ fhandler_pty_master::setup ()
   if (!(pipe_sw_mutex = CreateMutex (&sa, FALSE, buf)))
     goto err;
 
-  if (!attach_mutex)
-    attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
+  errstr = shared_name (buf, ATTACH_MUTEX, unit);
+  if (!(attach_mutex = CreateMutex (&sa, FALSE, buf)))
+    goto err;
 
   /* Create master control pipe which allows the master to duplicate
      the pty pipe handles to processes which deserve it. */
@@ -3720,6 +3728,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
       if (ttyp->nat_pipe_owner_pid == GetCurrentProcessId ())
 	current_pid = GetCurrentProcessId ();
+      acquire_attach_mutex (mutex_timeout);
       switch_to = get_console_process_id (current_pid,
 					  false, true, true, true);
       if (!switch_to)
@@ -3728,6 +3737,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
       if (!switch_to && ttyp->pcon_activated)
 	switch_to = get_console_process_id (current_pid,
 					    false, false, false, false);
+      release_attach_mutex ();
     }
   return switch_to;
 }
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 6e4460e30..5f173fc06 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -21,6 +21,7 @@ details. */
 #define OUTPUT_MUTEX		"cygtty.output.mutex"
 #define INPUT_MUTEX		"cygtty.input.mutex"
 #define PIPE_SW_MUTEX		"cygtty.pipe_sw.mutex"
+#define ATTACH_MUTEX		"cygtty.attach.mutex"
 #define TTY_SLAVE_ALIVE		"cygtty.slave_alive"
 #define TTY_SLAVE_READING	"cygtty.slave_reading"
 
-- 
2.51.0


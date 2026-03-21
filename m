Return-Path: <SRS0=Yn/K=BV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id A5D7A4B9DB65
	for <cygwin-patches@cygwin.com>; Sat, 21 Mar 2026 11:36:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A5D7A4B9DB65
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A5D7A4B9DB65
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774093018; cv=none;
	b=WD3gw7SnwnnKzejMTfy0iTI34VzQ0cFSGR/Ss7o23TPoWV3HMrTkdtlRWhOG1ZnPT/kHp61kqSnqvA+vgkXJ5Vr85pOiq/QUReK0BymNAYA9U8G4QdFjpxRjvrdXXwvWRanIOMPHpohpkrZJvfmS6EB+JrfFNRFIh0HZiy2z7kc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774093018; c=relaxed/simple;
	bh=TdKN5COqnVG89Qu1Q/4YBvlfNFJzXcC/hBWXJgwnt8A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vQeIGnhMbbPdiU5oWDGPzVmEeHDzyRn9odoTD1ZIOKgoTbwYxw8RFOGrMtIEr6iXemdo0vZdfr1uQJYfyMUYTMOHbMkROq1Xzk5WkAKLDEFL51wh/rMiS2msfDT0yk1uEnGvnqJlCJsNFDXsueDiY/X/s1gXKVzCsp+w80LBPXw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A5D7A4B9DB65
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YIVvQP9k
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260321113655758.VNUD.36235.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 20:36:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 5/6] Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
Date: Sat, 21 Mar 2026 20:35:30 +0900
Message-ID: <20260321113613.9443-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
References: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
 <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774093015;
 bh=NjapuvRLRr/r9iojB3Bw9Jtx4/fgdNiga26TpeKfg90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YIVvQP9khw4+1YVCMiliTEHCcuzoJVBu/uktS8LoF5V2jjXhr4y5MgEi5pSJfWtOv7nM5uSL
 /z4jqPvdXbGPMEcfnNCpLkDxpawy8t+GhhFwDFjyeHEsaj+zQjVsP5oWNX9Lr6cII3we9186lh
 Nl4IuRsmDBgaXqqJFvpACwIJp5nyrBPA3Nu3NbCekd+q+nI0tuJPuFTfv/P5zGgzgFgrp4Ezie
 7rml1OxZr+DPmlq35mYunwS8iYnG4porqioYqI+QbBR5GWteeWI9VpRsx9vmLGuIsmKLcdAYx4
 cdDnYDcqsLRydYlJ4ugLcOG1y1Fs4ViG4Urz91FQxT6rEYHQ==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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


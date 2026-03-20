Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 0BD224C31885
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 14:30:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0BD224C31885
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0BD224C31885
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774017024; cv=none;
	b=g+nEFqXH7VjW2eUStY0/KGV/xygdjnn4Y5umLusdt+YVAYmuQP5s2+K9zO5vdUvSIrEkyw9iIkaXW9N5Ea4AHjQkfLsaGTNFeYuFGcIxnPHH6nzJrCtE0mJsCwd6V21hjk90bE3yn9njDC4JpQmPVt04qaKOOi+XTvsU0f9soIg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774017024; c=relaxed/simple;
	bh=TdKN5COqnVG89Qu1Q/4YBvlfNFJzXcC/hBWXJgwnt8A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=kfH70UXxUlyRgujnrWVbn8o/vYYgxJOhLbkG3RRAMp2ec1aoM82I28jRzxDvk096j0cPAReSC51UH0sR2H3axMThnlWEMQmtr6A8bRdx28cBVXjmWXj6Xvk6eIELdgHNdRmdv8EwegEjsQvJ5T5eCq10AREFlfNXKeX+TEoo5W0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0BD224C31885
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kc8sBM40
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260320143022257.CZCD.19957.HP-Z230@nifty.com>;
          Fri, 20 Mar 2026 23:30:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 5/6] Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
Date: Fri, 20 Mar 2026 23:28:54 +0900
Message-ID: <20260320142925.8779-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
References: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
 <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774017022;
 bh=NjapuvRLRr/r9iojB3Bw9Jtx4/fgdNiga26TpeKfg90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kc8sBM40dL8DpHTo6eWBrNOT/P6/5JDj86s9I6kuCCoePvOix983r27AWqhK7+A0PZfX3Du6
 Dn8o+K7/FH7VJspAkblVmiBk8AfGhDSIZYrrEf7Ru+b/ORY3jBo4t8DPdsdbosCvnuFViBK2Hk
 59IRqiqe0PY+RM/KC+1uuJFlxJYEdGPio6LwQcbVKzt60P+FirWLW5fr7+Rl/wfG6W4ZgvGGg4
 yoZokH/oP+lWfR+R26HFM1PTPMy7SfpwJvvnxPC7vd6CA4EFpty60TB3UteqMMZMyg1lFx8cpO
 N3GSlXAmfr/XwzSHdfYTePXro90vL0728WmojrJ9pd8A+Opw==
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


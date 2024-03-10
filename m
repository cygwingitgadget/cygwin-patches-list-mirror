Return-Path: <SRS0=51/7=KQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id DDD533858CD1
	for <cygwin-patches@cygwin.com>; Sun, 10 Mar 2024 10:32:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DDD533858CD1
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DDD533858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710066744; cv=none;
	b=TxPlqABbpSJfc6dUC4nQDznnW0Ply1t3GmZ0SPhNcDq6D676kxA0l5/ut0rgGGVo/jYSfwaPR0B1jDZpV65bldekZzv2XAOkrVmf3OSSiSLoFnuwNa2cYNcsRhtDQC2NkWPFVGanQtR+xuqzX7saqw1H2XhnSJhVZfg61TYQMiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710066744; c=relaxed/simple;
	bh=17mQ1uhQFq6MhgLj3mAdstA8Kb1u6QB9UOdNF7ic8PI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B0Fj4gV5APvJBb0EIOn/4U+QVRu898dIal6ihiz0zxt444rvN6iyULHT8mXYBK5fRv5x0bo95OSSy1LGfH0+gFtzpk4CfwMBQXHvPquWxcdnKZ/+OZ/6d1xUXmG+18tfQ5kYsxBnjT9Tk+94Ed8DRharpdhzF0r80YhZJQRNFLc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1015.nifty.com with ESMTP
          id <20240310103217394.NJBA.81092.localhost.localdomain@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 10 Mar 2024 19:32:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Restore non-blocking mode which was reset for non-cygwin app.
Date: Sun, 10 Mar 2024 19:31:52 +0900
Message-ID: <20240310103202.3753-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If pipe reader is a non-cygwin app first, and cygwin process reads
the same pipe after that, the pipe has been set to bclocking mode
for the cygwin app. Hoever, the commit 9e4d308cd592 assumes the pipe
for cygwin process always is non-blocking mode. With this patch,
the pipe mode is restored to non-blocking when the non-cygwin app
exits. As the side effect of this fix, query_hdl for non-cygwin app
can be retrieved from its stub process. Therefore, 46bb999a894 has
been modified a bit as well.

Addresses: https://cygwin.com/pipermail/cygwin/2024-March/255644.html
Fixes: 9e4d308cd592 ("Cygwin: pipe: Adopt FILE_SYNCHRONOUS_IO_NONALERT flag for read pipe.")
Reported-by: wh <wh9692@protonmail.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 12 +++++++-----
 winsup/cygwin/spawn.cc         | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 29d3b41d9..11c833297 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -1205,15 +1205,17 @@ fhandler_pipe::get_query_hdl_per_process (OBJECT_NAME_INFORMATION *ntfn)
       ULONG len;
 
       /* Non-cygwin app may call ReadFile() for empty pipe, which makes
-	NtQueryObject() for ObjectNameInformation block. Therefore, do
-	not try to get query_hdl for non-cygwin apps. */
+	NtQueryObject() for ObjectNameInformation block. However, the stub
+	process for the non-cygwin app should have dup'ed pipe handle.
+	Therefore, use exec_dwProcessId instead. */
       _pinfo *p = pids[i];
-      if (!p || ISSTATE (p, PID_NOTCYGWIN))
+      if (!p)
 	continue;
 
+      DWORD winpid =
+	ISSTATE (p, PID_NOTCYGWIN) ? p->exec_dwProcessId : p->dwProcessId;
       HANDLE proc = OpenProcess (PROCESS_DUP_HANDLE
-				 | PROCESS_QUERY_INFORMATION,
-				 0, p->dwProcessId);
+				 | PROCESS_QUERY_INFORMATION, 0, winpid);
       if (!proc)
 	continue;
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 71d75bbf4..92723e5a1 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -579,6 +579,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
       int fileno_stderr = 2;
 
+      fhandler_pipe *pipew_duped = NULL, *piper_duped = NULL;
       if (!iscygwin ())
 	{
 	  bool need_send_sig = false;
@@ -590,6 +591,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
 		pipe->set_pipe_non_blocking (false);
+		pipew_duped = (fhandler_pipe *)
+			ccalloc (HEAP_FHANDLER, 1, sizeof (fhandler_pipe));
+		pipew_duped = new (pipew_duped) fhandler_pipe;
+		pipe->dup (pipew_duped, 0);
 		if (pipe->request_close_query_hdl ())
 		  need_send_sig = true;
 	      }
@@ -597,6 +602,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
 		pipe->set_pipe_non_blocking (false);
+		piper_duped = (fhandler_pipe *)
+			ccalloc (HEAP_FHANDLER, 1, sizeof (fhandler_pipe));
+		piper_duped = new (piper_duped) fhandler_pipe;
+		pipe->dup (piper_duped, 0);
 	      }
 
 	  if (need_send_sig)
@@ -905,6 +914,19 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      term_spawn_worker.cleanup ();
 	      term_spawn_worker.close_handle_set ();
 	    }
+	  if (pipew_duped)
+	    {
+	      bool is_nonblocking = pipew_duped->is_nonblocking ();
+	      pipew_duped->set_pipe_non_blocking (is_nonblocking);
+	      pipew_duped->close ();
+	      cfree (pipew_duped);
+	    }
+	  if (piper_duped)
+	    {
+	      piper_duped->set_pipe_non_blocking (true);
+	      piper_duped->close ();
+	      cfree (piper_duped);
+	    }
 	  /* Make sure that ctrl_c_handler() is not on going. Calling
 	     init_console_handler(false) locks until returning from
 	     ctrl_c_handler(). This insures that setting sigExeced
-- 
2.43.0


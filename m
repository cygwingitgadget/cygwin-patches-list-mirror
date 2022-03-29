Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id AEFFF385DC02
 for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2022 09:08:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AEFFF385DC02
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 22T97nda002856;
 Tue, 29 Mar 2022 18:07:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 22T97nda002856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1648544875;
 bh=HzGutQQ4mSouTKdrYvlc+VqUS3vhgBIcxuKAb5pGLKo=;
 h=From:To:Cc:Subject:Date:From;
 b=Y8kABuRnL4qdfoA+MiygnPMqR0q+nR57DvlNxqZ9kF7EFXGF48I5w6RKVQ0Tv0KjQ
 Us4l461Juemqrm7ChhDEhA1bK6sJYW3i8eNdq6F7SKlA81nmuFxaue//gyjxTuiT97
 v+1A+63FifRZolpVUdk6ZFd+psSHVHDIDkF67Yg3qt1Euj/84HVGmRMb0ybWXSwiNt
 Q55+R7nFSro+WeOVuADjl4sv6UQIMrUTWi3GJTiLGrq46gPHK5bj6dO5veFp3FegCM
 at8pWqhmvxwezOwrNtOX7AhWvWD4jRlCBjYONijjs7ujdw8EwhkP4vjQsJOTEyedlS
 xPwlkN+OjmR5w==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
Date: Tue, 29 Mar 2022 18:07:53 +0900
Message-Id: <20220329090753.47207-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 29 Mar 2022 09:08:26 -0000

- As mentioned in commit message of the commit b531d6b0, if multiple
  writers including non-cygwin app exist, the non-cygwin app cannot
  detect pipe closure on the read side when the pipe is created by
  system account or the the pipe creator is running as service.
  This is because query_hdl which is held in write side also is a
  read end of the pipe, so the pipe is still alive for the non-cygwin
  app even after the reader is closed.

  To avoid this problem, this patch lets all processes in the same
  process group close query_hdl using newly introduced internal signal
  __SIGNONCYGCHLD when non-cygwin app is started.

  Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251097.html
---
 winsup/cygwin/fhandler.h       | 11 +++++++++++
 winsup/cygwin/fhandler_pipe.cc | 23 +++++++++++++++++++++++
 winsup/cygwin/sigproc.cc       | 10 ++++++++++
 winsup/cygwin/sigproc.h        |  1 +
 winsup/cygwin/spawn.cc         | 13 ++++++++++++-
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index b87160edb..006c7b4bf 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1194,6 +1194,7 @@ private:
   HANDLE hdl_cnt_mtx;
   HANDLE query_hdl_proc;
   HANDLE query_hdl_value;
+  HANDLE query_hdl_close_req_evt;
   uint64_t pipename_key;
   DWORD pipename_pid;
   LONG pipename_id;
@@ -1258,6 +1259,16 @@ public:
   }
   bool reader_closed ();
   HANDLE temporary_query_hdl ();
+  bool need_close_query_hdl ()
+    {
+      return query_hdl_close_req_evt ?
+	IsEventSignalled (query_hdl_close_req_evt) : false;
+    }
+  void request_close_query_hdl ()
+    {
+      if (query_hdl_close_req_evt)
+	SetEvent (query_hdl_close_req_evt);
+    }
 };
 
 #define CYGWIN_FIFO_PIPE_NAME_LEN     47
diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index aef0bf6be..270ba34a0 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -566,6 +566,8 @@ fhandler_pipe::fixup_after_fork (HANDLE parent)
     fork_fixup (parent, select_sem, "select_sem");
   if (query_hdl)
     fork_fixup (parent, query_hdl, "query_hdl");
+  if (query_hdl_close_req_evt)
+    fork_fixup (parent, query_hdl_close_req_evt, "query_hdl_close_req_evt");
 
   fhandler_base::fixup_after_fork (parent);
   ReleaseMutex (hdl_cnt_mtx);
@@ -616,6 +618,16 @@ fhandler_pipe::dup (fhandler_base *child, int flags)
       ftp->close ();
       res = -1;
     }
+  else if (query_hdl_close_req_evt &&
+	   !DuplicateHandle (GetCurrentProcess (), query_hdl_close_req_evt,
+			     GetCurrentProcess (),
+			     &ftp->query_hdl_close_req_evt,
+			     0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+    {
+      __seterrno ();
+      ftp->close ();
+      res = -1;
+    }
   ReleaseMutex (hdl_cnt_mtx);
 
   debug_printf ("res %d", res);
@@ -635,6 +647,8 @@ fhandler_pipe::close ()
   WaitForSingleObject (hdl_cnt_mtx, INFINITE);
   if (query_hdl)
     CloseHandle (query_hdl);
+  if (query_hdl_close_req_evt)
+    CloseHandle (query_hdl_close_req_evt);
   int ret = fhandler_base::close ();
   ReleaseMutex (hdl_cnt_mtx);
   CloseHandle (hdl_cnt_mtx);
@@ -868,9 +882,18 @@ fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode)
 			0, sa->bInheritHandle, DUPLICATE_SAME_ACCESS))
     goto err_close_hdl_cnt_mtx0;
 
+  if (fhs[1]->query_hdl)
+    {
+      fhs[1]->query_hdl_close_req_evt = CreateEvent (sa, TRUE, FALSE, NULL);
+      if (!fhs[1]->query_hdl_close_req_evt)
+	goto err_close_hdl_cnt_mtx1;
+    }
+
   res = 0;
   goto out;
 
+err_close_hdl_cnt_mtx1:
+  CloseHandle (fhs[1]->hdl_cnt_mtx);
 err_close_hdl_cnt_mtx0:
   CloseHandle (fhs[0]->hdl_cnt_mtx);
 err_close_query_hdl:
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index d3f2b0c6a..62df96652 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1477,6 +1477,16 @@ wait_sig (VOID *)
 		clearwait = true;
 	    }
 	  break;
+	case __SIGNONCYGCHLD:
+	  cygheap_fdenum cfd (false);
+	  while (cfd.next () >= 0)
+	    if (cfd->get_dev () == FH_PIPEW)
+	      {
+		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
+		if (pipe->need_close_query_hdl ())
+		  pipe->close_query_handle ();
+	      }
+	  break;
 	}
       if (clearwait && !have_execed)
 	proc_subproc (PROC_CLEARWAIT, 0);
diff --git a/winsup/cygwin/sigproc.h b/winsup/cygwin/sigproc.h
index 23287c85b..d037eaec3 100644
--- a/winsup/cygwin/sigproc.h
+++ b/winsup/cygwin/sigproc.h
@@ -24,6 +24,7 @@ enum
   __SIGSETPGRP	    = -(_NSIG + 9),
   __SIGTHREADEXIT   = -(_NSIG + 10),
   __SIGPENDINGALL   = -(_NSIG + 11),
+  __SIGNONCYGCHLD   = -(_NSIG + 12),
 };
 #endif
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index fb3d09d84..cd2d3a7ef 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -28,6 +28,7 @@ details. */
 #include "tls_pbuf.h"
 #include "winf.h"
 #include "ntdll.h"
+#include "shared_info.h"
 
 static const suffix_info exe_suffixes[] =
 {
@@ -645,8 +646,18 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		     && (fd == fileno_stdout || fd == fileno_stderr))
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-		pipe->close_query_handle ();
 		pipe->set_pipe_non_blocking (false);
+		pipe->request_close_query_hdl ();
+
+		tty_min dummy_tty;
+		dummy_tty.ntty = (fh_devices) myself->ctty;
+		dummy_tty.pgid = myself->pgid;
+		tty_min *t = cygwin_shared->tty.get_cttyp ();
+		if (!t) /* If tty is not allocated, use dummy_tty instead. */
+		  t = &dummy_tty;
+		/* Emit __SIGNONCYGCHLD to let all processes in the
+		   process group close query_hdl. */
+		t->kill_pgrp (__SIGNONCYGCHLD);
 	      }
 	    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
 	      {
-- 
2.35.1


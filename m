Return-Path: <SRS0=8gjk=QE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.114])
	by sourceware.org (Postfix) with ESMTPS id 462963858408
	for <cygwin-patches@cygwin.com>; Fri,  6 Sep 2024 08:09:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 462963858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 462963858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.114
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725610153; cv=none;
	b=pJOWwuITNjBE0S7vW6ve/ThhrcUNstJSRgBG0wDa3ICudDE4BL5tCma87Fc551bAVB0ZgI5argKVjZ4ZKyHi3ZEi8sIU03jR8/YaHpZUez7hASciLrw5zIaBYem5IPNAEGcBk/kwrxKOuW/Xz/q9liVeir5fmfKcM0n2GnQrV5s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725610153; c=relaxed/simple;
	bh=FgOeQtpfQpLou9f0vA4TQd/MkSz22xG0A+A/iHr7em8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=r2Nfg07UyAL4Vk6yAWhGXpM944j4i3QhXd+ZT6WeyCillES+BwaqtMP9tzdDxZhIUzzVL2RF/YVaXA5wtYiq1VG3EuylfF+KHl6nL/2aG5gid6+6AZes/jlSAzXqIbOL2BZjzYe9TVG3bfAzkr7YLEk2dtjomCdpMdosiQ6GeUc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20240906080905654.KZBP.83552.localhost.localdomain@nifty.com>;
          Fri, 6 Sep 2024 17:09:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	isaacag,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: pipe: Restore blocking mode of read pipe on close()
Date: Fri,  6 Sep 2024 17:08:40 +0900
Message-ID: <20240906080850.14853-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725610145;
 bh=3wp+CEITHJ/OMlNY0hxmIUOfyQARRX/abegf47zsr1o=;
 h=From:To:Cc:Subject:Date;
 b=LTz6oQJPJ9tDidT1QdAK0WMVnlIaFWvEjISKR7tQV7/LoOordeiw5WA6kdNJO+yspG14QpLF
 WNUHACrzbcdwAHas39J4b21PRzjEw8XYxgCusyfz8dRZRgLRWvCnfeku8wayBpjJiVB3owjU16
 KCy8h0ImajBQ9DFj1wf6IqrX543nkSDrf20R9Df7mB/yfFRK3JugtVIyrBkcV/JjDjUT6Xh5zu
 9hFESJswSq3ziLhwwYDAH3DIO/nMj85ZY4zBWN5Z8KM8YiXiiilEcBf8zh5wcokmnWb38goSSj
 a5QOcIovukjXFjutE7IVTzhdh/LJqvVOeC0jpkNjObnNvsUQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If a cygwin app is executed from a non-cygwin app and the cygwin
app exits, the read pipe remains in the non-blocking mode because
of the commit fc691d0246b9. Due to this behaviour, the non-cygwin
app cannot read the pipe correctly after that. Similarly, if a
non-cygwin app is executed from a cygwin app and the non-cygwin
app exits, the read pipe remains in the blocking mode. With this
patch, the blocking mode of the read pipe is stored into a variable
was_blocking_read_pipe on set_pipe_non_blocking() when the cygwin
app starts and restored on close(). In addition, the pipe mode is
set to non-blocking mode in raw_read() if the mode is blocking
mode as well.

Addresses: https://github.com/git-for-windows/git/issues/5115
Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc          | 41 +++++++++++++++++++++++++
 winsup/cygwin/local_includes/fhandler.h |  3 ++
 winsup/cygwin/sigproc.cc                |  9 +-----
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 997346877..3b78cc183 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -54,6 +54,16 @@ fhandler_pipe::set_pipe_non_blocking (bool nonblocking)
   NTSTATUS status;
   IO_STATUS_BLOCK io;
   FILE_PIPE_INFORMATION fpi;
+  bool was_blocking_read_pipe_new = was_blocking_read_pipe;
+
+  if (get_device () == FH_PIPER && nonblocking && !was_blocking_read_pipe)
+    {
+      status = NtQueryInformationFile (get_handle (), &io, &fpi, sizeof fpi,
+				       FilePipeInformation);
+      if (NT_SUCCESS (status))
+	was_blocking_read_pipe_new =
+	  (fpi.CompletionMode == FILE_PIPE_QUEUE_OPERATION);
+    }
 
   fpi.ReadMode = FILE_PIPE_BYTE_STREAM_MODE;
   fpi.CompletionMode = nonblocking ? FILE_PIPE_COMPLETE_OPERATION
@@ -62,6 +72,11 @@ fhandler_pipe::set_pipe_non_blocking (bool nonblocking)
 				 FilePipeInformation);
   if (!NT_SUCCESS (status))
     debug_printf ("NtSetInformationFile(FilePipeInformation): %y", status);
+  else
+    {
+      was_blocking_read_pipe = was_blocking_read_pipe_new;
+      is_blocking_read_pipe = !nonblocking;
+    }
 }
 
 int
@@ -95,6 +110,8 @@ fhandler_pipe::init (HANDLE f, DWORD a, mode_t mode, int64_t uniq_id)
        even with FILE_SYNCHRONOUS_IO_NONALERT. */
     set_pipe_non_blocking (get_device () == FH_PIPER ?
 			   true : is_nonblocking ());
+  was_blocking_read_pipe = false;
+
   return 1;
 }
 
@@ -289,6 +306,9 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
   if (!len)
     return;
 
+  if (is_blocking_read_pipe)
+    set_pipe_non_blocking (true);
+
   DWORD timeout = is_nonblocking () ? 0 : INFINITE;
   DWORD waitret = cygwait (read_mtx, timeout);
   switch (waitret)
@@ -721,6 +741,8 @@ fhandler_pipe::close ()
     CloseHandle (query_hdl);
   if (query_hdl_close_req_evt)
     CloseHandle (query_hdl_close_req_evt);
+  if (was_blocking_read_pipe)
+    set_pipe_non_blocking (false);
   int ret = fhandler_base::close ();
   ReleaseMutex (hdl_cnt_mtx);
   CloseHandle (hdl_cnt_mtx);
@@ -1373,6 +1395,7 @@ fhandler_pipe::spawn_worker (int fileno_stdin, int fileno_stdout,
       {
 	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
 	pipe->set_pipe_non_blocking (false);
+	need_send_noncygchld_sig = true;
       }
 
   /* If multiple writers including non-cygwin app exist, the non-cygwin
@@ -1398,3 +1421,21 @@ fhandler_pipe::spawn_worker (int fileno_stdin, int fileno_stdout,
       t->kill_pgrp (__SIGNONCYGCHLD);
     }
 }
+
+void
+fhandler_pipe::sigproc_worker (void)
+{
+  cygheap_fdenum cfd (false);
+  while (cfd.next () >= 0)
+    if (cfd->get_dev () == FH_PIPEW)
+      {
+	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
+	if (pipe->need_close_query_hdl ())
+	  pipe->close_query_handle ();
+      }
+    else if (cfd->get_dev () == FH_PIPER)
+      {
+	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
+	pipe->is_blocking_read_pipe = true;
+      }
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 10bc9c7ec..000004479 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1197,6 +1197,8 @@ class fhandler_pipe: public fhandler_pipe_fifo
 private:
   HANDLE read_mtx;
   pid_t popen_pid;
+  bool was_blocking_read_pipe;
+  bool is_blocking_read_pipe;
   HANDLE query_hdl;
   HANDLE hdl_cnt_mtx;
   HANDLE query_hdl_proc;
@@ -1287,6 +1289,7 @@ public:
     }
   static void spawn_worker (int fileno_stdin, int fileno_stdout,
 			    int fileno_stderr);
+  static void sigproc_worker (void);
 };
 
 #define CYGWIN_FIFO_PIPE_NAME_LEN     47
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 99fa3c342..a758bc8f2 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1475,14 +1475,7 @@ wait_sig (VOID *)
 	    }
 	  break;
 	case __SIGNONCYGCHLD:
-	  cygheap_fdenum cfd (false);
-	  while (cfd.next () >= 0)
-	    if (cfd->get_dev () == FH_PIPEW)
-	      {
-		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
-		if (pipe->need_close_query_hdl ())
-		  pipe->close_query_handle ();
-	      }
+	  fhandler_pipe::sigproc_worker ();
 	  break;
 	}
       if (clearwait && !have_execed)
-- 
2.45.1


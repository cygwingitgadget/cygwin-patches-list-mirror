Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 45CE33858D35
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 14:33:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 45CE33858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1AGEXa89017746;
 Tue, 16 Nov 2021 23:33:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1AGEXa89017746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637073221;
 bh=++T9kQPK2D2ZhQK97D1IwglKxbyYP+iPisYHTjtKNbc=;
 h=From:To:Cc:Subject:Date:From;
 b=iMVp44rzpM02G14KWj/zxLk7Ptj+95J5ZV9m1x5Nz/4bz/0KE4qeXIxXsyN6SW2BL
 4V4A4zB+Po1LEvFxeyCxNobAXXDIEoS0DNmlrTzjeEhBe86RVKkG+MJgdOHVERQinI
 +M0KXh6qiwDqUYwR0UmnK5CP/xtbT/X7HEsLTosok9AmVIf98F9ExaPCvYns3uG81k
 wwbgOTHWiUUc//vozp0e/VbE9s+JdRjXeE6f2vofteBEPyZa+PxdT9i90cq2BvnM/G
 oc4hmNGPl+RsU6gQzASNT7G2jQD8SNLFru3iO46cJexPb1kyR2HursSWXRzwG0fu4W
 K1r9QJVAmU1lQ==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3] Cygwin: pipe: Handle STATUS_PENDING even for nonblocking
 mode.
Date: Tue, 16 Nov 2021 23:33:28 +0900
Message-Id: <20211116143328.1160-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 16 Nov 2021 14:33:58 -0000

- NtReadFile() and NtWriteFile() seems to return STATUS_PENDING
  occasionally even in nonblocking mode. This patch adds handling
  for STATUS_PENDING in nonblocking mode.

Addresses:
  https://cygwin.com/pipermail/cygwin/2021-November/249910.html
---
 winsup/cygwin/fhandler_pipe.cc | 81 ++++++++++++++++------------------
 winsup/cygwin/release/3.3.3    |  5 +++
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index 9392a28c1..3cbd434b7 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -279,13 +279,12 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
   size_t nbytes = 0;
   NTSTATUS status = STATUS_SUCCESS;
   IO_STATUS_BLOCK io;
-  HANDLE evt = NULL;
+  HANDLE evt;
 
   if (!len)
     return;
 
-  /* Create a wait event if we're in blocking mode. */
-  if (!is_nonblocking () && !(evt = CreateEvent (NULL, false, false, NULL)))
+  if (!(evt = CreateEvent (NULL, false, false, NULL)))
     {
       __seterrno ();
       len = (size_t) -1;
@@ -321,8 +320,7 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
       ULONG len1 = (ULONG) (len - nbytes);
       waitret = WAIT_OBJECT_0;
 
-      if (evt)
-	ResetEvent (evt);
+      ResetEvent (evt);
       FILE_PIPE_LOCAL_INFORMATION fpli;
       status = NtQueryInformationFile (get_handle (), &io,
 				       &fpli, sizeof (fpli),
@@ -336,7 +334,7 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 	break;
       status = NtReadFile (get_handle (), evt, NULL, NULL, &io, ptr,
 			   len1, NULL, NULL);
-      if (evt && status == STATUS_PENDING)
+      if (status == STATUS_PENDING)
 	{
 	  waitret = cygwait (evt, INFINITE, cw_cancel | cw_sig);
 	  /* If io.Status is STATUS_CANCELLED after CancelIo, IO has actually
@@ -406,8 +404,7 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 	break;
     }
   ReleaseMutex (read_mtx);
-  if (evt)
-    CloseHandle (evt);
+  CloseHandle (evt);
   if (status == STATUS_THREAD_SIGNALED && nbytes == 0)
     {
       set_errno (EINTR);
@@ -437,7 +434,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
   ULONG chunk;
   NTSTATUS status = STATUS_SUCCESS;
   IO_STATUS_BLOCK io;
-  HANDLE evt = NULL;
+  HANDLE evt;
 
   if (!len)
     return 0;
@@ -456,8 +453,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
   else
     chunk = pipe_buf_size;
 
-  /* Create a wait event if the pipe or fifo is in blocking mode. */
-  if (!is_nonblocking () && !(evt = CreateEvent (NULL, false, false, NULL)))
+  if (!(evt = CreateEvent (NULL, false, false, NULL)))
     {
       __seterrno ();
       return -1;
@@ -502,41 +498,41 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	{
 	  status = NtWriteFile (get_handle (), evt, NULL, NULL, &io,
 				(PVOID) ptr, len1, NULL, NULL);
-	  if (evt || !NT_SUCCESS (status) || io.Information > 0
-	      || len <= PIPE_BUF)
-	    break;
-	  len1 >>= 1;
-	}
-      if (evt && status == STATUS_PENDING)
-	{
-	  while (WAIT_TIMEOUT ==
-		 (waitret = cygwait (evt, (DWORD) 0, cw_cancel | cw_sig)))
+	  if (status == STATUS_PENDING)
 	    {
-	      if (reader_closed ())
+	      while (WAIT_TIMEOUT ==
+		     (waitret = cygwait (evt, (DWORD) 0, cw_cancel | cw_sig)))
 		{
-		  CancelIo (get_handle ());
-		  set_errno (EPIPE);
-		  raise (SIGPIPE);
-		  goto out;
+		  if (reader_closed ())
+		    {
+		      CancelIo (get_handle ());
+		      set_errno (EPIPE);
+		      raise (SIGPIPE);
+		      goto out;
+		    }
+		  else
+		    cygwait (select_sem, 10);
 		}
+	      /* If io.Status is STATUS_CANCELLED after CancelIo, IO has
+		 actually been cancelled and io.Information contains the
+		 number of bytes processed so far.
+		 Otherwise IO has been finished regulary and io.Status
+		 contains valid success or error information. */
+	      CancelIo (get_handle ());
+	      if (waitret == WAIT_SIGNALED && io.Status != STATUS_CANCELLED)
+		waitret = WAIT_OBJECT_0;
+
+	      if (waitret == WAIT_CANCELED)
+		status = STATUS_THREAD_CANCELED;
+	      else if (waitret == WAIT_SIGNALED)
+		status = STATUS_THREAD_SIGNALED;
 	      else
-		cygwait (select_sem, 10);
+		status = io.Status;
 	    }
-	  /* If io.Status is STATUS_CANCELLED after CancelIo, IO has actually
-	     been cancelled and io.Information contains the number of bytes
-	     processed so far.
-	     Otherwise IO has been finished regulary and io.Status contains
-	     valid success or error information. */
-	  CancelIo (get_handle ());
-	  if (waitret == WAIT_SIGNALED && io.Status != STATUS_CANCELLED)
-	    waitret = WAIT_OBJECT_0;
-
-	  if (waitret == WAIT_CANCELED)
-	    status = STATUS_THREAD_CANCELED;
-	  else if (waitret == WAIT_SIGNALED)
-	    status = STATUS_THREAD_SIGNALED;
-	  else
-	    status = io.Status;
+	  if (!is_nonblocking () || !NT_SUCCESS (status) || io.Information > 0
+	      || len <= PIPE_BUF)
+	    break;
+	  len1 >>= 1;
 	}
       if (isclosed ())  /* A signal handler might have closed the fd. */
 	{
@@ -570,8 +566,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	break;
     }
 out:
-  if (evt)
-    CloseHandle (evt);
+  CloseHandle (evt);
   if (status == STATUS_THREAD_SIGNALED && nbytes == 0)
     set_errno (EINTR);
   else if (status == STATUS_THREAD_CANCELED)
diff --git a/winsup/cygwin/release/3.3.3 b/winsup/cygwin/release/3.3.3
index c1e8cefbd..615c57977 100644
--- a/winsup/cygwin/release/3.3.3
+++ b/winsup/cygwin/release/3.3.3
@@ -22,3 +22,8 @@ Bug Fixes
   running bash in Windows Terminal and inserting an emoji does not
   work as expected.
   Addresses: https://github.com/git-for-windows/git/issues/3281
+
+- Fix issue that pipe read()/write() occationally returns a garnage
+  length when NtReadFile/NtWriteFile returns STATUS_PENDING in non-
+  blocking mode.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249910.html
-- 
2.33.0


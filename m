Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 0EA993857828
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 08:12:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0EA993857828
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 1AG8C9e7007713;
 Tue, 16 Nov 2021 17:12:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 1AG8C9e7007713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637050336;
 bh=A2oJS+Uk4zuAeatNSNqAAnltrNl7We7I0QXO7ufVwx4=;
 h=From:To:Cc:Subject:Date:From;
 b=f16yC2puFEZoHWmQ3cr4GLPYC6aHss0+hhee11dZjJ1YFQGBDymQflyGiXDX34eip
 lkqxVKu/1hSgC9ynMajenRmdBRHWI3D8rbVXbbm/AjYHa4LMxc69RQDel55J4tuqD4
 +BRSgoEALLNiAZSZnEXZTn+jnVA9+WHWQY/mFZNN1lIdin5Zgi9oKZr1ga9rpM6sIv
 V1WszqRRN9gebux6+3hsrC/Q9/1lpadS3zDxnGDPWv93B0/NPhUwmE0kaSLcathchO
 T6jtplEHTdvrEPhlRbLGjSbSaZO13ex+6W5f4vIWNKHxiPgQQeyHy9n9YXfZWXX+MC
 wFQHwi+EWlVgA==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: pipe: Handle STATUS_PENDING even for nonblocking
 mode.
Date: Tue, 16 Nov 2021 17:11:58 +0900
Message-Id: <20211116081158.9612-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Tue, 16 Nov 2021 08:12:48 -0000

- NtReadFile() and NtWriteFile() seems to return STATUS_PENDING
  occasionally even in nonblocking mode. This patch adds handling
  for STATUS_PENDING in nonblocking mode.

Addresses:
  https://cygwin.com/pipermail/cygwin/2021-November/249910.html
---
 winsup/cygwin/fhandler_pipe.cc | 25 ++++++++++---------------
 winsup/cygwin/release/3.3.3    |  5 +++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index 1ebf4de10..e96c24eba 100644
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
@@ -502,12 +498,12 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	{
 	  status = NtWriteFile (get_handle (), evt, NULL, NULL, &io,
 				(PVOID) ptr, len1, NULL, NULL);
-	  if (evt || !NT_SUCCESS (status) || io.Information > 0
+	  if (!is_nonblocking () || !NT_SUCCESS (status) || io.Information > 0
 	      || len <= PIPE_BUF)
 	    break;
 	  len1 >>= 1;
 	}
-      if (evt && status == STATUS_PENDING)
+      if (status == STATUS_PENDING)
 	{
 	  while (WAIT_TIMEOUT ==
 		 (waitret = cygwait (evt, (DWORD) 0, cw_cancel | cw_sig)))
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
index 1eb25e2fc..49c1bcdc3 100644
--- a/winsup/cygwin/release/3.3.3
+++ b/winsup/cygwin/release/3.3.3
@@ -16,3 +16,8 @@ Bug Fixes
 - Fix long-standing problem that new files don't get created with the
   FILE_ATTRIBUTE_ARCHIVE DOS attribute set.
   Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249909.html
+
+- Fix issue that pipe read()/write() occationally returns a garnage
+  length when NtReadFile/NtWriteFile returns STATUS_PENDING in non-
+  blocking mode.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249910.html
-- 
2.33.0


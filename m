Return-Path: <SRS0=tvi8=P5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id 7F2163858435
	for <cygwin-patches@cygwin.com>; Fri, 30 Aug 2024 14:16:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F2163858435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7F2163858435
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725027377; cv=none;
	b=AfdSiqDKYQ9rNqH+jx8kj6CzW5cxCNmOs2bNAA+1TqaWhWymuiClDndlfby//vhiPhs5X4qbvDp+LcJG9pS4q4wxuy1HZubIpZ0aGaIucYnf4yCUFkNRzpSGDLNgDkW7suX56mMqAu2lMRp2dvmbQOnxOcuv5SJ3nUkVflTZgps=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725027377; c=relaxed/simple;
	bh=ItC+2+v1f8cParcGk+rijo0biiQc0KPSQT6T7TQ1nOU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Hy0xzeNJZUv6S3f6hYhGGwV5DY9vTjWtfsPqYd6PsO+yL6xZOD+IpWwtAfnWiG9YJ6gnCUVk5Psvfm6UOWApTVZUxI3sGSeQPkwcghP0wjQBRyYTwnZikpcJk/zHJji96+oiBj/o16Cp/Y4E1KeRIKHAW23GMqCSacH7Lebpjh4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20240830141611124.GJQI.9629.localhost.localdomain@nifty.com>;
          Fri, 30 Aug 2024 23:16:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	isaacag,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on close()
Date: Fri, 30 Aug 2024 23:15:44 +0900
Message-ID: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725027371;
 bh=U0VMZDMO29mehsdSGDrhiRRpXfcKL8JNq1/lRNgr7go=;
 h=From:To:Cc:Subject:Date;
 b=tWhbVWvXezJp62OL3ss/7XUbLgDJHhvmWsJeLOwZcP7CYHFHVEViiO405IOc/0NAE/1OjMkv
 HXle2/eMJJGp1xQo8cDRUO+SqzhcxNT0WF+y9pxBgg1NtPSMO1l/gbNLbXCcIIxIFKmQSPKn9e
 5MMiw4RAih4yZXuiUGlY2wdwxIfwpQ7juT24qy120UazOXdgEjZZ++iUUsArvJ3BS9XHtYu82N
 eG9dBn7ql3StwtIcu/nYVPWrIbujCNA7vbx+PnmRl7kID3XyFfmA8e/Wp/18qz2SZxaoXN3+UC
 jABgvvXfbUtTNjy1dfY5h61VD+1bJEV6iZ+cr17/gUmSjDTA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If a cygwin app is executed from a non-cygwin app and the cygwin
app exits, read pipe remains on non-blocking mode because of the
commit fc691d0246b9. Due to this behaviour, the non-cygwin app
cannot read the pipe correctly after that. With this patch, the
blocking mode of the read pipe is stored into was_blocking_read_pipe
on set_pipe_non_blocking() when the cygwin app starts and restored
on close().

Addresses: https://github.com/git-for-windows/git/issues/5115
Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc          | 12 ++++++++++++
 winsup/cygwin/local_includes/fhandler.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 852076ccc..5c760d704 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -55,6 +55,15 @@ fhandler_pipe::set_pipe_non_blocking (bool nonblocking)
   IO_STATUS_BLOCK io;
   FILE_PIPE_INFORMATION fpi;
 
+  if (get_device () == FH_PIPER && nonblocking && !was_blocking_read_pipe)
+    {
+      status = NtQueryInformationFile (get_handle (), &io, &fpi, sizeof fpi,
+				       FilePipeInformation);
+      if (NT_SUCCESS (status))
+	was_blocking_read_pipe =
+	  (fpi.CompletionMode == FILE_PIPE_QUEUE_OPERATION);
+    }
+
   fpi.ReadMode = FILE_PIPE_BYTE_STREAM_MODE;
   fpi.CompletionMode = nonblocking ? FILE_PIPE_COMPLETE_OPERATION
     : FILE_PIPE_QUEUE_OPERATION;
@@ -95,6 +104,7 @@ fhandler_pipe::init (HANDLE f, DWORD a, mode_t mode, int64_t uniq_id)
        even with FILE_SYNCHRONOUS_IO_NONALERT. */
     set_pipe_non_blocking (get_device () == FH_PIPER ?
 			   true : is_nonblocking ());
+  was_blocking_read_pipe = false;
 
   /* Store pipe name to path_conv pc for query_hdl check */
   if (get_dev () == FH_PIPEW)
@@ -734,6 +744,8 @@ fhandler_pipe::close ()
     CloseHandle (query_hdl);
   if (query_hdl_close_req_evt)
     CloseHandle (query_hdl_close_req_evt);
+  if (was_blocking_read_pipe)
+    set_pipe_non_blocking (false);
   int ret = fhandler_base::close ();
   ReleaseMutex (hdl_cnt_mtx);
   CloseHandle (hdl_cnt_mtx);
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 8b02a2b1b..16c39b55b 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1216,6 +1216,7 @@ private:
   HANDLE query_hdl_proc;
   HANDLE query_hdl_value;
   HANDLE query_hdl_close_req_evt;
+  bool was_blocking_read_pipe;
   void release_select_sem (const char *);
   HANDLE get_query_hdl_per_process (OBJECT_NAME_INFORMATION *);
 public:
-- 
2.45.1


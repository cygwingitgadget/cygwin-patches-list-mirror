Return-Path: <SRS0=1xMm=ZJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id AD003385703B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 07:40:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AD003385703B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AD003385703B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750923607; cv=none;
	b=NOBnZBwM0X7BGK2z2nltthqWqly53L+zpKr6V1ZgS9asLi3Lwor4JmRt1R/E+molkUYG37q/64ABddqPUBGSdYOFoGGlVvL6s+9W8m+XsCPFb/i/g4d6s4Y4uE2sdR+VGGM+OKfjCql6AegWiuD/AuGFJUHFzQEOEs/r2jD9DjM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750923607; c=relaxed/simple;
	bh=NCwLq1tvzur/vPZQm1TcrthuX9WvTrvazB0EQqnV9dQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=M3LGhRC/bsxAn/aL3GzZ9QOjIIvVuAYDd6pOo0Ey1lCwLT0JkolCDhKz8UH/Zyh8hof7yO++xGxfgjL3KMbaDvcQGi4XR29kTsaji2Vkoura7izGB+WqW7NUavGqWdBW6NQ8zyVvL+XC0u5wwxTQIfh2Njb+ovVEnEg2e525zQY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AD003385703B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XvRM/u0N
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20250626074002972.JXVT.98325.localhost.localdomain@nifty.com>;
          Thu, 26 Jun 2025 16:40:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pipe: Fix unexpected blocking mode change by pipe_data_available()
Date: Thu, 26 Jun 2025 16:39:33 +0900
Message-ID: <20250626073945.1134-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750923603;
 bh=hPu5oSgYbzMcMzdNKewAXDzRBl+fiNnw7xUPzarzchA=;
 h=From:To:Cc:Subject:Date;
 b=XvRM/u0NO2QodjyhqUxRHYrjaXzhWZcm3frceI/WemO9vybTC8aBx3PYD4xPhRmM5+x6g5Db
 WurnLGhDoMx9wZOuYfKHuEbOhDz5C9psoeWZEp2nWs1WD/3K+Nz+96NvhN3PvsPwkS1RiCySN2
 WusmMZGUFxvejm5BS7mVKJOOyOueFoE6ItBQk9NIlqemjYkpNn9LP2IZ9Y0w8DGVusRp98PRno
 X8WgX4P6nHxsHBFUovw+r0vE3bG3VFYqEnVILTS6MET7E4Z0tTrmI/OLZqQXY378M5sOlcK9R6
 1IXkmEkOqpWnuuNg7aNYBCR7HqImV+DGkuaZaRpuVOKpjfZQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

pipe_data_available() is called from raw_write(). If the pipe is in
real_non_blocking_mode at that time, calling pipe_data_available()
can, in some cases, inadvertently revert the pipe to blocking mode.
Here is the background: pipe_data_available() checks the amount of
writable space in the pipe by calling NtQueryInformationFile() with
the FilePipeLocalInformation parameter. However, if the read side of
the pipe is simultaneously consuming data with a large buffer,
NtQueryInformationFile() may return 0 for WriteQuotaAvailable.
As a workaround for this behavior, pipe_data_available() temporarily
attempts to change the pipe-mode to blocking. If the pipe contains
data, this operation fails-indicating that the pipe is full. If it
succeeds, the pipe is considered empty. The problem arises from the
assumption that the pipe is always in real blocking mode before
attempting to flip the mode. However, if raw_write() has already set
the pipe to non-blocking mode due to its failure to determine available
space, two issues occur:
1) Changing to non-blocking mode in pipe_data_available() always
   succeeds, since the pipe is already in non-blocking mode.
2) After this, pipe_data_available() sets the pipe back to blocking
   mode, unintentionally overriding the non-blocking state required
   by raw_write().

This patch addresses the issue by having pipe_data_available() check
the current real blocking mode, temporarily flip the pipe-mode and
then restore the pipe-mode to its original state.

Addresses: https://github.com/git-for-windows/git/issues/5682#issuecomment-2997428207
Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by default")
Reported-by: Andrew Ng (nga888 @github)
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc          |  2 --
 winsup/cygwin/local_includes/fhandler.h |  3 +++
 winsup/cygwin/select.cc                 | 11 ++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index e35d523bb..e7dc8850f 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -326,7 +326,6 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
       ULONG_PTR nbytes_now = 0;
       ULONG len1 = (ULONG) (len - nbytes);
       DWORD select_sem_timeout = 0;
-      bool real_non_blocking_mode = false;
 
       FILE_PIPE_LOCAL_INFORMATION fpli;
       status = NtQueryInformationFile (get_handle (), &io,
@@ -453,7 +452,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
     return 0;
 
   ssize_t avail = pipe_buf_size;
-  bool real_non_blocking_mode = false;
 
   /* Workaround for native ninja. Native ninja creates pipe with size == 0,
      and starts cygwin process with that pipe. */
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 3d9bc9fa5..04e2ca4c3 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1203,6 +1203,7 @@ class fhandler_pipe_fifo: public fhandler_base
  protected:
   size_t pipe_buf_size;
   HANDLE pipe_mtx; /* Used only in the pipe case */
+  bool real_non_blocking_mode; /* Used only in the pipe case */
   virtual void release_select_sem (const char *) {};
 
   IMPLEMENT_STATUS_FLAG (bool, isclosed)
@@ -1212,6 +1213,8 @@ class fhandler_pipe_fifo: public fhandler_base
 
   virtual bool reader_closed () { return false; };
   ssize_t raw_write (const void *ptr, size_t len);
+
+  friend ssize_t pipe_data_available (int, fhandler_base *, HANDLE, int);
 };
 
 class fhandler_pipe: public fhandler_pipe_fifo
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index bb141b065..32c73fd0c 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -644,22 +644,23 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
 	reader is currently trying to read the pipe and it is pending.
 	In the latter case, the fact that the reader cannot read the data
 	immediately means that the pipe is empty. In the former case,
-	NtSetInformationFile() in set_pipe_non_blocking(true) will fail
-	with STATUS_PIPE_BUSY, while it succeeds in the latter case.
+	NtSetInformationFile() in set_pipe_non_blocking(!orig_mode) will
+	fail with STATUS_PIPE_BUSY, while it succeeds in the latter case.
 	Therefore, we can distinguish these cases by calling set_pipe_non_
 	blocking(true). If it returns success, the pipe is empty, so we
 	return the pipe buffer size. Otherwise, we return 0. */
       if (fh->get_device () == FH_PIPEW && fpli.WriteQuotaAvailable == 0)
 	{
+	  bool orig_mode = ((fhandler_pipe *) fh)->real_non_blocking_mode;
 	  NTSTATUS status =
-	    ((fhandler_pipe *) fh)->set_pipe_non_blocking (true);
+	    ((fhandler_pipe *) fh)->set_pipe_non_blocking (!orig_mode);
 	  if (status == STATUS_PIPE_BUSY)
 	    return 0; /* Full */
 	  else if (!NT_SUCCESS (status))
 	    /* We cannot know actual write pipe space. */
 	    return 1;
-	  /* Restore pipe mode to blocking mode */
-	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
+	  /* Restore pipe mode to original blocking mode */
+	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (orig_mode);
 	  /* Empty */
 	  fpli.WriteQuotaAvailable = fpli.InboundQuota;
 	}
-- 
2.45.1


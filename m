Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id EE1A33858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 10:59:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE1A33858039
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EE1A33858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750849189; cv=none;
	b=GEAbIm8RndfibRNl1CY1qksb8JaLdxyHXTOeXbj5qiI+pSd9wChxgbDE8EVStZkvWJvrLkRS51f9+WCC84JlpDykTDHHGci9SOnaCL+q2h31vGgx0/yf23B0mG0Qq28tNh0WumZHb9/R/gw6qPrYpjnH6xSwLDG1DyV/WEc+3sA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750849189; c=relaxed/simple;
	bh=Hl7KrXnJIEcinqcTBHBKla/VhPvg6RpaMr+zfGX2ekA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TmhiBwJm8CDujAKkvgC5I4G3nTAZ5nAebwgjPaMCHR3m5SYxcHZKoxb8xwqXo3Dd+QZL1T5qWhEoKQiDqu3WVjiRSNe07t0DtFR6REAb4pcf/GQS4VHVlX25mh18n3A8fqzks+DZzu9NI16JwZUXYWfzoywkEBgBLRUFHmU4NYM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EE1A33858039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qjtbc/El
Received: from localhost.localdomain by mta-snd-w08.mail.nifty.com
          with ESMTP
          id <20250625105947050.CDVC.125258.localhost.localdomain@nifty.com>;
          Wed, 25 Jun 2025 19:59:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pipe: Fix unexpected blocking mode change by pipe_data_available()
Date: Wed, 25 Jun 2025 19:59:23 +0900
Message-ID: <20250625105931.1522-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750849187;
 bh=PNL9jIUSdztmCqxTAEUObkRnYI3yG3Uo3YVORsNxYt8=;
 h=From:To:Cc:Subject:Date;
 b=qjtbc/ElClnn4rUP85Dix8SrAGemZESqiGJmIGC62ZQwhM8hZdK4Go5wFpHwY8U8SzCU0PGf
 54N/CWzFRz/3SHAqiXBmPPDX2XKDISnh6M0fo7dSE9Saw5NRH97Rha8NVrgr1F7xOISNo+g8J8
 +bR7xAW/uPdHB8UJwiGhaoF1exkpDDGdP1QlhkAzVuzVvY55Ct5q0QWr/2twwwVLkvrmbRcEae
 lR8jh88SoGd+0VTWv/djxBNoPIZpLHPV/0Bayq794EGz4hSMs/I1APnwySjqXriw3d0woa2Ixx
 chuwHGDrxp1GymU+Rr1mEnwUWzn39Z5NNb+Wd7chm5vxasMw==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

pipe_data_available() is called in the raw_write() and if the pipe
is real_non_blocking_mode in raw_write(), the pipe mode can be
accidentally reverted to blocking mode in some cases by calling
pipe_data_available(). With this patch, pipe_data_available()
reffers current real blocking mode, and restores the pipe mode
to the current state.

Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by default")
Reported-by: Andrew Ng (@github)
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc          |  2 --
 winsup/cygwin/local_includes/fhandler.h |  3 +++
 winsup/cygwin/select.cc                 | 11 ++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 4f23bd38c..ea0a8d807 100644
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


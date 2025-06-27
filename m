Return-Path: <SRS0=IwXV=ZK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w01.mail.nifty.com (mta-sp-w01.mail.nifty.com [106.153.228.33])
	by sourceware.org (Postfix) with ESMTPS id 2866D3852118
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 11:41:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2866D3852118
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2866D3852118
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751024481; cv=none;
	b=LwYl0CVxEtpcG1xp32XPifAghpDvSZNUvPuKA5j7rXFfRBEPZ7TPZSZESlq5OhiuvkPKaYo0ohVDmKSaDzzCsGR9cAyUyrohoxWuFxBtuuH1o3u+94h700Ws4kHxhJWspuMhS3G8LihcJ62Ahaq85qRC1E6E4U7t0EGHSJx4PmE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751024481; c=relaxed/simple;
	bh=urwfjYBHivqUms6BhQJMHMZAXxh69177Id2tMdzsLIA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=iEuty4p4oPouh2nF7RGbdxPN0FR4/8yW9+bJBPSYXIzlptS8bIlmH4XihYJ4B3vsopYIE5koqXFjXacE88Mk21XDZ2kB1asVX0L8u5Oq+5SBVcKgRMvui7ifsIDWt6yGqzi9LHgtM3jDpp3g3B70xZCsQMSBcwdUYjeKSFuZDZo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2866D3852118
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mB9ZsKTx
Received: from mta-snd-w01.mail.nifty.com by mta-sp-w01.mail.nifty.com
          with ESMTP
          id <20250627114119413.XEYQ.57084.mta-snd-w01.mail.nifty.com@nifty.com>;
          Fri, 27 Jun 2025 20:41:19 +0900
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250627114119338.QOUJ.69071.localhost.localdomain@nifty.com>;
          Fri, 27 Jun 2025 20:41:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/3] Cygwin: pipe: Fix SSH hang with non-cygwin pipe reader
Date: Fri, 27 Jun 2025 20:40:13 +0900
Message-ID: <20250627114103.30364-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751024479;
 bh=C1u2obnrAbkJvq/Dw7om6fSmYPXSZp2Yt6yW3/2edGk=;
 h=From:To:Cc:Subject:Date;
 b=mB9ZsKTxhxPA9PydTViky6h6chG3qRTdmC4oHMJ5uclcf9rFQDiKo5KJanDAiwj5iE9c0uQY
 OFfR/Y3qMGg2aByY/Mwh1M+a0u5diS4pM5Zf+RSp/22baBwnmXGMUb7Gj9mN3TYM9ruKBdqX0F
 cojKJeSUBuXOn4apcSvYkqJlJgMe7eBJT/XYRMAP49moF5SdxY829xXyFLPpneqCdJgHWxxw2Q
 2M1FQ5yaDi9COz7Lw2rKj8GGjYrsKL4DG+fLEfcYx0eeYnMiVKy3z4va84fK23PGLTmGRNDBgD
 +d9T8TjDMozRM20Z4xJUhZuGx5zhPu2WJa9tMih+DhuGsRrQ==
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If ssh is used with non-cygwin pipe reader, ssh some times hangs.
This happens when non-cygwin git (Git for Windows) starts cygwin
ssh. The background of the bug is as follows.

Before attempting to NtWriteFile() in raw_write() in non-blocking
mode, the amount of writable space in the pipe is checked by calling
NtQueryInformationFile with FilePipeLocalInformation parameter.
The same is also done by pipe_data_available() in select.cc.

However, if the read side of the pipe is simultaneously consuming
data, NtQueryInformationFile() returns less value than the amount
of writable space, i.e. the amount of writable space minus the size
of buffer to be read. This does not happen when the reader is a
cygwin app because cygwin read() for the pipe attempts to read
the amount of the data in the pipe at most. This means NtReadFile()
never enters a pending state. However, if the reader is non-cygwin
app, this cannot be expected. As a workaround for this problem,
the code checking the pipe space temporarily attempts to toggle
the pipe-mode. If the pipe contains data, this operation fails
with STATUS_PIPE_BUSY indicating that the pipe is not empty. If
it succeeds, the pipe is considered empty. The current code uses
this technic only when NtQueryInformationFile() retuns zero.

Therefore, if NtQueryInformationFile() returns 1, the amount of
writable space is assumed to be 1 even in the case that e.g. the
pipe size is 8192 bytes and reader is pending to read 8191 bytes.
Even worse, the current code fails to write more than 1 byte
to 1 byte pipe space due to the remnant of the past design.
Then the reader waits for data with 8191 bytes buffer while the
writer continues to fail to write to 1 byte space of the pipe.
This is the cause of the deadlock.

In practice, when using Git for Windows in combination with Cygwin
SSH, it has been observed that a read of 8191 bytes is occasionally
issued against a pipe with 8192 bytes of available space.

With this patch, the blocking-mode-toggling-check is performed
even if NtQueryInformationFile() returns non-zero value so that
the amount of the writable space in the pipe is always estimated
correctly.

Addresses: https://github.com/git-for-windows/git/issues/5682
Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by default")
Reported-by: Vincent-Liem (@github), Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 15 ++++++++++-----
 winsup/cygwin/select.cc        |  5 +++--
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index e35d523bb..bda0a9b25 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -491,9 +491,9 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 				       FilePipeLocalInformation);
       if (NT_SUCCESS (status))
 	{
-	  if (fpli.WriteQuotaAvailable != 0)
+	  if (fpli.WriteQuotaAvailable == fpli.InboundQuota)
 	    avail = fpli.WriteQuotaAvailable;
-	  else /* WriteQuotaAvailable == 0 */
+	  else /* WriteQuotaAvailable != InboundQuota */
 	    { /* Refer to the comment in select.cc: pipe_data_available(). */
 	      /* NtSetInformationFile() in set_pipe_non_blocking(true) seems
 		 to fail with STATUS_PIPE_BUSY if the pipe is not empty.
@@ -506,9 +506,14 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 		fh->set_pipe_non_blocking (false);
 	      else if (status == STATUS_PIPE_BUSY)
 		{
-		  /* Full */
-		  set_errno (EAGAIN);
-		  goto err;
+		  if (fpli.WriteQuotaAvailable == 0)
+		    {
+		      /* Full */
+		      set_errno (EAGAIN);
+		      goto err;
+		    }
+		  avail = fpli.WriteQuotaAvailable;
+		  status = STATUS_SUCCESS;
 		}
 	    }
 	}
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index bb141b065..0b9afb359 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -649,12 +649,13 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
 	Therefore, we can distinguish these cases by calling set_pipe_non_
 	blocking(true). If it returns success, the pipe is empty, so we
 	return the pipe buffer size. Otherwise, we return 0. */
-      if (fh->get_device () == FH_PIPEW && fpli.WriteQuotaAvailable == 0)
+      if (fh->get_device () == FH_PIPEW
+	  && fpli.WriteQuotaAvailable < fpli.InboundQuota)
 	{
 	  NTSTATUS status =
 	    ((fhandler_pipe *) fh)->set_pipe_non_blocking (true);
 	  if (status == STATUS_PIPE_BUSY)
-	    return 0; /* Full */
+	    return fpli.WriteQuotaAvailable; /* Not empty */
 	  else if (!NT_SUCCESS (status))
 	    /* We cannot know actual write pipe space. */
 	    return 1;
-- 
2.45.1


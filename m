Return-Path: <SRS0=IwXV=ZK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 72E40385DC3D
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 11:41:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 72E40385DC3D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 72E40385DC3D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751024492; cv=none;
	b=KeBEuYmqDjOHziDHjP+Wl0rwH9LMh+V1wBv1WNq1rnTMvnh1xOj6erWmZhlFstqafLR06mGeuIqZCTaDuOttzO0KQLfkg5MI8qoqDaRfOHnJt6C5d7AeGQAb9k7HnRCy1Z+96a33rkbSH4+s98SYpY5N9svkdv2DuRjQ4OyEGlY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751024492; c=relaxed/simple;
	bh=spFqAnuxPM85NCkHKZgSsGpG488zfIKekQoHmZt3sMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=AwaoLbBTusytYS/HUnAnX6I3DPLcfCFhUtp+krJTkIBKRdwhU9bIJaAicIbtwttzw5O+YpfFRXJP3lJcEbUG7hDW+SR+z1tVrcw7b32s0/novUQ2DUA2E3368LLSq2daDb3w06BFB71758DI7VN/Njb98zpLqW5t+Y0fKsuY/us=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250627114130699.QOUS.69071.localhost.localdomain@nifty.com>;
          Fri, 27 Jun 2025 20:41:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 2/3] Cygwin: pipe; Update source comment align with previous commit
Date: Fri, 27 Jun 2025 20:40:14 +0900
Message-ID: <20250627114103.30364-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250627114103.30364-1-takashi.yano@nifty.ne.jp>
References: <20250627114103.30364-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751024490;
 bh=CUU6uPsV05sZA2aREDCe1CmLvEFO3Uld+FSDw8fdRtw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gOVjKHkIX4Bu2NIIfbXXe5k17YlIsMf8fqDMbX6CHvZMfzmGWSnDaXiZWIv9E0Ca6Kl/X438
 ZAzB+hRvBH6HgW9NI6xDq1Pnkap2WvxOTfBv36xA7dJndFWDg4XoVNsViGc53l+92q0THbaTx4
 yH+2FNSM+/I7GjShOC3cb96Xz0gsm1UCaFvAYOUKHSwMuijjtZ9kb4L6POVvUddj8cd+D52J97
 jzRKtHi/Atql0WsOx3r95iZR78ziN+Rnr2jjurpUAU+iNz/EpKOoOLP10muD0w2fw/xckyAWZH
 ow3Ha5SW/YnGMrajGsgJFsc5Tb/pPLDCUmTSKgjLKz+FrhZA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit "Cygwin: pipe: Fix SSH hang with non-cygwin pipe reader"
modifies how the amount of writable data is evaluated. This patch
updates the source comments to align with that change.

Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc |  8 ++---
 winsup/cygwin/select.cc        | 54 ++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index bda0a9b25..22addbb18 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -497,8 +497,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	    { /* Refer to the comment in select.cc: pipe_data_available(). */
 	      /* NtSetInformationFile() in set_pipe_non_blocking(true) seems
 		 to fail with STATUS_PIPE_BUSY if the pipe is not empty.
-		 In this case, the pipe is really full if WriteQuotaAvailable
-		 is zero. Otherwise, the pipe is empty. */
+		 In this case, WriteQuotaAvailable indicates real pipe space.
+		 Otherwise, the pipe is empty. */
 	      status = fh->set_pipe_non_blocking (true);
 	      if (NT_SUCCESS (status))
 		/* Pipe should be empty because reader is waiting for data. */
@@ -655,9 +655,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	  if (io.Information > 0 || len <= PIPE_BUF || short_write_once)
 	    break;
 	  /* Independent of being blocking or non-blocking, if we're here,
-	     the pipe has less space than requested.  If the pipe is a
-	     non-Cygwin pipe, just try the old strategy of trying a half
-	     write.  If the pipe has at
+	     the pipe has less space than requested.  If the pipe has at
 	     least PIPE_BUF bytes available, try to write all matching
 	     PIPE_BUF sized blocks.  If it's less than PIPE_BUF,  try
 	     the next less power of 2 bytes.  This is not really the Linux
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 0b9afb359..701f4d9a6 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -623,32 +623,34 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
   if (mode == PDA_WRITE)
     {
       /* If there is anything available in the pipe buffer then signal
-        that.  This means that a pipe could still block since you could
-        be trying to write more to the pipe than is available in the
-        buffer but that is the hazard of select().
-
-        Note that WriteQuotaAvailable is unreliable.
-
-        Usually WriteQuotaAvailable on the write side reflects the space
-        available in the inbound buffer on the read side.  However, if a
-        pipe read is currently pending, WriteQuotaAvailable on the write side
-        is decremented by the number of bytes the read side is requesting.
-        So it's possible (even likely) that WriteQuotaAvailable is 0, even
-        if the inbound buffer on the read side is not full.  This can lead to
-        a deadlock situation: The reader is waiting for data, but select
-        on the writer side assumes that no space is available in the read
-        side inbound buffer.
-
-	Consequentially, there are two possibilities when WriteQuotaAvailable
-	is 0. One is that the buffer is really full. The other is that the
-	reader is currently trying to read the pipe and it is pending.
-	In the latter case, the fact that the reader cannot read the data
-	immediately means that the pipe is empty. In the former case,
-	NtSetInformationFile() in set_pipe_non_blocking(true) will fail
-	with STATUS_PIPE_BUSY, while it succeeds in the latter case.
-	Therefore, we can distinguish these cases by calling set_pipe_non_
-	blocking(true). If it returns success, the pipe is empty, so we
-	return the pipe buffer size. Otherwise, we return 0. */
+	 that.  This means that a pipe could still block since you could
+	 be trying to write more to the pipe than is available in the
+	 buffer but that is the hazard of select().
+
+	 Note that WriteQuotaAvailable is unreliable.
+
+	 Usually WriteQuotaAvailable on the write side reflects the space
+	 available in the inbound buffer on the read side.  However, if a
+	 pipe read is currently pending, WriteQuotaAvailable on the write side
+	 is decremented by the number of bytes the read side is requesting.
+	 So it's possible (even likely) that WriteQuotaAvailable is less than
+	 actual space available in the pipe, even if the inbound buffer is
+	 empty. This can lead to a deadlock situation: The reader is waiting
+	 for data, but select on the writer side assumes that no space is
+	 available in the read side inbound buffer.
+
+	 Consequentially, there are two possibilities when WriteQuotaAvailable
+	 is less than pipe size. One is that the buffer is really not empty.
+	 The other is that the reader is currently trying to read the pipe
+	 and it is pending.
+	 In the latter case, the fact that the reader cannot read the data
+	 immediately means that the pipe is empty. In the former case,
+	 NtSetInformationFile() in set_pipe_non_blocking(true) will fail
+	 with STATUS_PIPE_BUSY, while it succeeds in the latter case.
+	 Therefore, we can distinguish these cases by calling set_pipe_non_
+	 blocking(true). If it returns success, the pipe is empty, so we
+	 return the pipe buffer size. Otherwise, we return the value of
+	 WriteQuotaAvailable as is. */
       if (fh->get_device () == FH_PIPEW
 	  && fpli.WriteQuotaAvailable < fpli.InboundQuota)
 	{
-- 
2.45.1


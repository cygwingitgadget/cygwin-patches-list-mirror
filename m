Return-Path: <SRS0=IwXV=ZK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 3DD743857C6E
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 10:06:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3DD743857C6E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3DD743857C6E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751018797; cv=none;
	b=sEuHdn2Am9zuEmqjU1/nlVz06zxIi2x6tIyILUqY2EUqsbYu6ZV53GswqOZY1vmMvekyO61b94dZ5gwF4ASjweLaoJ9zbTb28u3ggySRp9p25UpA6XvbmrFXGvjeyq+qFGigCAjA1pwc58YcOxnlFMz27zqoyFafXfZRhcu5MQk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751018797; c=relaxed/simple;
	bh=v3NSuVhsb8NHiYlna/FnItr2aGr2c3hGI9FebBT6EbI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ZwXGT9GLaB11sWY9u4L4vfzlniUi4aFF+/5CJI3wSk74kPXIiua56koQtel9vQ2SgKL8zSdVwnao598J4PJbv5sILN3hdA2JnNi6sUxcSk3KSnXPkXFQDVTiaKyVsRDJDeFAudgxxXOBL7IPsMA69r2Hnf3RY5CW+6VBDz9PAVg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w08.mail.nifty.com
          with ESMTP
          id <20250627100634641.JEZU.125258.localhost.localdomain@nifty.com>;
          Fri, 27 Jun 2025 19:06:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Cygwin: pipe: Fix SSH hang with non-cygwin pipe reader
Date: Fri, 27 Jun 2025 19:05:27 +0900
Message-ID: <20250627100607.430-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751018794;
 bh=IjtgQ4yi7K5wLiRqpK6FSjHq2gJBWxSIkhYNl/FobHs=;
 h=From:To:Cc:Subject:Date;
 b=o+vR6odByalHM9zY0vd3w7fS7m3ym70c/2u+PzTBok7qc6Y1EaojtF1kT0O492kuuVpuN5EO
 ttW0M3d5KquVEeVpBzh2SZ7aO7ypwupcQwQCcmf/dxOS1Wk4h8xroNUqt/Df6O5tSFow6O8bYU
 Y5+Q8GkdzWAvCOIMjZ9mNpOEBnWHSDbhUjIRSa/e6AM7DQVbL8pLTOb6tgyqC/jjlsVuvia17b
 ea+caB0tBpPrmQK1gmjq6Na0ZFJ1VqIQHtsiorPVIvZQLHKenkEraHiForNqVtm7/DXT+DJfO6
 Qp1mq84O4pUEPDwQgbwtnydNNVWF3cK6YKIeZZb3rFrH25pw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
correctly. Also, pipe_data_available() returns PDA_UNKNOWN rather
than 1 when the pipe space estimation fails so that select() and
raw_write() can perform appropriate fallback handling.

Addresses: https://github.com/git-for-windows/git/issues/5682
Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by default")
Reported-by: Vincent-Liem (@github), Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc        | 30 ++++++-----
 winsup/cygwin/local_includes/select.h |  3 ++
 winsup/cygwin/select.cc               | 77 ++++++++++++++-------------
 3 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index e35d523bb..7e2c1861b 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -491,14 +491,14 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
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
-		 In this case, the pipe is really full if WriteQuotaAvailable
-		 is zero. Otherwise, the pipe is empty. */
+		 In this case, WriteQuotaAvailable indicates real pipe space.
+		 Otherwise, the pipe is empty. */
 	      status = fh->set_pipe_non_blocking (true);
 	      if (NT_SUCCESS (status))
 		/* Pipe should be empty because reader is waiting for data. */
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
@@ -650,9 +655,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
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
@@ -660,12 +663,13 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	     in a very implementation-defined way we can't emulate, but it
 	     resembles it closely enough to get useful results. */
 	  avail = pipe_data_available (-1, this, get_handle (), PDA_WRITE);
-	  if (avail < 1)	/* error or pipe closed */
+	  if (avail == PDA_UNKNOWN && real_non_blocking_mode)
+	    avail = len1;
+	  else if (avail == 0 || !PDA_NOERROR (avail))
+	    /* error or pipe closed */
 	    break;
 	  if (avail > len1)	/* somebody read from the pipe */
 	    avail = len1;
-	  if (avail == 1)	/* 1 byte left or non-Cygwin pipe */
-	    len1 >>= 1;
 	  else if (avail >= PIPE_BUF)
 	    len1 = avail & ~(PIPE_BUF - 1);
 	  else
diff --git a/winsup/cygwin/local_includes/select.h b/winsup/cygwin/local_includes/select.h
index 43ceb1d7e..afc05e186 100644
--- a/winsup/cygwin/local_includes/select.h
+++ b/winsup/cygwin/local_includes/select.h
@@ -143,5 +143,8 @@ ssize_t pipe_data_available (int, fhandler_base *, HANDLE, int);
 
 #define PDA_READ	0x00
 #define PDA_WRITE	0x01
+#define PDA_ERROR	-1
+#define PDA_UNKNOWN	-2
+#define PDA_NOERROR(x)	(x >= 0)
 
 #endif /* _SELECT_H_ */
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index bb141b065..050221a9f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -601,7 +601,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
       if (mode == PDA_READ
 	  && PeekNamedPipe (h, NULL, 0, NULL, &nbytes_in_pipe, NULL))
 	return nbytes_in_pipe;
-      return -1;
+      return PDA_ERROR;
     }
 
   IO_STATUS_BLOCK iosb = {{0}, 0};
@@ -618,46 +618,49 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
 	 access on the write end.  */
       select_printf ("fd %d, %s, NtQueryInformationFile failed, status %y",
 		     fd, fh->get_name (), status);
-      return (mode == PDA_WRITE) ? 1 : -1;
+      return (mode == PDA_WRITE) ? PDA_UNKNOWN : PDA_ERROR;
     }
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
-      if (fh->get_device () == FH_PIPEW && fpli.WriteQuotaAvailable == 0)
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
-	    return 1;
+	    return PDA_UNKNOWN;
 	  /* Restore pipe mode to blocking mode */
 	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
 	  /* Empty */
@@ -681,7 +684,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
       return fpli.ReadDataAvailable;
     }
   if (fpli.NamedPipeState & FILE_PIPE_CLOSING_STATE)
-    return -1;
+    return PDA_ERROR;
   return 0;
 }
 
@@ -731,7 +734,7 @@ peek_pipe (select_record *s, bool from_select)
       if (n == 0 && fh->get_echo_handle ())
 	n = pipe_data_available (s->fd, fh, fh->get_echo_handle (), PDA_READ);
 
-      if (n < 0)
+      if (n == PDA_ERROR)
 	{
 	  select_printf ("read: %s, n %d", fh->get_name (), n);
 	  if (s->except_selected)
@@ -772,8 +775,8 @@ out:
 	}
       ssize_t n = pipe_data_available (s->fd, fh, h, PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
-      gotone += s->write_ready = (n > 0);
-      if (n < 0 && s->except_selected)
+      gotone += s->write_ready = (n > 0 || n == PDA_UNKNOWN);
+      if (n == PDA_ERROR && s->except_selected)
 	gotone += s->except_ready = true;
     }
   return gotone;
@@ -986,7 +989,7 @@ out:
       ssize_t n = pipe_data_available (s->fd, fh, fh->get_handle (), PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
       gotone += s->write_ready = (n > 0);
-      if (n < 0 && s->except_selected)
+      if (n == PDA_ERROR && s->except_selected)
 	gotone += s->except_ready = true;
     }
   return gotone;
@@ -1412,7 +1415,7 @@ out:
       ssize_t n = pipe_data_available (s->fd, fh, h, PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
       gotone += s->write_ready = (n > 0);
-      if (n < 0 && s->except_selected)
+      if (n == PDA_ERROR && s->except_selected)
 	gotone += s->except_ready = true;
     }
   return gotone;
-- 
2.45.1


Return-Path: <SRS0=IioG=OB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 950863899069
	for <cygwin-patches@cygwin.com>; Mon,  1 Jul 2024 08:46:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 950863899069
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 950863899069
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1719823605; cv=none;
	b=EQ8ME5vl0+kzR+Nrm6VOHfpjhQZ4Y2Tt7MLGxvYAq02cuc55H7qxOOUCgz/JkvM8lF+ViV3tvA/3hHH8tlEDJfK2sodwLg4KWgATukD4MGwvI23n7cbdB0zmW/eL3Vf+eMzZL9s4sdHplwHMaylllDxJra+GXjko0a31T13nTAI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1719823605; c=relaxed/simple;
	bh=WuILwsjAeHg3MpkeJaueNhjHhCVgVbBIljsEZ2032xc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=SKK7c910UARdAygNFwEyj1sEIHvlsg2g4h5GiAhyNtmiRjGA7wQo0vTTEbtNUOvgWnFmmvP7OxDENbAZ+lIYEkV8yP2Y7yO6YhQcgiabgIBox1tyB548KMe4gv/Qvh/EoiR1YlLk195fSOHZajdfP61GbRNb8BrnSAq0m44ws08=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20240701084641488.IYRO.13245.localhost.localdomain@nifty.com>;
          Mon, 1 Jul 2024 17:46:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	jojelino <jojelino@gmail.com>
Subject: [PATCH] Cygwin: pty: Avoid client deadlock when pty master stops to read.
Date: Mon,  1 Jul 2024 17:46:17 +0900
Message-ID: <20240701084627.1432-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1719823601;
 bh=Q1cQSCzCXIKt8AkNUuS98CrCWEiF0w9SniE6GZ481zM=;
 h=From:To:Cc:Subject:Date;
 b=m+L5fgSLHBZzvZxE4/BI8DamTzbizSfzqoosb5pIT1NlclXbKWzomJn+V4gqLLoeJxL588Tc
 0wReydhHH0YPkyYGuyRe4vdNXUCSuAnilfm9IF/4qiA6s8mUzTgy+lyq7UH9REXN87gfcvfY6F
 4vfj5Ra/necAhszzyuSrV56WLnvzz501tGvJCUT88VoxgQ5jxNv5Ki9hX67OTB1WTLanZiu01u
 WESr686Nnh+y0uOmqBqBBn60q3kRqofbtsMQgC07SJzbm6AqrW3W4ysyrdYOVtiYtiNDbGMU1m
 wZOi5FdtIRjyTLLego7siqcwUg/TmbjX5Iou1Z7gGrIeZ9Tg==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previsouly, the following commands hangs:
  mintty -e timeout 1 dash -c 'yes aaaaaaaaaaaaaaaaaaaaaaaaa | cat'

The mechanism is as follows.

When the child process (timeout) is terminated, mintty seems to stop
reading pty master even if yes or cat still alive.

If the the pipe used to transfer output from pty slave to pty master
is full due to lack of master reader, WriteFile() to the pipe is
blocked. WriteFile() cannot be canceled by cygwin signal, therefore,
pty slave hangs.

This patch avoids hanging by checking pipe space before calling
WriteFile() and prevents writing data more than space.

Addresses: https://cygwin.com/pipermail/cygwin/2024-June/256178.html
Reported-by: jojelino <jojelino@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 25 ++++++++++++++++++++++---
 winsup/cygwin/release/3.5.4   |  4 ++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 9d7ef3c9d..fa6bf1096 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3118,8 +3118,22 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr,
     return res; /* Discard write data */
   while (towrite)
     {
+      ssize_t space = towrite;
       if (!is_echo)
 	{
+	  IO_STATUS_BLOCK iosb = {{0}, 0};
+	  FILE_PIPE_LOCAL_INFORMATION fpli = {0};
+	  NTSTATUS status;
+
+	  status = NtQueryInformationFile (h, &iosb, &fpli, sizeof (fpli),
+					   FilePipeLocalInformation);
+	  if (!NT_SUCCESS (status))
+	    {
+	      if (towrite < len)
+		break;
+	      len = -1;
+	      return FALSE;
+	    }
 	  if (ttyp->output_stopped && is_nonblocking)
 	    {
 	      if (towrite < len)
@@ -3131,13 +3145,18 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr,
 		  return TRUE;
 		}
 	    }
-	  while (ttyp->output_stopped)
-	    cygwait (10);
+	  if (ttyp->output_stopped || fpli.WriteQuotaAvailable == 0)
+	    {
+	      cygwait (1);
+	      continue;
+	    }
+	  space = fpli.WriteQuotaAvailable;
 	}
 
       if (!(ttyp->ti.c_oflag & OPOST))	// raw output mode
 	{
 	  DWORD n = MIN (OUT_BUFFER_SIZE, towrite);
+	  n = MIN (n, space);
 	  res = WriteFile (h, ptr, n, &n, NULL);
 	  if (!res)
 	    break;
@@ -3150,7 +3169,7 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr,
 	  char *buf = (char *)ptr;
 	  DWORD n = 0;
 	  ssize_t rc = 0;
-	  while (n < OUT_BUFFER_SIZE && rc < towrite)
+	  while (n < OUT_BUFFER_SIZE && n < space && rc < towrite)
 	    {
 	      switch (buf[rc])
 		{
diff --git a/winsup/cygwin/release/3.5.4 b/winsup/cygwin/release/3.5.4
index 2a5f2b1bd..17db61146 100644
--- a/winsup/cygwin/release/3.5.4
+++ b/winsup/cygwin/release/3.5.4
@@ -15,3 +15,7 @@ Fixes:
 
 - Fix a problem that ldd command against cygwin DLLs sometimes hangs.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255991.html
+
+- Fix a problem that pty slave hangs on writing when pty master stops
+  to read.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-June/256178.html
-- 
2.45.1


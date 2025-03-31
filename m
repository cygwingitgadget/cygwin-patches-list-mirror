Return-Path: <SRS0=QGr+=WS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 13B7238560AB
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 13:27:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 13B7238560AB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 13B7238560AB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743427659; cv=none;
	b=Yg9JXD0kaiLZB0qpHuGX65nu5x0tV/9/DybJYAQ6Zo+UT/MXhaGVkiAxO1KhT8jdK77RkX4UzNKQCW9btMjImOJTvjjl5JtHYVIqqmbXemoOy1Y9H3wHpfqOVtgAre+HQ5Z/Wqz9o8agpGS7D5iLjy8tR3M91ZG7DhrbnvLp0+o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743427659; c=relaxed/simple;
	bh=jIIbbvW+ucstne156Nx9WATcYdMjOx03dwKZiB4i2uM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DkSOS+4YzBzNBXula4UxphWxYwNYayiKvNlpi6KToUr9E4jvhogFAYHczzJxtA5cOHgJ8cw7Qmq9nr+tFK5dRL+L6dIsQT2vSRojTB0fwUOxuoBRZTI7Ztq/DDA+PKAoqd9cvhF8zcZCz9RRQymRevmndOqWcvhjvH1KOvKjW14=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 13B7238560AB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=i28NkcOs
Received: from localhost.localdomain by mta-snd-e10.mail.nifty.com
          with ESMTP
          id <20250331132735032.RXCH.34837.localhost.localdomain@nifty.com>;
          Mon, 31 Mar 2025 22:27:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christoph Reiter <reiter.christoph@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Cygwin: pipe: Add workaround for native ninja
Date: Mon, 31 Mar 2025 22:27:11 +0900
Message-ID: <20250331132719.278-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743427655;
 bh=1OC54GDYJDioi4SytI6QSLzaIlXoldOU1/KVzlkzFS0=;
 h=From:To:Cc:Subject:Date;
 b=i28NkcOsf/It0F93NKmIlpictnFd6Q0lXkjXbelSJNA6yQiFckb4Ke4FeAaCyvWdzjOtFNCN
 P6fjpgH4DizJtEb4DLKS2ANk5wyHf3bCkTPqAjwoBHUpE3OXhjc9DElB4uBgqb+BaGywf1c+dM
 mjjmEhe7hbFXOlSlZXcl4KhXGLW43TctxTkvw2xboDZWtYduS88P2I9+DfuQ5Mlghrgc4Grk0m
 WoXV289xVtU48Jj7FNPNpXZSCJQbITCkFirkdasUlOp/j2IVR/jbHjFczH7kaRd64LvTdO0GRz
 fOokEcsvIUErvYZ9mxwxJ6TfKq42kde1lD4UCfNCe4suVkhA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Native (non-cygwin) ninja creates pipe with size == 0, and starts
cygwin process with that pipe. This causes infinite loop in the
fhandler_fifo_pipe::raw_write(). Ideally, the pipe implementation
in cygwin could work even with pipe size == 0, however, it seems
impossible due to:

(1) select() does not work for that pipe because PeekNamedPipe()
    always returns 0. Read side is ready to read only when the
    write side is about to write, but there is no way to know that.
(2) The cause of the problem:
    https://cygwin.com/pipermail/cygwin/2025-January/257143.html
    cannot be avoidable. To avoid CancelIo() problem, the patch
    https://cygwin.com/pipermail/cygwin-patches/2025q1/013451.html
    restricts the data size less than the current pipe space.
    However, if pipe size is zero this is impossible.

This patch adds just a workaround for native ninja that avoid
infinite loop in raw_write().

Addresses: https://github.com/msys2/msys2-runtime/issues/270
Reported-by: Christoph Reiter <reiter.christoph@gmail.com>
Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 5 +++++
 winsup/cygwin/select.cc        | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index ac8bbe7d6..e35d523bb 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -455,6 +455,11 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
   ssize_t avail = pipe_buf_size;
   bool real_non_blocking_mode = false;
 
+  /* Workaround for native ninja. Native ninja creates pipe with size == 0,
+     and starts cygwin process with that pipe. */
+  if (avail == 0)
+    avail = PIPE_BUF;
+
   if (pipe_mtx) /* pipe_mtx is NULL in the fifo case */
     {
       DWORD timeout = is_nonblocking () ? 0 : INFINITE;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 422c8e830..bb141b065 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -670,7 +670,9 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
 			   fpli.WriteQuotaAvailable);
 	  return fpli.WriteQuotaAvailable;
 	}
-      /* TODO: Buffer really full or non-Cygwin reader? */
+      return PIPE_BUF; /* Workaround for native ninja. Native ninja creates
+			  pipe with size == 0, and starts cygwin process
+			  with that pipe. */
     }
   else if (fpli.ReadDataAvailable)
     {
-- 
2.45.1


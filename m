Return-Path: <SRS0=IwXV=ZK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 0C3883858408
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 10:08:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0C3883858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0C3883858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751018935; cv=none;
	b=FB8QlrJJymBoHKaMjJ48doZNuLR7HVijoWoT5ZpTgZxoIbWGgj1IyBRCclf1mkF9RBhL1RXwMD60MsSsJKVPq0rVEujpkNf36srjvtj88pihiTBFDJyEstjTuu9UITsEuSNye84xLCvJ7oIV5GcSO9Zl8KsxvqL06YHBlAG3wMo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751018935; c=relaxed/simple;
	bh=ED2MDl05RqCzRDy9PISMeualG8tLrDT51duy6dfE1p0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ClhLXG2cMdw9BFNnG0h8alBeJFMaBCFXKZLPBy+4JIOUoosoF2mVOZWqadOXNjsdknSHUBUuJ2qO4bceznN99qlfvHvDvRb67vkzCPRQj2khbzq3PZ3tT7aMXgJE8FdDk0port55ooFMvJqn598gfWF1LDrzUzkVW+Ol7KWbbqc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0C3883858408
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fGp4wENf
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250627100853292.SMSY.47226.localhost.localdomain@nifty.com>;
          Fri, 27 Jun 2025 19:08:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pipe: Simplify raw_write() a bit (Drop using chunk)
Date: Fri, 27 Jun 2025 19:08:23 +0900
Message-ID: <20250627100835.442-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751018933;
 bh=AVFU/SIzF8K7Q/y0b+RbFJEsfopfQDsk0kX+toMwjmo=;
 h=From:To:Cc:Subject:Date;
 b=fGp4wENfwtlpS6KQHRcMCmyUhJ9oeV7Rsa0tUR6KoH4EcV7EypzcH7ZCYcy+byPt45OHs0Ak
 3yraiUpTGrJfZugEJnglP6PI6PJ5jX9vU5DNt0frwEZPeXbWoo0EsBnh78a5ISRmNFKKZKvtfE
 T9WiYNAajEH8FYhen0KxnmtsTwh/j2D2hj4haMA2sEiJxmDINJc+cUdSGc/efWZnS/GUXCp2E5
 arrI1dPzcLpY8kTby9xZW30yQap3bASdPw3a/ZeFNYJnXW1wm2qOljPg4sI8TbDrWDNRvf6HCs
 +6OWBRw4qWt3xjlrQWRrk64GBdpUxoaLqWoaNuiW8B6t4f6w==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

There are tree variables for similar purpose in raw_write(), avail,
chunk, and len1. avail is the amount of writable space in the pipe.
len1 is the data length to attempt to NtWriteFile(). And chunk is
intermediate value to calculate len1 from avail which holds
min(avail, len). Here, chunk has no clear role among them. In fact,
it appears to obscure the intent of the code for the reader.

This patch removes the use of chunk and obtains len1 directly from
avail.

Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 3a0f8bfe9..1a8c39c5b 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -442,7 +442,6 @@ ssize_t
 fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 {
   size_t nbytes = 0;
-  ULONG chunk;
   NTSTATUS status = STATUS_SUCCESS;
   IO_STATUS_BLOCK io;
   HANDLE evt;
@@ -543,11 +542,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	}
     }
 
-  if (len <= (size_t) avail)
-    chunk = len;
-  else
-    chunk = avail;
-
   if (!(evt = CreateEvent (NULL, false, false, NULL)))
     {
       __seterrno ();
@@ -564,8 +558,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       ULONG len1;
       DWORD waitret = WAIT_OBJECT_0;
 
-      if (left > chunk && !is_nonblocking ())
-	len1 = chunk;
+      if (left > (size_t) avail && !is_nonblocking ())
+	len1 = (ULONG) avail;
       else
 	len1 = (ULONG) left;
 
-- 
2.45.1


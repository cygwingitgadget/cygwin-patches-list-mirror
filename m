Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id A567A3858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 11:34:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A567A3858039
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A567A3858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750851263; cv=none;
	b=uQY4MdZzXzmlRU4kDCRhBBIICx6WkYY959+2/WPzYbIp5qWsrX6xxOZwIhEF8c7dYkilFn9ytFYyKHTyLpq2JbV0XmNLOSb257rONFLsEbx3hmI5VqEv0nV3xU1BO5PqmOopo3ntP/GCW/Lk9ynWshQ+EAB5jH3sYJijL87cLLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750851263; c=relaxed/simple;
	bh=9rhCn0RAMC1taOFc3jKbWtWv5M4k5MDoBA0uodrdiIs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=bsa2LY8uaVTi/cIfOdZTg+69q8lDwmQsTN1D9w3gP0c09RdeVpLtMQameCeFWLab29kCUNYMW811DWJ5TpTpvhGpbUL9zY/LYlDvaTxwg9ULFmmfCQmnZhcYZGkh1U32yaySv+13S2fdf1JAaYt3Lv+ZsKabcNaQPPMz2Kc1/7w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A567A3858039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kpk4AlrY
Received: from localhost.localdomain by mta-snd-e04.mail.nifty.com
          with ESMTP
          id <20250625113420613.RXFC.90539.localhost.localdomain@nifty.com>;
          Wed, 25 Jun 2025 20:34:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pipe: Simplify raw_write() a bit (stop to use chunk)
Date: Wed, 25 Jun 2025 20:33:57 +0900
Message-ID: <20250625113405.814-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750851260;
 bh=JWDxo2xAYrKCL9UNoCHi7jI/V0USfpfWueOORMw+oVQ=;
 h=From:To:Cc:Subject:Date;
 b=kpk4AlrYnl6JBhT+vWK55Af1RRJ3824juuNMwm77v8vCRS+PJKOobNT561OwuLtuZe7swW+a
 pxQQibyaBHuH0//WrOb3aZGZcDQcmRlEftNXAPSrs7OxKIpOJQzlJ6rGe811eexSzz5pLNmFmA
 jEa/xgeIkiP1f4GwoOfBb0JdqHZdWvh1BpA+wXvCLIsIWt9mWkpt8wtPTURe7EpewNYA+SuMSv
 fqnG8gWQ4J2q6R9p3GuC/pTob0RjvgzM/sjTsm2W5nSmFe8st4z1ygeN6BrGC2mdM0K/Z6B/m2
 5hYMZHJ2G+zUJv4DX+w6eKUzE0UnJ7B29dnv/GAL88mPHaXA==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index e35d523bb..a80a837f9 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -443,7 +443,6 @@ ssize_t
 fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 {
   size_t nbytes = 0;
-  ULONG chunk;
   NTSTATUS status = STATUS_SUCCESS;
   IO_STATUS_BLOCK io;
   HANDLE evt;
@@ -540,11 +539,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
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
@@ -557,14 +551,14 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
   while (nbytes < len)
     {
       ULONG_PTR nbytes_now = 0;
-      size_t left = len - nbytes;
       ULONG len1;
+      size_t left = len - nbytes;
       DWORD waitret = WAIT_OBJECT_0;
 
-      if (left > chunk && !is_nonblocking ())
-	len1 = chunk;
-      else
+      if (left < (size_t) avail || is_nonblocking ())
 	len1 = (ULONG) left;
+      else
+	len1 = (ULONG) avail;
 
       /* NtWriteFile returns success with # of bytes written == 0 if writing
          on a non-blocking pipe fails because the pipe buffer doesn't have
-- 
2.45.1


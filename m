Return-Path: <SRS0=iDEB=TF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 07C603858C3A
	for <cygwin-patches@cygwin.com>; Thu, 12 Dec 2024 08:32:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 07C603858C3A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 07C603858C3A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733992360; cv=none;
	b=HPm4saqWTk15NjMEX7XnlD/HLadaTtg6YNAQXx3etZOR8ceP5D0ib7MdS8eCgNSGdeXMzDjopLks51cF5/71XaT5LjJkx6D7u56L3MfGBwB+zvp63evvblxiYyusAX8wiCI0U7vPU7Ea/AgufUwaAZwPj61DsAOVWLu8hHHnako=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733992360; c=relaxed/simple;
	bh=5TdzXa1dHlc1gwunioVbyXxniqiBChIxFsSfEwRmV38=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Hl8fCptvwuSLQiOYh9CqPNPpceWIJrx2VnHj+e9RjI89tY/VSDifNiunknPxmiNCuMJ2jzf0JcnBa8VfciZeWKz9pdHZFtyULakYDKl5d915rlmoV7CjX/aAW/mYbg4G42wrmxEvQlh+odckSAeXJT7Ca7Mrct5Sfcw4LDBSAGw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 07C603858C3A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gmExwejt
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20241212083238249.KQJR.115271.localhost.localdomain@nifty.com>;
          Thu, 12 Dec 2024 17:32:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	=?UTF-8?q?=E5=87=AF=E5=A4=8F?= <walkerxk@gmail.com>
Subject: [PATCH] Cygwin: signal: Fix high load when retrying to process pending signal
Date: Thu, 12 Dec 2024 17:32:14 +0900
Message-ID: <20241212083223.1891-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733992358;
 bh=ZwxABYsmUKmT17rLfRotuqEpSmROXE1g16+jbhenRJs=;
 h=From:To:Cc:Subject:Date;
 b=gmExwejtzZndt6AEPFJwCJufNjHHip8jC2vnTULKjqbCdvVDMoC9rz4j+A7YAhVezWN7j/cX
 o4BowXn4jGbS3T+TH8lZHrPIYrLR1noSNyMDOFymIQSVnb1m0QrnodQsVAlR7tUrS+RSzNlOiA
 NQC7wnekNi0SvFwGWBVWGMsDHRqp+hBSbadUlA8MrkjaDdzbZodWY1JkvMLAZritxiS/UfgYLK
 JbIe8hFLHN+QXUeZmhw3q+w4XyvGFYrHlm3bpjTU0Qhd0pKET6cbxlmHUPy5dmLUt+kybb19wq
 jA0/L4SL9WG5b0aMKKAYUS6v/oBUvvWUc0GYm2yakypbBECw==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit e10f822a2b39 has a problem that CPU load gets high if
pending signal is not processed successfully for a long time.
With this patch, wait_sig() calls Sleep(1), rather than yield(),
if the pending signal has not been processed successfully for a
predetermined time to prevent CPU from high load.

Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256884.html
Fixes: e10f822a2b39 ("Cygwin: signal: Handle queued signal without explicit __SIGFLUSH")
Reported-by: 凯夏 <walkerxk@gmail.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 59b4208a6..e01a67ebe 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1345,6 +1345,12 @@ wait_sig (VOID *)
 
   hntdll = GetModuleHandle ("ntdll.dll");
 
+  /* GetTickCount() here is enough because GetTickCount() - t0 does
+     not overflow until 49 days psss. Even if GetTickCount() overflows,
+     GetTickCount() - t0 returns correct value, since underflow in
+     unsigned wraps correctly. Pending a signal for more thtn 49
+     days would be noncense. */
+  DWORD t0 = GetTickCount ();
   for (;;)
     {
       DWORD nb;
@@ -1354,7 +1360,10 @@ wait_sig (VOID *)
       else if (sigq.start.next
 	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
 	{
-	  yield ();
+	  if (GetTickCount () - t0 > 10)
+	    Sleep (1);
+	  else
+	    yield ();
 	  pack.si.si_signo = __SIGFLUSH;
 	}
       else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
@@ -1364,6 +1373,8 @@ wait_sig (VOID *)
 	  system_printf ("garbled signal pipe data nb %u, sig %d", nb, pack.si.si_signo);
 	  continue;
 	}
+      if (pack.si.si_signo != __SIGFLUSH)
+	t0 = GetTickCount ();
 
       sigq.retry = false;
       /* Don't process signals when we start exiting */
-- 
2.45.1


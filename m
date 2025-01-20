Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id E46253858417
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 17:48:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E46253858417
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E46253858417
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737395330; cv=none;
	b=MBaF1N/AlFGCvPkuGqPpUvbkMRehCiFZ+QEuDFxYpdk2sBqhHW6v9wcf7Uz9xNZVP2MDix1GKUn42O9jVfHUeKBcUYWaseACS66dK8zOykp11k8QLv4u8kpbMSp/xYTtD2mGA5htFDW8iY5R2jZkqkdoR9mK05zHAsetcqp0CI4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737395330; c=relaxed/simple;
	bh=c8ToQzqwxEDDOn3BS4wwADXKOTvrJUVgD5JYG47hLyg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=OS6UKnTXsm658jxx0VIX6FSM5PQgv36YiHPHJ0oWhMUrpVc2fW08SpbyOcFXmxrfDF1N7Kfp6E4UToGShG8oV1M/RGM5ABRHOoPsZhziviPCbKAXSum5jl1rdloG5GZvMxIp0QGFskJa+sBXZrA2trRL1hbEX33eMlSGG/JxMNI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E46253858417
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=l/B9miiD
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250120174848283.TQAC.87244.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 02:48:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 1/3] Revert "Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent"
Date: Tue, 21 Jan 2025 02:47:55 +0900
Message-ID: <20250120174811.43043-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250120174811.43043-1-takashi.yano@nifty.ne.jp>
References: <20250120174811.43043-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737395328;
 bh=GeQQt0ATfyF2BPVIaxW/Y7sL063hHAMelrUPEMxPnwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l/B9miiD5AHHha3ZQSGqAmFiJFYHLYsrrjQJdQo6D3stZfuhyy5dfxN+RRNMfI93G6JqmNNP
 U5Cka29c+BJBRyvctX1Mc024GzgcbvsXSmOb3CP8bm8kAKlXTlIRAznQvZhA0hxtbhv9IQCrNk
 8oUS9y9MHTxHxbA3pN0Z5E29M2zo1A9pviR2fYMp1N69jxfU7FyfrDL1gmRXP9NVEY3NhidOmV
 ECwKhkp9BDKPbSm4hcrfKLGFO9xjNc/q2vSj0SgH2a+1skB979rRkd5kx+ZzTNp9RBGigiLJzI
 kZF2op6fNFCWPpSaXdTi5y9qTKMTXqY+msaNckPLxhVWvvFA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This reverts commit a22a0ad7c4f0 to apply a new patch for the same
purpose.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/release/3.5.6 |  3 ---
 winsup/cygwin/sigproc.cc    | 20 +++++---------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/release/3.5.6 b/winsup/cygwin/release/3.5.6
index 0fff0de40..d17a6af53 100644
--- a/winsup/cygwin/release/3.5.6
+++ b/winsup/cygwin/release/3.5.6
@@ -7,6 +7,3 @@ Fixes:
 
 - Fix a regression since 3.5.0 which fails to use POSIX semantics in
   unlink/rename on NTFS.
-
-- Fix zsh hang at startup.
-  Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256954.html
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 35ec3e70e..ba7818a68 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -751,14 +751,10 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       res = WriteFile (sendsig, leader, packsize, &nb, NULL);
       if (!res || packsize == nb)
 	break;
-      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED
-	  && pack.si.si_signo != __SIGFLUSHFAST)
+      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
 	_my_tls.call_signal_handler ();
       res = 0;
     }
-  /* Re-assert signal_arrived which has been cleared in cygwait(). */
-  if (_my_tls.current_sig)
-    _my_tls.set_signal_arrived ();
 
   if (!res)
     {
@@ -789,16 +785,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   if (wait_for_completion)
     {
       sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
-      do
-	{
-	  rc = cygwait (pack.wakeup, WSSC, cw_sig_eintr);
-	  if (rc == WAIT_SIGNALED && pack.si.si_signo != __SIGFLUSHFAST)
-	    _my_tls.call_signal_handler ();
-	}
-      while (rc != WAIT_OBJECT_0 && rc != WAIT_TIMEOUT);
-      /* Re-assert signal_arrived which has been cleared in cygwait(). */
-      if (_my_tls.current_sig)
-	_my_tls.set_signal_arrived ();
+      rc = cygwait (pack.wakeup, WSSC);
       ForceCloseHandle (pack.wakeup);
     }
   else
@@ -819,6 +806,9 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       rc = -1;
     }
 
+  if (wait_for_completion && si.si_signo != __SIGFLUSHFAST)
+    _my_tls.call_signal_handler ();
+
 out:
   if (communing && rc)
     {
-- 
2.45.1


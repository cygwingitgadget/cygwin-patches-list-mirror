Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e01.mail.nifty.com (mta-sp-e01.mail.nifty.com [106.153.228.1])
	by sourceware.org (Postfix) with ESMTPS id 888EF3858027
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 15:47:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 888EF3858027
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 888EF3858027
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.1
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737388034; cv=none;
	b=ROviCXi870Adtdy0EhR/MZj8wtl9kkdVbfCU1Oi4QoPhUmrruxi/eVaUmD8UHOhjXJ0L/gRxounzUqZMMYCIa+ScfnGrBIf63vgepXrthn3f/SsIWyUapvRiEKPFMVcHxcmzwGTIS3cMImKlLTOxLIR8ANRKp4AxFOFuSMpcDlU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737388034; c=relaxed/simple;
	bh=hFMByDwpCUzQT+1+NYW8sP1O5BC8eNPRkQr+mjes3yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=bFbLB886iWBaVY2sBEIY6j+NVWMObp5ChyF3cbuHdX1/G/g8gsU9dCf6hUfymt2vUddMLGVE24eLc2eyRbFR163LV/oQle5s/vQP9v+X9CzvDCvpG2N6rWBZKy+AKKgxXH4qx4oGZH8xWM1W259POIuWx0g92E3SSPCc3A/5bN0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 888EF3858027
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TB1PFO1W
Received: from mta-snd-e01.mail.nifty.com by mta-sp-e01.mail.nifty.com
          with ESMTP
          id <20250120154712056.EGRP.6592.mta-snd-e01.mail.nifty.com@nifty.com>;
          Tue, 21 Jan 2025 00:47:12 +0900
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250120154711991.IUHQ.9629.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 00:47:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Daisuke Fujimura <booleanlabel@gmail.com>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH v4 3/3] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent
Date: Tue, 21 Jan 2025 00:44:21 +0900
Message-ID: <20250120154627.107642-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250120154627.107642-1-takashi.yano@nifty.ne.jp>
References: <20250120154627.107642-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737388032;
 bh=sqqj165yx5P8ENMCJJHVS1rbCuldK1GfBJhQX4Bs2m4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TB1PFO1WDfBDFFTFnWhJgoARIaytH7nRTWnLViVLboAT7ywYrA0PH4cu6VFmqng2+2z/f5he
 b6LzdMI3DSGzQESFkvq8dSd171+D7j9hfiIQ9tBTM2l6ACQLqFeYmABovqg8kKlP3TknSIEMQg
 cd0qg9esslC/HnWyCVPpsP/e8PwHxejqNGxB0/sLl1TG3Ow78grI0LQbT1rGRfEE7MUg/RqLuL
 U3WNvpUY2BlkdNx2Ua0LQEMGPqU201jVDgnNZ5yrN45mMh0VZ/Ufeowr9rq/of276qpvuiBQiz
 t+u/r0CFtc9CjTV7Ezo/PCOW3QqptiUPAzyX5N6kAcxrIVng==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit a22a0ad7c4f0 was not exactly the correct thing. Even with
the patch, some hangs still happen. This patch overrides the previous
commit togerther with the patch making cygwait() reentrant to fix these
hangs.

Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256954.html
Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256987.html
Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
Fixes: a22a0ad7c4f0 ("Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent")
Reported-by: Daisuke Fujimura <booleanlabel@gmail.com>
Reported-by: Jeremy Drake <cygwin@jdrake.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index ba7818a68..408784e5d 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -742,6 +742,12 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       memcpy (p, si._si_commune._si_str, n); p += n;
     }
 
+  unsigned cw_mask;
+  if (pack.si.si_signo == __SIGFLUSHFAST)
+    cw_mask = 0;
+  else
+    cw_mask = cw_sig_restart;
+
   DWORD nb;
   BOOL res;
   /* Try multiple times to send if packsize != nb since that probably
@@ -751,8 +757,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       res = WriteFile (sendsig, leader, packsize, &nb, NULL);
       if (!res || packsize == nb)
 	break;
-      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
-	_my_tls.call_signal_handler ();
+      cygwait (NULL, 10, cw_mask);
       res = 0;
     }
 
@@ -785,7 +790,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   if (wait_for_completion)
     {
       sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
-      rc = cygwait (pack.wakeup, WSSC);
+      rc = cygwait (pack.wakeup, WSSC, cw_mask);
       ForceCloseHandle (pack.wakeup);
     }
   else
@@ -806,9 +811,6 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       rc = -1;
     }
 
-  if (wait_for_completion && si.si_signo != __SIGFLUSHFAST)
-    _my_tls.call_signal_handler ();
-
 out:
   if (communing && rc)
     {
-- 
2.45.1


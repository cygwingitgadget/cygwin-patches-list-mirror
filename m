Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e01.mail.nifty.com (mta-sp-e01.mail.nifty.com [106.153.228.1])
	by sourceware.org (Postfix) with ESMTPS id 2881A3858C2B
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 17:49:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2881A3858C2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2881A3858C2B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.1
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737395346; cv=none;
	b=HYJ3I3snNnwN+NIkmFhRmsTeDJZmB1wCQuNeB7oKXtsHXIukoPGsuwydmEBNFErHQp0x4efHiy0ngc5EaI+1Om3MEE9JzJFyzrw9Ye4ROQbX+Ri4K4/4EehBCQF0k88OK/ByURZ/Zk4/V7B3Mph+i5lbREls/9HTkJhn5tEmqSM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737395346; c=relaxed/simple;
	bh=hFMByDwpCUzQT+1+NYW8sP1O5BC8eNPRkQr+mjes3yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=I7z6WRQJsglxRKb4MkK6jle2+iBZg52ytXKZxY8VPd+s4uyf4cLx8afawGbXtVhKCQnwW7NLKteIfA6ZqW8hDfbNXZwKddcOB/OkE9yMAkZBXKHVrR07obVP2v+M3vQR6GN4K33ikweLei1EJzOBGRgdsq4qeyJcPcDP/9Ci+ec=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2881A3858C2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Q/YF7/Hh
Received: from mta-snd-e01.mail.nifty.com by mta-sp-e01.mail.nifty.com
          with ESMTP
          id <20250120174904646.EVJA.71597.mta-snd-e01.mail.nifty.com@nifty.com>;
          Tue, 21 Jan 2025 02:49:04 +0900
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250120174904573.TQAN.87244.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 02:49:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Daisuke Fujimura <booleanlabel@gmail.com>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH v5 3/3] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent
Date: Tue, 21 Jan 2025 02:47:57 +0900
Message-ID: <20250120174811.43043-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250120174811.43043-1-takashi.yano@nifty.ne.jp>
References: <20250120174811.43043-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737395344;
 bh=sqqj165yx5P8ENMCJJHVS1rbCuldK1GfBJhQX4Bs2m4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q/YF7/Hh7H7NQul2hv1FqfkkmUSfVNE/4k/EmLqh8TwhKiCO3p5bXQffGwuDEqZfUouA/zg/
 I8zB7S0fUvMX2k+GVddCMx1Xugb9f6XeEMIi1LZoygOImBvRyn/rD+J+6G7cI/qPRBxAMi18VQ
 alL8CsGK2yb4Xn+FPbiKBTfhx/4bWMpswvOy2oL7UyJhR5TfrvxlvjPFR4hWe1xp910E0+tEYN
 TuNRmxb1q31BPUhZystYbAY9Bm1EWJZ6RmiQXsc36RmNlMj43bSi1yT2+VS5JZRc9TzaGqx+U1
 iRUpJgGLBgpPd49eAJ3avh4ujLUbrP9qBP0/1KOjmhjgv2KQ==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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


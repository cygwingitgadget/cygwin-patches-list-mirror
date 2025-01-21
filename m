Return-Path: <SRS0=jwxA=UN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e02.mail.nifty.com (mta-sp-e02.mail.nifty.com [106.153.228.2])
	by sourceware.org (Postfix) with ESMTPS id 90B5E3858D38
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 03:16:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 90B5E3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 90B5E3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.2
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737429394; cv=none;
	b=BtxTDOF1iB45085Payty7vIqwblkeXeIgeHZpckSwU7Qtr76mL3ACmR4t+4jj+qRHBRnnHoTDOJv/FK6OewmXIEXJiM+MmcKooqxFq5Q8vGAdWS+GzTXOTxO5DfXpxib8FtqwGu7iQjCSLGsFM2aCxdLg43tiXOS4Bi/eps6ks8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737429394; c=relaxed/simple;
	bh=uw/X9eoTJbwav57J8VXqBp7rclxAS5RjUg0rsh1yNGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=VQgwzWQa8iEP0q10TlDVftDI7DgoaoOFXzRjbC9uDqLWBFFutaoivJ9oTtLH50Ac2X6kVWCAQV5g+4puak0Xl0aSBP11Y/F7sqEDVtGSGC7d6lr5AdImQa+GHxk7RFoQHkCf0kz5Zx3N8y/0+iD13yjEvyV8IKVJOy3+9kI/Kpw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 90B5E3858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MEYa/hTJ
Received: from mta-snd-e02.mail.nifty.com by mta-sp-e02.mail.nifty.com
          with ESMTP
          id <20250121031631835.DGJA.34279.mta-snd-e02.mail.nifty.com@nifty.com>;
          Tue, 21 Jan 2025 12:16:31 +0900
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20250121031631759.PDVJ.44461.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 12:16:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Daisuke Fujimura <booleanlabel@gmail.com>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH v6 3/3] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent
Date: Tue, 21 Jan 2025 12:15:35 +0900
Message-ID: <20250121031544.1716992-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
References: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737429391;
 bh=+1EJezjJllhW+7wcKyAvia64p5EhB7vEJhczURVpZiY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MEYa/hTJcLl52HLJvT6YFyb/dHHdfQUx0aYRyXB857IxNS+tIZItfCl7/7mNFjVmRaLh9kLo
 pJtI2uudu14768vROjZyAlr/36Oe45718yF4y34GgZK23iRy3R9qlyDRXwcZvekZV+R0/bP+RZ
 w1FMNgHIDGzCfnxeLwJLpzo0LuXkiKmENDDGNJxHn1hvMRTfrCq+CtGANK/XiUCw5APaKIJUKq
 ZJO8ierRecQXa7i07HBv18wE2sTx7/tlpentGI1FrkdIW7dFZ598SUx5QmTOE3KNec5/xiqv3K
 25ekIqlFw9DrETrbDUMI9ZJwlla9PV3FIxt4vfIkzDeyYrLg==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit a22a0ad7c4f0 was not entirely correct. Even with the patch,
some hangs still occur. This patch overrides the previous commit along
with the patch that makes cygwait() reentrant, to fix these hangs.

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


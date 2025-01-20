Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id E0C673858289
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 08:53:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E0C673858289
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E0C673858289
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737363206; cv=none;
	b=yDZ7r2nnoEPbvy6GmK+EpxpqzCsGxTMRaoZkv/kk+CDN3e170b5thBfvfYz4Ufh24VsIi5dhxT3EO2/IJEuDYqjmCW7NX20c1QYdlIyph++LULajBnIp4WHMVtJFwCms2Nu3PAUEzrWLgjrtdAHLoIOKofSUZNrhKbAPsicv75U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737363206; c=relaxed/simple;
	bh=EeJIGef77YanXBgS2P7txZD27ldFPKH0SHNarAYr6zw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Ej8/JCe6+aM82ETtmEyb5k9v0aqrExyJ3pSQ3La+DWYVlLF43nBCcPNVWaKZaB35P0RgJB83fUPKc9xuAYt7LgI/dZvpIR+oAgNRTVhZqaZGO9Lbml7vo7EOMPpvIC3vGf6VtAGp8VxaJI3YEH1pbvqrKaMyedYN20RKFbGxzPU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E0C673858289
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Kc+KOfFX
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20250120085324307.RKRH.67122.localhost.localdomain@nifty.com>;
          Mon, 20 Jan 2025 17:53:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Daisuke Fujimura <booleanlabel@gmail.com>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH v3 2/2] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent
Date: Mon, 20 Jan 2025 17:52:36 +0900
Message-ID: <20250120085249.1242380-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250120085249.1242380-1-takashi.yano@nifty.ne.jp>
References: <20250120085249.1242380-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737363204;
 bh=o4tZRenRnNnO/Sl7oR++DAMGNCNbEptuwmdt0Avz42U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kc+KOfFXV/ArrWxa+JSlFOqj5lwN2qyBu92BcUXvaj3WaAk5ZMmlep9JAsmBvEtUSQ3uAwQC
 Ne1At3AWdzW7BlxiKvffnWAmy71bRM1fkGvUWjTWONvmads87t2QFKtIhTaSojdZDUkAF6CF9+
 uIzrLYBaPeBl0hI0b88EU6wjO0UZoqN4uKx2XfZ7N7are0DG/WsB+F24oneDCjCiW7PTcdo7bU
 /oODiJpQhF82Xc2tEyM9BUXkTRTLEReoCUGwyK0Kn6HbRqAk9S5wrvevWmwfUcD5pZTY50L3r5
 2dKWtdukl7aN4BQikaJC5dpOylK9sbDiV/71TAP4qrRAwFdQ==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit a22a0ad7c4f0 was not exactly the correct thing. Even with
the patch, some hangs still happen. This patch overrides the previous
commit to fix these hangs.

Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256954.html
Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256987.html
Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
Fixes: a22a0ad7c4f0 ("Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent")
Reported-by: Daisuke Fujimura <booleanlabel@gmail.com>
Reported-by: Jeremy Drake <cygwin@jdrake.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index ba7818a68..4dcdd94de 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -751,8 +751,19 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       res = WriteFile (sendsig, leader, packsize, &nb, NULL);
       if (!res || packsize == nb)
 	break;
-      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
-	_my_tls.call_signal_handler ();
+      if (pack.si.si_signo == __SIGFLUSHFAST)
+	Sleep (10);
+      else /* Handle signals */
+	do
+	  {
+	    DWORD rc = WaitForSingleObject (_my_tls.get_signal_arrived (), 10);
+	    if (rc == WAIT_OBJECT_0)
+	      {
+		_my_tls.call_signal_handler ();
+		continue;
+	      }
+	  }
+	while (false);
       res = 0;
     }
 
@@ -785,7 +796,20 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   if (wait_for_completion)
     {
       sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
-      rc = cygwait (pack.wakeup, WSSC);
+      if (pack.si.si_signo == __SIGFLUSHFAST)
+	rc = WaitForSingleObject (pack.wakeup, WSSC);
+      else /* Handle signals */
+	do
+	  {
+	    HANDLE w[2] = {pack.wakeup, _my_tls.get_signal_arrived ()};
+	    rc = WaitForMultipleObjects (2, w, FALSE, WSSC);
+	    if (rc == WAIT_OBJECT_0 + 1) /* signal arrived */
+	      {
+		_my_tls.call_signal_handler ();
+		continue;
+	      }
+	  }
+	while (false);
       ForceCloseHandle (pack.wakeup);
     }
   else
@@ -806,9 +830,6 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
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


Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 3C1C3385840F
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 12:17:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3C1C3385840F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3C1C3385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732537020; cv=none;
	b=jDQJ/mL9HyjVkHRCkhvUMFumZQG7EtiLcK9aJwLAlkUxhNuOBlyfUZ4tRNCNZw017eTMwJBe9JzlxIMZaybFykfokw9bXVAR7BycKXI5Uq3PCYifs9fx0FWVqJPEDaXkMGnJVbFhAxgQZN1lN86WnVBESlPZtyDCp5X2LxERBiY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732537020; c=relaxed/simple;
	bh=V9ih2V0BWYzm5+j+Pjaih6LZSHgE06Zdesqiq2G6ouw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DD4Q6yX+3w5hIBCj2shP5QlgCnReApY7dyPOHcuKGw3ypJq6Q2NZcAfbqJo9fPK9an44FONsEJiFJN61ikGhifoIglP0TDWj6MuXjjhHg3Wuq9g+t/Znpq0rySHqct2oLwZNDZyul8Jt4hLk2bH+7bHAiITKslsrKABh+mazvo0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3C1C3385840F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lvaYdXwV
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241125121658623.KEKE.47547.localhost.localdomain@nifty.com>;
          Mon, 25 Nov 2024 21:16:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 1/6] Cygwin: signal: Fix deadlock between main thread and sig thread
Date: Mon, 25 Nov 2024 21:16:17 +0900
Message-ID: <20241125121632.1822-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
References: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732537018;
 bh=bJgCPNY4IVnSnCVncx0eAGHoEYLENU1gd7mXhfVZZps=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lvaYdXwVVKIuWWxz/Trzzh6OgfWC8hlG68K2XU85aAwFVTGvrkdzrFDZNS0ujD1/JvLJ9gG/
 /QHQQ6g8ZoLsbqozOt5dt142dIuUxrJyYBFkJqwUhnHZkyFNasoIoGNDjxlWfcaY4U81Ae4wkp
 8WX8Q5M6zj5MTO5cP0vGfsXFapNN1ZkW24+e6Erx5q46rig2iQ7FKN2AB+cb4tB5/bNZkD8oeA
 9zprl68DmDnIsVy7Z5O7TCckIztOzcMVY3CX3hNQ5hjCAtBZb+UcgN6cIdPCZFm1WANoMBiKff
 RDDH2BJHrIO8emiZeh6mG+Tz+0geHNTkeP0pvB7sk59qO00A==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, a deadlock happened if many SIGSTOP/SIGCONT signals were
received rapidly. If the main thread sends __SIGFLUSH at the timing
when SIGSTOP is handled by sig thread, but not is handled by main
thread yet (sig_handle_tty_stop() not called yet), and if SIGCONT is
received, the sig thread waits for cygtls::current_sig (is SIGSTOP now)
cleared. However, the main thread waits the pack.wakeup using
WaitForSingleObject(), so the main thread cannot handle SIGSTOP. This
is the mechanism of the deadlock. This patch uses cygwait() instead of
WaitForSingleObject() to be able to handle the pending SIGSTOP.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 7759daa979c4 ("(sig_send): Fill out sigpacket structure to send to signal thread rather than racily sending separate packets.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 9e20ae6f7..66ffef8f1 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -764,7 +764,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   if (wait_for_completion)
     {
       sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
-      rc = WaitForSingleObject (pack.wakeup, WSSC);
+      rc = cygwait (pack.wakeup, WSSC);
       ForceCloseHandle (pack.wakeup);
     }
   else
-- 
2.45.1


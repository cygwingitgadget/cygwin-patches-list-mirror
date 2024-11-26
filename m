Return-Path: <SRS0=EpSC=SV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 1A120385781A
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 08:55:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1A120385781A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1A120385781A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732611357; cv=none;
	b=xVx86DYP2pNbjosdC6qKON3PRWDGypRcUvX8/4b28nhXtA5H4V/UJ/uneB3kIivrQD3s3DajHATi9FDAGK7uE/73da/LvMYDJk2vP2cksEOCzH4KhsHCYyZP5OPrtlYUY51nXaWUQD9OcXoUlCwHyaNBCXQBjMV80Nh4UScHKRw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732611357; c=relaxed/simple;
	bh=6N17P6X1C0s104FebgV8nxJPFJxbs5M5UMVyC7MLU4s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=E/RO6ijrjewEb0+YYQ4DTu8vfuiyz1dWmnIiZ9dL9Ft9gt3R10WFV5JHYlcOtFJg5cksspLZ7AMqo6dDHz7RvH3KgeImLQVTM+WVFJJevQ8vcO/joEuzvvCqdnhCKRQGNxgZPkDsDOZUoeKb7YxxX8IZ/+rMwcCiJBxPhy4JEOA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1A120385781A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Y6oho66l
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241126085555431.NQVJ.90249.localhost.localdomain@nifty.com>;
          Tue, 26 Nov 2024 17:55:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2 1/7] Cygwin: signal: Fix deadlock between main thread and sig thread
Date: Tue, 26 Nov 2024 17:54:58 +0900
Message-ID: <20241126085521.49604-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732611355;
 bh=3kci3DX+LSuDovTNeukIrj40PCw3+Og3RcWMge8z6iY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y6oho66lw87eXlsfjW8B8ct3DiAjtB0OLGwRZfykmkvTNhwJ0uXdUJfCNFVM4JEBZ0L71BsF
 g0+MNPntXscB0d7iJb+PKzt4yiEj2kwlU+BYeaHliQOxAzYAdW/liYMcUF5fgCYA/PTu+bzw7g
 JUAaHyQscdYZamGNlmPhd319yk+ZuPHWarETTfZU7nZs4lmXmx9kMbsLSf5x1YpOjXmV2254oN
 oMjOGUgCuxrl7i464R26bg4/ybmwOSL4dvpSIuHV+ALT/c2reavio9x1eXrDIHv82gMAuRDr1+
 xPo4Sqj1fsRlKQXkpaYVz4RKIi496JEIaltlDRKuUFoTmRWg==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, a deadlock happened if many SIGSTOP/SIGCONT signals were
received rapidly. If the main thread sends __SIGFLUSH at the timing
when SIGSTOP is handled by the sig thread, but not is handled by the
main thread yet (sig_handle_tty_stop() not called yet), and if SIGCONT
is received, the sig thread waits for cygtls::current_sig (is SIGSTOP
now) cleared. However, the main thread waits for the pack.wakeup using
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
index 81b6c3169..b67eccf4d 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -760,7 +760,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
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


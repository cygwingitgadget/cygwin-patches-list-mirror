Return-Path: <SRS0=jwxA=UN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id 9DFEA3858408
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 03:16:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9DFEA3858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9DFEA3858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737429378; cv=none;
	b=nBdBnee7NcPpiTiRergmmLbDsyJQkIykZFLJW9bFoQqymUvqldJUkYYAmU0liWAI7wWdPiahMZut3pCU4qL1abRq/cs12mdX5KSoro660dh+yg50ufvzrTnEcsm1WKmQTDvrvFZ54/Gfe7nnbkxd0YpmpRZNpDRjLNEhKRNjeWM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737429378; c=relaxed/simple;
	bh=c8ToQzqwxEDDOn3BS4wwADXKOTvrJUVgD5JYG47hLyg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=syj+aeh3U34pg+MkGXmhIC5HGqt8TfdVpaNaEQMCAmJsR+aFGwexh1h82SX3eXN8lfoAIsanpqEYY2+Hj+T9JgIaAinwP4V0SFrs5vDYZIa+y6OP8knnSg+X0RHyzWUqo1k9QXeKEiL1cqu0UzQOvAQCkP8a5P07vyH2I6ssHMU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9DFEA3858408
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=guIvvymo
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20250121031616014.PDUV.44461.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 12:16:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 1/3] Revert "Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent"
Date: Tue, 21 Jan 2025 12:15:33 +0900
Message-ID: <20250121031544.1716992-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
References: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737429376;
 bh=GeQQt0ATfyF2BPVIaxW/Y7sL063hHAMelrUPEMxPnwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=guIvvymoZD/gUgfYiAZMYrwqXnbpYkR3XM/4qWmHGDRhplasIaWfLO55SQMB1I6U7l0Vzpvd
 OaK6M61VaEPlDVRTb1OhOrSI1eJBFWyYcNcTkVCWk6m75qun04ccDMrtuoXqA05MreeuRBw3EC
 JVF5sRsIXu5JIG+UU5Xyy9OapE5cg7fMSklKqjWYkpHfaMR/beJpFefj9JwkDOtK+LbMT5SI91
 VAWF7xTfXa7O21qHE0hhegv7SJhzquyYtT+fP8rzSfGjk33e6VFhxB4icesdg2iAHb5Sd/c8ei
 dnzHNtJxjChdhwTHdiiatsL0dy4s55oMYRZ3M/NbanUQV22g==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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


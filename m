Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e01.mail.nifty.com (mta-sp-e01.mail.nifty.com [106.153.228.1])
	by sourceware.org (Postfix) with ESMTPS id 2617B3858031
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 15:46:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2617B3858031
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2617B3858031
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.1
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737388013; cv=none;
	b=cimARprpK28waA1yNWjh+WO+Fitoc6Y6gDou7YrgL7U7ZqYDY4wM/x0JWNnb6ldGWC9R7BDvGy+OgO+gTQA1kKvuCAIj0ILGl1nNIsSeOh5oajfFs5dEE9fFobbLgWRW6VlYqHTFULmpw/TBXa8CFo2s0KD6S1NDsmKYdjgPqog=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737388013; c=relaxed/simple;
	bh=c8ToQzqwxEDDOn3BS4wwADXKOTvrJUVgD5JYG47hLyg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=RyNSFL2lA+UAArP+2jJZHUWmVgXryeTkeFXj8wiP50FJTs0jl//ZiW7JnbrFpm3tPr9yn98xak6Qt0vDlVyBS6fHIkMmf+Hs7Pny+20+6LDjrtSL0qebmwLHKx9YhKG5F8dYAN4r0oxRlRBc5Numscc9yIVWGPe+hGEn/CvwGxo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2617B3858031
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oNzv28cj
Received: from mta-snd-e01.mail.nifty.com by mta-sp-e01.mail.nifty.com
          with ESMTP
          id <20250120154651376.EGRO.6592.mta-snd-e01.mail.nifty.com@nifty.com>;
          Tue, 21 Jan 2025 00:46:51 +0900
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250120154651296.IUHD.9629.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 00:46:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 1/3] Revert "Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent"
Date: Tue, 21 Jan 2025 00:44:19 +0900
Message-ID: <20250120154627.107642-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250120154627.107642-1-takashi.yano@nifty.ne.jp>
References: <20250120154627.107642-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737388011;
 bh=GeQQt0ATfyF2BPVIaxW/Y7sL063hHAMelrUPEMxPnwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oNzv28cjcsp0kGFgtJwaqL3b8ZdyH7eRd7WiJ05agn1CnIuVj9olrmWTc+Bx0lOFEuUkFzht
 U5Z/6ThhFGjptHzUGNiFN4N7GYVV0RNWzx4ZsVK5g9cIjfIbT/ti40fpOlz3QqKjZOEetDv1Zp
 zhDBKOUxI1Opw/rXv2kDISqITPzq8d/SP4HbVa9EGSEY/g1t3YloKImX1M6kfqKjJgSsCmhGmd
 AAAI8PNHGBx/GQYui6lYgmkW8Sg0cjYEBXRsDWoekt1VxecdUJEQtvsZtjsDvBu/6qwvR0bdzA
 FXNs6oaumERULJrd1S88p6Cp6Y266inWLin04jnY4sR9Ovfw==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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


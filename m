Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 1F9F63858288
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 08:53:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1F9F63858288
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1F9F63858288
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737363199; cv=none;
	b=wpuWh90c8vjD7E8AfcrW4qUcfX1SUqmmtP6Dti/tt+J47H4r++LQvn8Wd22/BthtZ5Xjaa5sGW7CAAWQbXYjAOT+2WNW5b15ErkhTbc3/6FIneweXrSx7TNXeMmkHOs1z4nRuxYFztI1Mybb46I9Yk7qXy1Ed7F/thcu2c892UI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737363199; c=relaxed/simple;
	bh=c8ToQzqwxEDDOn3BS4wwADXKOTvrJUVgD5JYG47hLyg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=U4CTkW21rmFwdUVxHG35YFEQgrp8VM6XiWF5hBvhqQVePrpDHnYlG/MUENU9mPwjLLHBU0zNHxbFH1oi3k2xAzOHlkbJ/CW0f75ZuyDkyAt728vLXSMFZnFkMViqWFdyFKpOViXWIQjy0V08XrqGusUTBuNS1F6OXSVHb6oNNY0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F9F63858288
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qyg4YD1U
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20250120085317542.RKRD.67122.localhost.localdomain@nifty.com>;
          Mon, 20 Jan 2025 17:53:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 1/2] Revert "Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent"
Date: Mon, 20 Jan 2025 17:52:35 +0900
Message-ID: <20250120085249.1242380-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250120085249.1242380-1-takashi.yano@nifty.ne.jp>
References: <20250120085249.1242380-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737363197;
 bh=GeQQt0ATfyF2BPVIaxW/Y7sL063hHAMelrUPEMxPnwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qyg4YD1UBDAY0L9xOxmez6DnnFIPMGZGUORDFjqd0rN3g7RLrkNPhU6E2qgOysCajd4UhlzY
 uEt3pkXIXUwZ8uh8J6kIHXPb/c6uqaYe/DCkVr3zi39BzpOLUTWIJnecCceXj84j9M0OAXDWOy
 NYq+cLb6CZ8g/c0kqqPp4EYHEZPtaNhI8YrTAR7VmgjL0ZHUiBS1fGrsorVXd1YCsU0s00vhD9
 bmylmTKyc5D0JFMxS1zOxQevzwfLnF8T/p3VKzFCbNFfLBQdcrWxDu+K472LqvG+jET3jIbivA
 JjlCzXaozoE5us6bxKnLd9xlp+qNqJsmGQpvuyDcJfXPxgaQ==
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


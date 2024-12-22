Return-Path: <SRS0=v82v=TP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:28])
	by sourceware.org (Postfix) with ESMTPS id 3F9B03858D34
	for <cygwin-patches@cygwin.com>; Sun, 22 Dec 2024 19:05:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3F9B03858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3F9B03858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:28
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1734894330; cv=none;
	b=xHWfi75os24KdsDMdSM8kU/lRr27WHuhrggOyUAWp+gCzfbjU7+e9OgWJWnE+LucYJ1iY+sxA8QX0TED5Y4t0yf43InvmagWGHGXvGnmAqdxxA5jFYIQzk0O550Jhzgzu3e4a6eUM/sJbmu17c87EjlDG1PCkarQcAZp1geD/hA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734894330; c=relaxed/simple;
	bh=VD6ALTLRtH8KEFoa9hySDFQHgRV1EIZ46XH6J57XuVk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=loK3f+zlMw7gMq/lRLv7Gh3Sj85cImIu1+zu2JanaGjGvxfnCzZUv/3PyXhkv+DiNqwRR2o7bpYY+1Yrpu/SkYlWuiQs7p4kn9tcLXH8AXQHnM17SZw9cU5l9NyE9Fxabvi8oWG1FLPCKhNC14xipONV8e/ppTclIfj8SnlIk+Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3F9B03858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Msun0qDu
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20241222190527124.WWXR.67122.localhost.localdomain@nifty.com>;
          Mon, 23 Dec 2024 04:05:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Daisuke Fujimura <booleanlabel@gmail.com>
Subject: [PATCH] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent
Date: Mon, 23 Dec 2024 04:04:56 +0900
Message-ID: <20241222190504.47663-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1734894327;
 bh=Crrl7TnHozj7l/4vhluKmwz4XWp5F9ZG4KKITiYDJrE=;
 h=From:To:Cc:Subject:Date;
 b=Msun0qDufrN9S7nFouN4qcFmtMVXBi85RnR2AuWSVvC/mStRCckmlVbAtLmu/UuZSyL/uj+V
 YOFC0iPjR261wdclc3VtNU9h/TqFwXMfb/5js/229aN/odP071yALTTguLjT1pABUIlGRKrvB8
 7mNjDcHz8xEc5QhiIG39MRzxrPGkhjq9ImuhYT0rQQ2Fu5Zco8tV4mZUwppTuqjQRRIwIIKVRC
 ioDYw/PpgV4daC3TFPC+UwjGqI3sHZW/wRkLWpNuuxjkx+Ds72CtYN4tm2Sn6kUufotOaC5B3C
 gVLbVP1F3V3J2AKuV1XjEwvoVny5M/2b3ywULKYFDg9BN7UA==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit d243e51ef1d3, zsh sometimes hangs at startup. This
is because SIGCHLD is handled in cygwait() for a wakeup event even
when __SIGFLUSHFAST is sent, despite __SIGFLUSHFAST requiring to
return before handling the signal. With this patch, if the signal
sent is __SIGFLUSHFAST, do not handle the arrived signal and keep
it being asserted after the cygwait() for the wakeup event.

Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256954.html
Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
Reported-by: Daisuke Fujimura <booleanlabel@gmail.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/release/3.5.6 |  5 +++++
 winsup/cygwin/sigproc.cc    | 14 ++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)
 create mode 100644 winsup/cygwin/release/3.5.6

diff --git a/winsup/cygwin/release/3.5.6 b/winsup/cygwin/release/3.5.6
new file mode 100644
index 000000000..643d58e58
--- /dev/null
+++ b/winsup/cygwin/release/3.5.6
@@ -0,0 +1,5 @@
+Fixes:
+------
+
+- Fix zsh hang at startup.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256954.html
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index ba7818a68..d676799cc 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -785,7 +785,16 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   if (wait_for_completion)
     {
       sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
-      rc = cygwait (pack.wakeup, WSSC);
+      do
+	{
+	  rc = cygwait (pack.wakeup, WSSC, cw_sig_eintr);
+	  if (rc == WAIT_SIGNALED && pack.si.si_signo != __SIGFLUSHFAST)
+	    _my_tls.call_signal_handler ();
+	}
+      while (rc != WAIT_OBJECT_0 && rc != WAIT_TIMEOUT);
+      /* Re-assert signal_arrived which has been cleared in cygwait(). */
+      if (_my_tls.current_sig)
+	_my_tls.set_signal_arrived ();
       ForceCloseHandle (pack.wakeup);
     }
   else
@@ -806,9 +815,6 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
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


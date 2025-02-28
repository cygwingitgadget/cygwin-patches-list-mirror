Return-Path: <SRS0=PYjw=VT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 9631E3858D1E
	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2025 23:34:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9631E3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9631E3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740785683; cv=none;
	b=IBKDC9hqIBKBO0Oz5sXxSWfJM/HfuwEUaeD8V4EROtXvIAN/nC5PmgEHAWC0oLahSs0F8qHmfCXUbNbI3Dky/avVjuqpRfgn6J1c581/Ejs7GlR37/QA9NaEaMEhwGM5jkrf9Fzr7o/bbHiJEwpF6lUJ+DB2baokMdWWc0dZdiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740785683; c=relaxed/simple;
	bh=hdiOk/E5OaFuMkPsDcheRCLq9G3AdcAmOXgfeVHyQW4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DbUhfOo0JgWkoYujRg0i1U87V7zDGd8U0UCyDuu4wZ/iL6WiA8P5j3RjYXyxQeN/FOctHzuZqteYjF2PA1dOq+bjPTGFw8/4pvVfzuiDex2ef56M7jXzUgHrjVLo78aq3KuLpfeXTo7Vc188TCTyeG9VrC9RNWHiisEKBdNLHBQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9631E3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RIC+qWYa
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20250228233440937.JZTR.33121.localhost.localdomain@nifty.com>;
          Sat, 1 Mar 2025 08:34:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v3 1/3] Cygwin: signal: Fix deadlock on SIGCONT
Date: Sat,  1 Mar 2025 08:33:46 +0900
Message-ID: <20250228233406.950-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740785681;
 bh=EuFkVrP+gpehNCD0B/5i+uuz0etgZ5npvpR6Z197cwQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RIC+qWYaNhgjIP7v6YOktDmbBBAL3fF8Vq0s+lqB5Vbkz6G/yG7bPdLn1D7VrdEfcr0cpipt
 9b2W6vpbjUaWo+OXNIksio94jtZHUI7vtp1VLqVw7tYybOVGwd20HMOI0jRBs+FjFmLXj7g3Wn
 FeZh6uvPhXcf80LcfotObty/1ZG4wCNYHzmOc+jezGYHmgTYOc6OnotdL4pNzne5W2YQCAhUNl
 gtubyQtYCq32ChXvHkt4kCx2qcfsPXjRbaCEJefNdoi3JTsXgu8OMoV4ASRmFEe1+Eyi/eor8s
 oiilYH8KX4xWecifdTqmVm37hqUDzignVTmHZvvjImIB9Pjg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If SIGCONT starts processing while __SIGFLUSHFAST is ongoing,
_main_tls->current_sig will never be cleared because the signal
processing is stopped while waiting for the wake-up event in the
main thread. This leads to a deadlock in the while loop waiting for
current_sig to be cleared. With this patch, the function returns to
wait_sig() if current_sig is set, rather than waiting for it in the
while loop.

Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257473.html
Fixes: 9d2155089e87 ("(sigpacket::process): Call handle_SIGCONT early to deal with SIGCONT.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index f576c5ff2..c6e82b6c5 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1425,23 +1425,18 @@ _cygtls::handle_SIGCONT ()
   if (NOTSTATE (myself, PID_STOPPED))
     return;
 
-  myself->stopsig = 0;
-  myself->process_state &= ~PID_STOPPED;
-  /* Carefully tell sig_handle_tty_stop to wake up.
-     Make sure that any pending signal is handled before trying to
-     send a new one.  Then make sure that SIGCONT has been recognized
-     before exiting the loop.  */
-  while (current_sig)  /* Assume that it's ok to just test sig outside of a */
-    yield ();          /* lock since setup_handler does it this way.  */
-
   lock ();
   current_sig = SIGCONT;
   set_signal_arrived (); /* alert sig_handle_tty_stop */
   unlock ();
 
+  /* Make sure that SIGCONT has been recognized before exiting the loop. */
   while (current_sig == SIGCONT)
     yield ();
 
+  myself->stopsig = 0;
+  myself->process_state &= ~PID_STOPPED;
+
   /* Clear pending stop signals */
   sig_clear (SIGSTOP, false);
   sig_clear (SIGTSTP, false);
@@ -1473,7 +1468,17 @@ sigpacket::process ()
   myself->rusage_self.ru_nsignals++;
 
   if (si.si_signo == SIGCONT)
-    _main_tls->handle_SIGCONT ();
+    {
+      /* Carefully tell sig_handle_tty_stop to wake up.
+	 Make sure that any pending signal is handled before trying to
+	 send a new one. */
+      if (_main_tls->current_sig)
+	{
+	  rc = -1;
+	  goto done;
+	}
+      _main_tls->handle_SIGCONT ();
+    }
 
   /* SIGKILL is special.  It always goes through.  */
   if (si.si_signo == SIGKILL)
-- 
2.45.1


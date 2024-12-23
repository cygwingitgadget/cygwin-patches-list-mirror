Return-Path: <SRS0=b6FN=TQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id C4EEA3858D1E
	for <cygwin-patches@cygwin.com>; Mon, 23 Dec 2024 01:33:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C4EEA3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C4EEA3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1734917631; cv=none;
	b=Xyr7wZ+bK+sYwlrsXSJnwmqwqS6nDYKAIOSsN/aH7sRmBVX2ELf8xXqWR1c+qvedwzv7Fyf5wc8DYURXWGzV82A4J8/wyirlLVaqG03nzZeY5OB5SRYndB8h1qM/XtEgjdxWsFZQJVJ0VKNtygWYS9wa66bDx9GgBOm1/3gSqI0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734917631; c=relaxed/simple;
	bh=zmvNBKCNMp36cRborsM7jfvckG1HUsIze8vWme5HrS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=AiAyW87Cg6hkNe9Kc/OWlXWno9pcHdjuaAZdqhpX8xEnE7BJtMhkh34gBZ0quiUX5KlRp2LL3RrScz1bMKYOytFoAjdIwKVWWMQR/0QmDweAF56ZMo1xjm2mAQkPXs4sK5SQTqlnhtGbBol+uLzb7bz4hpXCM/vXQgtxupRl0MA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C4EEA3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Ro9ykbU6
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241223013347001.ILRR.47547.localhost.localdomain@nifty.com>;
          Mon, 23 Dec 2024 10:33:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Daisuke Fujimura <booleanlabel@gmail.com>
Subject: [PATCH v2] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent
Date: Mon, 23 Dec 2024 10:33:25 +0900
Message-ID: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1734917627;
 bh=QnVwHdeoFHC1Vb2FO3IzYX7cNu5QEE9llBrIy46HW0g=;
 h=From:To:Cc:Subject:Date;
 b=Ro9ykbU6gTWHQscp9kJ2tH2AFSlQu1vdk42CJ5BGuNApoOLLrj0xS3ThoCnvPSanMGZqM4Zr
 ApypibDIoSmmWyeJpK1d4LaHyhk7csLO42rfbOV5h2PyGzHMLO0TCNoQZ6Nciqzc6AXfk+dq64
 7yfO+TSCnUKN4Lb4rG3eZ0FPHHmhGS5BSVLB6XQwNk2gko848duKUteQZG+bi8dfavfyiFtQG1
 UbzNm2bzNSTLrnuxruvRWLp1wqtp+03Zi3psdfUn5QHpfCE16Gp/QO0b5pRAuEe7mUZcc4pPCi
 RFrBYb2k9v8U0cqozr+84s9XXPUaK1xriXE9bY0syoz3UtWg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit d243e51ef1d3, zsh sometimes hangs at startup. This
occurs because SIGCHLD, which should trigger sigsuspend(), is handled
in cygwait() that is used to wait for a wakeup event in sig_send(),
even when __SIGFLUSHFAST is sent. Despite __SIGFLUSHFAST being
required to return before handling the signal, this does not happen.
With this patch, if the signal currently being sent is __SIGFLUSHFAST,
do not handle the received signal and keep it asserted after the
cygwait() for the wakeup event.  Apply the same logic to the cygwait()
in the retrying loop for WriteFile() as well.

Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256954.html
Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
Reported-by: Daisuke Fujimura <booleanlabel@gmail.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/release/3.5.6 |  5 +++++
 winsup/cygwin/sigproc.cc    | 20 +++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)
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
index ba7818a68..35ec3e70e 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -751,10 +751,14 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       res = WriteFile (sendsig, leader, packsize, &nb, NULL);
       if (!res || packsize == nb)
 	break;
-      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
+      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED
+	  && pack.si.si_signo != __SIGFLUSHFAST)
 	_my_tls.call_signal_handler ();
       res = 0;
     }
+  /* Re-assert signal_arrived which has been cleared in cygwait(). */
+  if (_my_tls.current_sig)
+    _my_tls.set_signal_arrived ();
 
   if (!res)
     {
@@ -785,7 +789,16 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
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
@@ -806,9 +819,6 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
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


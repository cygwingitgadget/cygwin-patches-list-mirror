Return-Path: <SRS0=STBq=SO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2a])
	by sourceware.org (Postfix) with ESMTPS id 2044A3858D21
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 08:41:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2044A3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2044A3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732005683; cv=none;
	b=TDoCHyUVxYBrSQsx5F1evFxkZEwknhmARYTxHpM7JBWlswfCEcSnItKe0mt0YVIIWuSHrDucH1NJwWsxCmqpdK9yXd8q4GajjrGCstlys7JOfHireceSe597C5UyMp0IsVj1sHmPWh7iGkfq/v4k2OHVc32XQO/ZU7K/NkK6HvA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732005683; c=relaxed/simple;
	bh=7Q1CGr6vbZav8tQvqs0ktf2/tdxTz2luKZklubpqTP0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Guq5KVo8XnS4EtCjlqQH9KmsT4LIJz015Rc1IQ7iNHx+VNcTgjfxMl+c6LxqaIBJ88i1vDjNtixqqUIklUaQrofwlWt7hsgGLLwWlez7SZzGQF+Y2533z+UYgVIauiQ4cXTzVzeF44SrCMEzbOsnItQf83xeAjpgQdy/5/e6odo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2044A3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FDwd+Hdz
Received: from localhost.localdomain by mta-snd-e10.mail.nifty.com
          with ESMTP
          id <20241119084120937.QZAX.33191.localhost.localdomain@nifty.com>;
          Tue, 19 Nov 2024 17:41:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: sigtimedwait: Fix segfault when timeout is used
Date: Tue, 19 Nov 2024 17:40:47 +0900
Message-ID: <20241119084057.945-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732005681;
 bh=IhIbmVE3C5+9nnvxtzD507Kme0+dHTv97fJU7iD9Vf8=;
 h=From:To:Cc:Subject:Date;
 b=FDwd+Hdz+UbRgwTJ7iKBjByiGOcdBp8axyQt0jqz5c/xjb1txHZS2d2ftxgpPFuoaCwtoV73
 df4PD5Bz/pXg67pc2ngGjoVjhkg/dNfrEJwcmzQkO2QhNrKCoSqFV1ShH9ZJWRL7C7qBYkTRTD
 8t1xBlMNLmNSNk/9GM6t7Eg6WZWK5Vc5ukUkhsql806F7fRUOqgVcJXMnF5nOsUX62SuHl11K+
 8tC8WzzOIiHO7tkyB4FBxGx7ALF7KO6/pWIK6cjRPXlTozsi7s+Lme+pelTiCdj95cip9R7/9+
 oCacV1V1zedS25zptFZJm4sewJ8pke85aGLUDKVsQ8hEU/MA==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, two bugs exist in sigtimedwait(). One is, that since
_my_tls.sigwait_mask was left non-zero if the signal arrives after
the timeout, sigpacket::process() would wrongly try to handle it.
The other is if a timeout occurs after sigpacket::process() is
called, but not completed yet, the signal handler can be called
accidentally. If the signal handler is set to SIG_DFL or SIG_IGN,
access violation will occur in both cases.

With this patch, in sigwait_common(), check if sigwait_mask == 0
to confirm that sigpacket::process() cleared it. In this case,
do not treat it as WAIT_TIMEOUT, but as WAIT_SIGNALED. Moreover,
sigpacket::process() checks sigwait_mask to know whether timeout
occurs in sigwait_common() and if timeout already happens, do not
treat the signal as waited. In both cases, to avoid race issues,
the code is guarded by cygtls::lock().

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256762.html
Fixes: 24ff42d79aab ("Cygwin: Implement sigtimedwait")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc |  5 ++++-
 winsup/cygwin/release/3.5.5 |  3 +++
 winsup/cygwin/signal.cc     | 17 ++++++++++++++---
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 3195d5719..60c1f594f 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1527,11 +1527,14 @@ sigpacket::process ()
   if ((HANDLE) *tls)
     tls->signal_debugger (si);
 
-  if (issig_wait)
+  tls->lock ();
+  if (issig_wait && tls->sigwait_mask != 0)
     {
       tls->sigwait_mask = 0;
+      tls->unlock ();
       goto dosig;
     }
+  tls->unlock ();
 
   if (handler == SIG_IGN)
     {
diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
index 115496c18..77e60d1d7 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -39,3 +39,6 @@ Fixes:
 
 - Fix NtCreateEvent() error in create_lock_ob() called from flock().
   Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
+
+- Fix segfault when timeout is used in sigtimedwait().
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256762.html
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index 77152910b..eca536e90 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -618,6 +618,20 @@ sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER waittime)
       switch (cygwait (NULL, waittime,
 		       cw_sig_eintr | cw_cancel | cw_cancel_self))
 	{
+	case WAIT_TIMEOUT:
+	  _my_tls.lock ();
+	  if (_my_tls.sigwait_mask != 0)
+	    {
+	      /* Normal timeout */
+	      _my_tls.sigwait_mask = 0;
+	      _my_tls.unlock ();
+	      set_errno (EAGAIN);
+	      break;
+	    }
+	  /* sigpacket::process() already started.
+	     Go through to WAIT_SIGNALED case. */
+	  _my_tls.unlock ();
+	  fallthrough;
 	case WAIT_SIGNALED:
 	  if (!sigismember (set, _my_tls.infodata.si_signo))
 	    set_errno (EINTR);
@@ -639,9 +653,6 @@ sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER waittime)
 	      _my_tls.unlock ();
 	    }
 	  break;
-	case WAIT_TIMEOUT:
-	  set_errno (EAGAIN);
-	  break;
 	default:
 	  __seterrno ();
 	  break;
-- 
2.45.1


Return-Path: <SRS0=Xcl4=SM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id BC6893857341
	for <cygwin-patches@cygwin.com>; Sun, 17 Nov 2024 15:48:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BC6893857341
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BC6893857341
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731858528; cv=none;
	b=TTCkKVt62w4HyB0RW5DxAzVHFvlgXX/OAIL+eEtq3/OndWa7LUHmcrI5/02OgZ+RLGNPLHs/boV2RR2CKmQailubv+KcOmMkqUbZILZk83nMNOVAAvjWqnWxmZdjHcccrlxSFVnDrqV+0Jt2TpWSR2I38yrjAKdpsv80746mLOk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731858528; c=relaxed/simple;
	bh=BXx/gKGE39jgYR8XH8oxeLDN5IFdyyjcFOQXSscNIqM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=IUUnvQVifgUOQQywJQJ50phKYoRr+EGZY5DdVQvmL/cNaww4lvNS2zndON91dm31RMSa3WKcowKE5sp0Xzv2GXpVck4ASif7G63nL60rqR8bP1ET2d91any5Av+wTiBWF7oY/0A1vpyLpIL4Kr6w+xfdx9kqbVHoRjEh4MawHhw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BC6893857341
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=C1U8y+uf
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20241117154844414.VPDE.87244.localhost.localdomain@nifty.com>;
          Mon, 18 Nov 2024 00:48:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: sigtimedwait: Fix segfault when timeout is used
Date: Mon, 18 Nov 2024 00:48:21 +0900
Message-ID: <20241117154829.1578-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1731858524;
 bh=bawnNGE/gDPhir+5TJq7CnMNTs3RlgWs2SBHqU1alY4=;
 h=From:To:Cc:Subject:Date;
 b=C1U8y+uftpEYH9HByQSrN5SduLwW66elSjoeiY6K/7YtXEeiAmFjrxHPXmt3VP/1xHfT+EI+
 4wkmFYdg9SRS5hGbPjTsdM7Ktq+cQORDDGrSpbwp1BDUk5YEImzItRnin9DTz+d68uyLlV8Yl5
 3D7MpvOqE9gutQtLyOollJOtDTBUbZDwNOfVarqqoCjaJnYdzirs9fWcJCfUWbZdgvoyoIT174
 twa5WZqUQncZP8MOzf7nj0FDMLm0U9tcw3FQLLf8dxUMi4/IxC81Ua0cA7TUl45BX2yPiw80iE
 wXPYhYYkqsXvSFciwVUWT930PFpFZbSGN5UsoQZoSHL6W9KA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
do not treat WAIT_TIMEOUT, but call cygwait() again to retrieve
the signal. Furthermore, sigpacket::process() checks whether
timeout occurs in sigwait_common() and if timeout already happens,
do not treat the signal as waited. In both cases, to avoid race
issues, the code is guarded by cygtls::lock().

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256762.html
Fixes: 24ff42d79aab ("Cygwin: Implement sigtimedwait")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc |  5 ++++-
 winsup/cygwin/signal.cc     | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

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
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index 77152910b..74b304606 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -615,6 +615,7 @@ sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER waittime)
       set_signal_mask (_my_tls.sigwait_mask, *set);
       sig_dispatch_pending (true);
 
+do_wait:
       switch (cygwait (NULL, waittime,
 		       cw_sig_eintr | cw_cancel | cw_cancel_self))
 	{
@@ -640,6 +641,16 @@ sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER waittime)
 	    }
 	  break;
 	case WAIT_TIMEOUT:
+	  _my_tls.lock ();
+	  if (_my_tls.sigwait_mask == 0)
+	    {
+	      /* sigpacket::process() already started. */
+	      waittime = cw_infinite;
+	      _my_tls.unlock ();
+	      goto do_wait;
+	    }
+	  _my_tls.sigwait_mask = 0;
+	  _my_tls.unlock ();
 	  set_errno (EAGAIN);
 	  break;
 	default:
-- 
2.45.1


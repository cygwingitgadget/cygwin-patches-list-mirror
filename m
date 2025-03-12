Return-Path: <SRS0=oSj3=V7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 78E843858D21
	for <cygwin-patches@cygwin.com>; Wed, 12 Mar 2025 03:28:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78E843858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 78E843858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741750111; cv=none;
	b=t184I+CklFO5QsZDDouB189JqXRZ/5w+Qn9pf5rlD5rwebO7r8kxFrTJZUG5Oj9V9AhWTIH9P+fdeOnrELibqiw7Vdg3pyaxox6e26dGNzWUiPLMSVsVQcF6SC7nMwjm+IjaMjKXWmEToakRtfzSxleaaAb8gAF+ZMwEmsOhqf8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741750111; c=relaxed/simple;
	bh=HJDnaYdrKEHkMOtbAGRb8dDiXmdFOF0iTUnU7uSQODA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=XY7dYyFLw1JRljWi2b/qTpBZbDesBjRiP4CQpQWHKzKl0oYz8j/XR8nSZyNs07YanbThC9uAyonw+1Jc2fOnsxqvUB5YLNPJWvVjefUDA6y605a+lVUV1Q22X03dTimJ3mG7LGJP4b4Ajbu8LfdmYh8RiPJwdBRRXsqE+QU60JY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 78E843858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lZpOexSN
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250312032828318.XTRT.17135.localhost.localdomain@nifty.com>;
          Wed, 12 Mar 2025 12:28:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 2/6] Cygwin: signal: Do not clear signals in the queue
Date: Wed, 12 Mar 2025 12:27:28 +0900
Message-ID: <20250312032748.233077-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741750108;
 bh=qauBXDkAzQvFJ4jfNnNsBw9bqJt19l4hM5OLx3EdjTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lZpOexSNo6bwvnY2lsCeCjw/wkm5UGx0yQAHfiZQq75pupZ+kcUuqMe+GTIAeKHAbkZ0JiC7
 865ITMz+/HL6bvU3snvnm1Au5KJYZwhmqSI5mzSEMZV6sby56hAPFXkGAa9OOrX+kgjKs+6B5F
 Miev34g0z1k1QcPTbEq3yjEUxqs3X3fOVk87PJ6tlsTtshKxnUPpZAHUSeea0DyZMycDa10YXq
 JyWzjK66JXOsKcQ0BbLTFIXBJkHqcqgJGuvcwfYfN5aMGpDH1g0N7ffkh7hA39KIh0X/XG5Irw
 RD1DPTABODbP+U95Mobpkqc6fqq3ouVkyZuxjb5lunhzIYaA==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, sigpacket::process() clears some signals from the queue.
For instance, SIGSTOP clears SIGCONT and SIGCONT clears SIGSTOP, etc.
These might be needed by previous queue design, however, new queue
design does not require that. On the contrary, that causes signal
lost. With this patch, these sig_clear() calls are removed.

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a05883e3f..73cfc7967 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1436,12 +1436,6 @@ _cygtls::handle_SIGCONT ()
 
   myself->stopsig = 0;
   InterlockedAnd ((LONG *) &myself->process_state, ~PID_STOPPED);
-
-  /* Clear pending stop signals */
-  sig_clear (SIGSTOP, false);
-  sig_clear (SIGTSTP, false);
-  sig_clear (SIGTTIN, false);
-  sig_clear (SIGTTOU, false);
 }
 
 int
@@ -1547,15 +1541,7 @@ sigpacket::process ()
   if (si.si_signo == SIGKILL)
     goto exit_sig;
   if (si.si_signo == SIGSTOP)
-    {
-      sig_clear (SIGCONT, false);
-      goto stop;
-    }
-
-  /* Clear pending SIGCONT on stop signals */
-  if (si.si_signo == SIGTSTP || si.si_signo == SIGTTIN
-      || si.si_signo == SIGTTOU)
-    sig_clear (SIGCONT, false);
+    goto stop;
 
   if (handler == (void *) SIG_DFL)
     {
-- 
2.45.1


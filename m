Return-Path: <SRS0=MN9U=YW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 580903858D26
	for <cygwin-patches@cygwin.com>; Sat,  7 Jun 2025 09:19:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 580903858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 580903858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749287976; cv=none;
	b=G5QqJNOqv6CzrWIplWZlpImv6Xz7qq+YLB06ZApHqfcz5WynSuz4GQbxlvlGehiFl1dkSlA7p2T26s6RRpYN4exfy47KQOhiWDDCUtcTUHnwiPIEe9VUZsBMhg4+isArhFeJetmbC2kAHKsR2eUzB6cKbLPyz3uLuvPnxSujwPk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749287976; c=relaxed/simple;
	bh=CIXbT16dk5kXurYCMri9zVhylVfudqEVYabErk/wf2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BtrYEBcEqdPYi36xYwliNOvtfwJVpCIXXrhjkSMKKNRew2NYtmoBFWrqazLvWaEsPvD36h8VtjzrfNcriG8PmT9Z2FaH2eCanlHjz4FTrW+SGKCk6Heg9d3QzQ/2Q+UpJZf8RWkvF1DpKAKCqF6EYvZi+6SssEVeqWLsq905DiY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 580903858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MOoW3rUt
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250607091932085.CYXC.69071.localhost.localdomain@nifty.com>;
          Sat, 7 Jun 2025 18:19:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: signal: Enable the signal mask earlier
Date: Sat,  7 Jun 2025 18:19:08 +0900
Message-ID: <20250607091917.760-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1749287972;
 bh=aEvn8ZIHfGlcaMz3xygQ/5g68bYR9Pos2mMCTp+V5Os=;
 h=From:To:Cc:Subject:Date;
 b=MOoW3rUtcBGnGmGQxC1FHk4gyWSvqiAyGzizUYEVwjpx0xti3BFOqOgoUbxmJLK/3cjpDg+Y
 l+c0OP2kGQ2e8B+msNcu/XOTij9ToW0aCruWiRoAsgKpBoiUFq7+3VMC8usVhf6EFeUkAxC2wR
 kuywyUTxIxgKT6rPFfgQvNMvtU7yemWBXZHin65mRLxMfqNcAJ85fiL0B7R6u0I0/snBFbE7IX
 KsCuswVXUOP8fRez6fEzybVDvZ62xxJkECm43acBpCzWRfKvwQKo+vG2cPDneXee9V9Lr2hy39
 qHnlNi09tNrjwqIctMyESGdT9CS52a8uYOU06wH/r7hqYW/A==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, _cygtls::sigmask is set in call_signal_handler(), but this
is too late to effectively prevent a masked signal from being armed.
With this patch, deltamask, which is set in _cygtls::interrupt_setup()
in advancem, is also checked as well as sigmask to determine that the
signal can be armed.

Fixes: 0d675c5d7f24 ("* exceptions.cc (interrupt_setup): Don't set signal mask here or races occur with main thread.  Set it in sigdelayed instead.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc |  6 +++++-
 winsup/cygwin/mm/cygheap.cc | 13 +++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index bcc7fe6f8..a4699b172 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1322,6 +1322,7 @@ set_process_mask_delta ()
   else
     oldmask = _my_tls.sigmask;
   newmask = (oldmask | _my_tls.deltamask) & ~SIG_NONMASKABLE;
+  _my_tls.deltamask = 0;
   sigproc_printf ("oldmask %lx, newmask %lx, deltamask %lx", oldmask, newmask,
 		  _my_tls.deltamask);
   _my_tls.sigmask = newmask;
@@ -1544,12 +1545,15 @@ sigpacket::process ()
       if (tl_entry)
 	{
 	  tls = tl_entry->thread;
+	  tl_entry->thread->lock ();
 	  if (sigismember (&tls->sigwait_mask, si.si_signo))
 	    issig_wait = true;
-	  else if (!sigismember (&tls->sigmask, si.si_signo))
+	  else if (!sigismember (&tls->sigmask, si.si_signo)
+		   && !sigismember (&tls->deltamask, si.si_signo))
 	    issig_wait = false;
 	  else
 	    tls = NULL;
+	  tl_entry->thread->unlock ();
 	}
     }
 
diff --git a/winsup/cygwin/mm/cygheap.cc b/winsup/cygwin/mm/cygheap.cc
index 4cc851716..338886468 100644
--- a/winsup/cygwin/mm/cygheap.cc
+++ b/winsup/cygwin/mm/cygheap.cc
@@ -743,6 +743,7 @@ init_cygheap::find_tls (int sig, bool& issig_wait)
   while (++ix < (int) nthreads)
     {
       /* Only pthreads have tid set to non-0. */
+      threadlist[ix].thread->lock ();
       if (!threadlist[ix].thread->tid
 	  || !threadlist[ix].thread->initialized)
 	;
@@ -752,13 +753,21 @@ init_cygheap::find_tls (int sig, bool& issig_wait)
 	  issig_wait = true;
 	  break;
 	}
-      else if (!t && !sigismember (&(threadlist[ix].thread->sigmask), sig))
+      else if (!t && !sigismember (&(threadlist[ix].thread->sigmask), sig)
+	       && !sigismember (&(threadlist[ix].thread->deltamask), sig))
+	{
 	  t = &cygheap->threadlist[ix];
+	  break;
+	}
+      threadlist[ix].thread->unlock ();
     }
   /* Leave with locked mutex.  The calling function is responsible for
      unlocking the mutex. */
   if (t)
-    WaitForSingleObject (t->mutex, INFINITE);
+    {
+      threadlist[ix].thread->unlock ();
+      WaitForSingleObject (t->mutex, INFINITE);
+    }
   return t;
 }
 
-- 
2.45.1


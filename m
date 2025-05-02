Return-Path: <SRS0=mLRr=XS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.226.35])
	by sourceware.org (Postfix) with ESMTPS id EDB333858D35
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 11:01:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDB333858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EDB333858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746183697; cv=none;
	b=QTxBMKkDibxqsXmjADWDWksKyJrQGl1XThRu0Y1OP+bzOdLHmZVdXw6sK7UMu0CqaP8ERoqh56evsxEnuYWquZ4xn80dkQ/j7dMhzUnujn6/RGBnEoJeYUmB4FODtZ63+/UnMOZU2q97t4Reb1TkEAUgIjuA4cQNVpY3AkpMgaw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746183697; c=relaxed/simple;
	bh=aiGPRUpxzho1/w2w1oTG/+AX3kyabE11630nMd643p0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=kVv7e9Es28IbFgr/Cl1uJ3OeCIfEsJJ79FXIL+9R4ey2v4G3SX6IyIoJEbPFOUU63g98Z9aSDxakm8SZJJsvRRdj9pE2B1Nx4U2DfHm8OzGX8elgCBWLqJ9NvTe2n0MW73K215v9bZfYqaQZcN2fn/YhtD3dT0PZDUwy7KRcmBw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EDB333858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PGhjCQmw
Received: from localhost.localdomain by mta-snd-e03.mail.nifty.com
          with ESMTP
          id <20250502110132805.PFJY.47114.localhost.localdomain@nifty.com>;
          Fri, 2 May 2025 20:01:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v3] Cygwin: signal: Do not handle signals while waiting for wakeup evt
Date: Fri,  2 May 2025 20:00:51 +0900
Message-ID: <20250502110105.1416-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746183692;
 bh=8QlQXpD/nT+rBtji39NAwIqmFb5CMMEVShGjRUUYVcs=;
 h=From:To:Cc:Subject:Date;
 b=PGhjCQmwiKl3LNfXyPE2M1NQxh7AYAqgYC7RQ7QqyOThnZyzzd36eShh5eukPgrZ4r3io1ph
 +C9yanSKjRA8H6V3+G6aZe59wZgawmt7+OjVMapFQhIW31ibm3SHMVvf3OxwPEBc3Hz6IaLi/X
 LyqwGV0iWGP1t2yH+25SnU12LnkqHdTAzHKvE1kEalXnS49bbVlL5/pmT/hGgkEno4U4v/aJEr
 s9vSliKDiHXwMwnrHDN2lSBTXWeROti2j5zOHHdCGja5QQy22rEYwIXOVdmKnem+Hu00m66E9H
 rHy20c426HZuRxrJObV+14FVL5ioASBFNf0ghDP43NPuyCTA==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

... Otherwise, the opportunity for cleanup the wakeup event handle etc.
may be lost because the user signal handler never returns if it calls
longjmp(). This results in handle leak because the wakeup event handle
will not be closed. This issue happens when the commnad e.g. "stress-ng
--mprotect 1 -t 5" is executed. Instead, call call_signal_handler()
after cleaning up if some signals are armed during waiting wakeup event.
This essentially reverts the commit d243e51ef1d3, however, the deadlock
fixed by that commit no longer occurs even reverting it for some reason.
This is probably due to the redesign of the signal queue.

In addition, do not touch "incyg" flag in _cygtls::call_signal_handler()
because the process is still in the cygwin function when a user signal
handler is called from the cygwin functions such as cygwait().

Addresses: https://sourceware.org/pipermail/cygwin/2025-March/257726.html
Fixes: d243e51ef1d3 ("Cygwin: signal: Fix deadlock between main thread and sig thread")
Fixes: 3a1ccfc8c7e6 ("* exceptions.cc (setup_handler): Remove locked flag.  Use 'incyg' flag and in_exception function to determine when we're in a cygwin function.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc |  3 ---
 winsup/cygwin/sigproc.cc    | 20 +++++++++++---------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 49fc166ff..d1c98e46f 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1756,7 +1756,6 @@ _cygtls::call_signal_handler ()
 
       int this_errno = saved_errno;
       reset_signal_arrived ();
-      incyg = false;
       current_sig = 0;	/* Flag that we can accept another signal */
 
       /* We have to fetch the original return address from the signal stack
@@ -1869,8 +1868,6 @@ _cygtls::call_signal_handler ()
 	}
       unlock ();
 
-      incyg = true;
-
       set_signal_mask (_my_tls.sigmask, (this_sa_flags & SA_SIGINFO)
 					? context1.uc_sigmask : this_oldmask);
       if (this_errno >= 0)
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index fc28be956..361887981 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -611,7 +611,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   bool communing = si.si_signo == __SIGCOMMUNE;
 
   pack.wakeup = NULL;
-  bool wait_for_completion;
+  bool wait_for_completion = false;
   if (!(its_me = p == NULL || p == myself || p == myself_nowait))
     {
       /* It is possible that the process is not yet ready to receive messages
@@ -762,13 +762,10 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       memcpy (p, si._si_commune._si_str, n); p += n;
     }
 
-  unsigned cw_mask;
-  cw_mask = pack.si.si_signo == __SIGFLUSHFAST ? 0 : cw_sig_restart;
-
   char mtx_name[MAX_PATH];
   shared_name (mtx_name, "sig_send", p->pid);
   mtx = CreateMutex (&sec_none_nih, FALSE, mtx_name);
-  cygwait (mtx, INFINITE, cw_mask);
+  WaitForSingleObject (mtx, INFINITE);
 
   if (its_me && (si.si_signo == __SIGFLUSHFAST || si.si_signo == __SIGFLUSH))
     {
@@ -791,7 +788,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
 	  CloseHandle (mtx);
 	  ResetEvent (sigflush_done_evt);
 	  SetEvent (sigflush_evt);
-	  cygwait (sigflush_done_evt, INFINITE, cw_mask);
+	  WaitForSingleObject (sigflush_done_evt, INFINITE);
 	  rc = 0;
 	  goto out;
 	}
@@ -807,8 +804,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       if (!res || packsize == nb)
 	break;
       ReleaseMutex (mtx);
-      cygwait (NULL, 10, cw_mask);
-      cygwait (mtx, INFINITE, cw_mask);
+      Sleep (10);
+      WaitForSingleObject (mtx, INFINITE);
       res = 0;
     }
   ReleaseMutex (mtx);
@@ -843,7 +840,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   if (wait_for_completion)
     {
       sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
-      rc = cygwait (pack.wakeup, WSSC, cw_mask);
+      rc = WaitForSingleObject (pack.wakeup, WSSC);
       ForceCloseHandle (pack.wakeup);
     }
   else
@@ -874,6 +871,11 @@ out:
     }
   if (pack.wakeup)
     ForceCloseHandle (pack.wakeup);
+
+  /* Handle signals here if it was not handled yet */
+  if (wait_for_completion && pack.si.si_signo != __SIGFLUSHFAST)
+    _my_tls.call_signal_handler ();
+
   if (si.si_signo != __SIGPENDING && si.si_signo != __SIGPENDINGALL)
     /* nothing */;
   else if (!rc)
-- 
2.45.1


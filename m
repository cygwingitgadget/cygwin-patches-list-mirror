Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id F3A583858D21
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 03:26:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F3A583858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F3A583858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733369172; cv=none;
	b=t52jRDQ7mSoUqXEvz1HeQTH1VvR+rcplDQr0NcC1PARdi4p2o1c3tvtk2WNVM+zX/vzeBruVtIrGpDFmo3bD1XSZMK8E15h21hTET02zhNfN9OBPyMRQ7I5geqs1KpYje8QC2o/6bi1faUt18Zkb/H/BdDJOlHQw4vqRLCB1i2U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733369172; c=relaxed/simple;
	bh=YPP1ez77m7B1gNI6mJojpZfBj0hn3ZmFGAP0AuXYX98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=XXbru5/mBqDz+AA0FE/GolCNHO6beIJi/W3RBBLncwrUUMPurosbW/hYTI6Irx5LfeTOgUJigfYascVwA83si//2IvTveODXiqTbl4zTx1DB+0m+P6oKns7+c90J5WptKCcWothGH6FIMuxDsGEYZQi4imPxME1bZTjjle5YiYg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F3A583858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aHKNaK6n
Received: from localhost.localdomain by mta-snd-e05.mail.nifty.com
          with ESMTP
          id <20241205032604903.CRJS.81160.localhost.localdomain@nifty.com>;
          Thu, 5 Dec 2024 12:26:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: signal: Introduce a lock for the signal queue
Date: Thu,  5 Dec 2024 12:25:40 +0900
Message-ID: <20241205032548.29799-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733369164;
 bh=9kizsjew8eOXSQd+hyOvXYkUevZ2hGOvIYV71qesTn4=;
 h=From:To:Cc:Subject:Date;
 b=aHKNaK6nbmN6XC3+Sn71fYyRrBcRlqpUyh4uLP3ISByfapWSIM2EXBZIT3asmTC5gixe5/qY
 foj51d3wtcpt3Pd3c7ry1sge80frY0ToGyizP++hnazRic/2PWB2j53o/Q3tpZOv52sQJKqeAk
 TnhSHBdnUHNNhWKIy3P93FNN1U8epArERFWhRCF7Zxd/1jpokgJCBZ6CQQx05U+GZFq3HZ2SwH
 oSXGRPbnikxuZhB7E3X2KTi99lZWMpNoi24WGSQ1pzupuyJz8j61KPiPcPb74FmWYiDC7Ugtir
 jBoEqpXz0jS79BEQ0LUf5rk5X4KCffVmdHHnZgFcJ0ESUmdA==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, the signal queue is touched by the thread sig as well as
other threads that call sigaction_worker(). This potentially has
a possibility to destroy the signal queue chain. A possible worst
result may be a self-loop chain which causes infinite loop. With
this patch, lock()/unlock() are introduce to avoid such a situation.

Fixes: 474048c26edf ("* sigproc.cc (pending_signals::add): Just index directly into signal array rather than treating the array as a heap.")
Suggested-by: Corinna Vinschen <corinna@vinschen.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc            | 12 +++++------
 winsup/cygwin/local_includes/sigproc.h |  2 +-
 winsup/cygwin/signal.cc                |  4 ++--
 winsup/cygwin/sigproc.cc               | 28 +++++++++++++++++++++-----
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 0f8c21939..35a4a0b47 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1450,10 +1450,10 @@ _cygtls::handle_SIGCONT (threadlist_t * &tl_entry)
 	sigsent = true;
       }
   /* Clear pending stop signals */
-  sig_clear (SIGSTOP);
-  sig_clear (SIGTSTP);
-  sig_clear (SIGTTIN);
-  sig_clear (SIGTTOU);
+  sig_clear (SIGSTOP, false);
+  sig_clear (SIGTSTP, false);
+  sig_clear (SIGTTIN, false);
+  sig_clear (SIGTTOU, false);
 }
 
 int
@@ -1554,14 +1554,14 @@ sigpacket::process ()
     goto exit_sig;
   if (si.si_signo == SIGSTOP)
     {
-      sig_clear (SIGCONT);
+      sig_clear (SIGCONT, false);
       goto stop;
     }
 
   /* Clear pending SIGCONT on stop signals */
   if (si.si_signo == SIGTSTP || si.si_signo == SIGTTIN
       || si.si_signo == SIGTTOU)
-    sig_clear (SIGCONT);
+    sig_clear (SIGCONT, false);
 
   if (handler == (void *) SIG_DFL)
     {
diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
index 8b7062aae..ce7263338 100644
--- a/winsup/cygwin/local_includes/sigproc.h
+++ b/winsup/cygwin/local_includes/sigproc.h
@@ -62,7 +62,7 @@ void set_signal_mask (sigset_t&, sigset_t);
 int handle_sigprocmask (int sig, const sigset_t *set,
 				  sigset_t *oldset, sigset_t& opmask);
 
-void sig_clear (int);
+void sig_clear (int, bool);
 void sig_set_pending (int);
 int handle_sigsuspend (sigset_t);
 
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index a7af604df..0bd64963f 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -451,9 +451,9 @@ sigaction_worker (int sig, const struct sigaction *newact,
 	      if (!(gs.sa_flags & SA_NODEFER))
 		gs.sa_mask |= SIGTOMASK(sig);
 	      if (gs.sa_handler == SIG_IGN)
-		sig_clear (sig);
+		sig_clear (sig, true);
 	      if (gs.sa_handler == SIG_DFL && sig == SIGCHLD)
-		sig_clear (sig);
+		sig_clear (sig, true);
 	      if (sig == SIGCHLD)
 		{
 		  myself->process_state &= ~PID_NOCLDSTOP;
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 7e02e61f7..c4c159578 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -106,12 +106,16 @@ class pending_signals
 {
   sigpacket sigs[_NSIG + 1];
   sigpacket start;
+  SRWLOCK queue_lock;
   bool retry;
+  void lock () { AcquireSRWLockExclusive (&queue_lock); }
+  void unlock () { ReleaseSRWLockExclusive (&queue_lock); }
 
 public:
+  pending_signals (): queue_lock (SRWLOCK_INIT) {}
   void add (sigpacket&);
   bool pending () {retry = !!start.next; return retry;}
-  void clear (int sig);
+  void clear (int sig, bool need_lock);
   void clear (_cygtls *tls);
   friend void sig_dispatch_pending (bool);
   friend void wait_sig (VOID *arg);
@@ -427,23 +431,27 @@ proc_terminate ()
 
 /* Clear pending signal */
 void
-sig_clear (int sig)
+sig_clear (int sig, bool need_lock)
 {
-  sigq.clear (sig);
+  sigq.clear (sig, need_lock);
 }
 
 /* Clear pending signals of specific si_signo.
    Called from sigpacket::process(). */
 void
-pending_signals::clear (int sig)
+pending_signals::clear (int sig, bool need_lock)
 {
   sigpacket *q = sigs + sig;
   if (!sig || !q->si.si_signo)
     return;
+  if (need_lock)
+    lock ();
   q->si.si_signo = 0;
   q->prev->next = q->next;
   if (q->next)
     q->next->prev = q->prev;
+  if (need_lock)
+    unlock ();
 }
 
 /* Clear pending signals of specific thread.  Called under TLS lock from
@@ -453,6 +461,7 @@ pending_signals::clear (_cygtls *tls)
 {
   sigpacket *q = &start;
 
+  lock ();
   while ((q = q->next))
     if (q->sigtls == tls)
       {
@@ -461,6 +470,7 @@ pending_signals::clear (_cygtls *tls)
 	if (q->next)
 	  q->next->prev = q->prev;
       }
+  unlock ();
 }
 
 /* Clear pending signals of specific thread.  Called from _cygtls::remove */
@@ -1313,11 +1323,13 @@ pending_signals::add (sigpacket& pack)
   if (se->si.si_signo)
     return;
   *se = pack;
+  lock ();
   se->next = start.next;
   se->prev = &start;
   se->prev->next = se;
   if (se->next)
     se->next->prev = se;
+  unlock ();
 }
 
 /* Process signals by waiting for signal data to arrive in a pipe.
@@ -1398,6 +1410,7 @@ wait_sig (VOID *)
 	    bool issig_wait;
 
 	    *pack.mask = 0;
+	    sigq.lock ();
 	    while ((q = q->next))
 	      {
 		_cygtls *sigtls = q->sigtls ?: _main_tls;
@@ -1411,6 +1424,7 @@ wait_sig (VOID *)
 		      }
 		  }
 	      }
+	    sigq.unlock ();
 	  }
 	  break;
 	case __SIGPENDING:
@@ -1419,6 +1433,7 @@ wait_sig (VOID *)
 
 	    *pack.mask = 0;
 	    tl_entry = cygheap->find_tls (pack.sigtls);
+	    sigq.lock ();
 	    while ((q = q->next))
 	      {
 		/* Skip thread-specific signals for other threads. */
@@ -1427,6 +1442,7 @@ wait_sig (VOID *)
 		if (pack.sigtls->sigmask & (bit = SIGTOMASK (q->si.si_signo)))
 		  *pack.mask |= bit;
 	      }
+	    sigq.unlock ();
 	    cygheap->unlock_tls (tl_entry);
 	  }
 	  break;
@@ -1461,7 +1477,7 @@ wait_sig (VOID *)
 	  break;
 	default:	/* Normal (positive) signal */
 	  if (pack.si.si_signo < 0)
-	    sig_clear (-pack.si.si_signo);
+	    sig_clear (-pack.si.si_signo, true);
 	  else
 	    sigq.add (pack);
 	  fallthrough;
@@ -1474,6 +1490,7 @@ wait_sig (VOID *)
 	    {
 	      /* Check the queue for signals.  There will always be at least one
 		 thing on the queue if this was a valid signal.  */
+	      sigq.lock ();
 	      while ((q = q->next))
 		{
 		  if (q->si.si_signo && q->process () > 0)
@@ -1484,6 +1501,7 @@ wait_sig (VOID *)
 			q->next->prev = q->prev;
 		    }
 		}
+	      sigq.unlock ();
 	      /* At least one signal still queued?  The event is used in select
 		 only, and only to decide if WFMO should wake up in case a
 		 signalfd is waiting via select/poll for being ready to read a
-- 
2.45.1


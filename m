Return-Path: <SRS0=Nh8N=V2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.177])
	by sourceware.org (Postfix) with ESMTPS id ECF413858D1E
	for <cygwin-patches@cygwin.com>; Fri,  7 Mar 2025 12:16:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ECF413858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ECF413858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.177
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741349809; cv=none;
	b=vvU+Z9w2nagRwZxh9HQ6JImteeTTVbba1d830G96xT+bDJ1P5e48e/8ClkkAa7H6Mm/AnDKVhS5Ai0biL4XvBMZO2Z31dMA2RvpQ3o1uBHQJJM6UJS5tQ6MHfJNzOow+JfS1Y3v7eARUDszClO294KV6Yl0Khi2nhRymTP3NnoU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741349809; c=relaxed/simple;
	bh=0bzQXeX5cR1YLCpdNQJgBhCian3isyxCBgpIFZGhr7w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=X99mOM0lBMBK6gVXeLh0JM6G7y5Nh2+JRFoPiobFKBj515Mpl//3YkL8d20sC6ukvKGrJrtthA2jnao+sj3MfGSC2cyZqtoL216St0cVB+QUDUutmdAEu4iiX7QPsDizAweiR3TC6/6WwgCCNd/sWaKpY9bixCzomn3fjalkctE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ECF413858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hqTYZCm9
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250307121645431.LIYC.48098.localhost.localdomain@nifty.com>;
          Fri, 7 Mar 2025 21:16:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: signa: Redesign signal queue handling
Date: Fri,  7 Mar 2025 21:16:17 +0900
Message-ID: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741349805;
 bh=EvGeIeC7WUTmhBTg5IlL1xtm9FGfdgEVXFwaXOpV8EQ=;
 h=From:To:Cc:Subject:Date;
 b=hqTYZCm92ScvMLOvBIyIGl+0n6Ts8Mw18bz5RqnnVsZsaNqqyoHRhZLyVZSyu/82AW4+nVsZ
 tZmPTWhDwnfIr0NGd7/K8Wbub8WmaFt/ilaSEuTuz03gaWOrIbl6Qh038xra8WTDsL3BuJ3ppo
 e5xqhJAE/JFETFHl/B642PI2Hl6HhyfQbSJVfQp1orgiJl0GUXSEVF5G2Niqi8JvPQLmmvTkXv
 gCEjcMnaeUchvDtbY+vliRx266B1MD7Y0S2y4B10LOiUBbfOyejyKRYbd9+ij1xR+bDrm2H4IY
 QWqRkcC2wAiwNuCxFENJV7fOKTEeRggOWEzzKPzmfbQXKd0w==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SCC_5_SHORT_WORD_LINES,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The previous implementation of the signal queue behaves as:
1) Signals in the queue are processed in a disordered manner.
2) If the same signal is already in the queue, new signal is discarded.

Strictly speaking, these behaviours do not violate POSIX. However,
these could be a cause of unexpected behaviour in some software. In
Linux, some important signals such as SIGSTOP/SIGCONT do not seem to
behave like that.

With this patch prevents all signals from that issues by redesigning
the signal queue, Only the exception is the case that the process is
in the PID_STOPPED state. In this case, SIGCONT/SIGKILL should be
processed prior to the other signals in the queue.

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
Fixes: 7ac6173643b1 ("(pending_signals): New class.")
Reported by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc            |  16 +---
 winsup/cygwin/local_includes/sigproc.h |   1 +
 winsup/cygwin/sigproc.cc               | 113 +++++++++++++++++++------
 3 files changed, 88 insertions(+), 42 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 68c7af16a..5de490d08 100644
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
diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
index ce7263338..d3884dae6 100644
--- a/winsup/cygwin/local_includes/sigproc.h
+++ b/winsup/cygwin/local_includes/sigproc.h
@@ -53,6 +53,7 @@ struct sigpacket
   };
   struct sigpacket *next;
   struct sigpacket *prev;
+  int usecount;
   int process ();
   int setup_handler (void *, struct sigaction&, _cygtls *);
 };
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8739f18f5..5c1e544d1 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -21,6 +21,7 @@ details. */
 #include "cygtls.h"
 #include "ntdll.h"
 #include "exception.h"
+#include <assert.h>
 
 /*
  * Convenience defines
@@ -28,6 +29,10 @@ details. */
 #define WSSC		  60000	// Wait for signal completion
 #define WPSP		  40000	// Wait for proc_subproc mutex
 
+#define PIPE_DEPTH 64
+#define SIGQ_ROOM 4
+#define SIGQ_DEPTH (PIPE_DEPTH + SIGQ_ROOM*2) /* Must be larger than pipe. */
+
 /*
  * Global variables
  */
@@ -104,21 +109,23 @@ static void wait_sig (VOID *arg);
 
 class pending_signals
 {
-  sigpacket sigs[_NSIG + 1];
+  sigpacket sigs[SIGQ_DEPTH];
   sigpacket start;
+  int queue_left;
   SRWLOCK queue_lock;
   bool retry;
   void lock () { AcquireSRWLockExclusive (&queue_lock); }
   void unlock () { ReleaseSRWLockExclusive (&queue_lock); }
 
 public:
-  pending_signals (): queue_lock (SRWLOCK_INIT) {}
+  pending_signals (): queue_left (SIGQ_DEPTH), queue_lock (SRWLOCK_INIT) {}
   void add (sigpacket&);
   bool pending () {retry = !!start.next; return retry;}
   void clear (int sig, bool need_lock);
   void clear (_cygtls *tls);
   friend void sig_dispatch_pending (bool);
   friend void wait_sig (VOID *arg);
+  friend sigset_t sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls);
 };
 
 static NO_COPY pending_signals sigq;
@@ -441,15 +448,23 @@ sig_clear (int sig, bool need_lock)
 void
 pending_signals::clear (int sig, bool need_lock)
 {
-  sigpacket *q = sigs + sig;
-  if (!sig || !q->si.si_signo)
+  sigpacket *q = &start;
+
+  if (!sig)
     return;
+
   if (need_lock)
     lock ();
-  q->si.si_signo = 0;
-  q->prev->next = q->next;
-  if (q->next)
-    q->next->prev = q->prev;
+  while ((q = q->next))
+    if (q->si.si_signo == sig)
+      {
+	q->si.si_signo = 0;
+	q->usecount = 0;
+	q->prev->next = q->next;
+	if (q->next)
+	  q->next->prev = q->prev;
+	queue_left++;
+      }
   if (need_lock)
     unlock ();
 }
@@ -466,9 +481,11 @@ pending_signals::clear (_cygtls *tls)
     if (q->sigtls == tls)
       {
 	q->si.si_signo = 0;
+	q->usecount = 0;
 	q->prev->next = q->next;
 	if (q->next)
 	  q->next->prev = q->prev;
+	queue_left++;
       }
   unlock ();
 }
@@ -509,7 +526,7 @@ sigproc_init ()
   char char_sa_buf[1024];
   PSECURITY_ATTRIBUTES sa = sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
   DWORD err = fhandler_pipe::create (sa, &my_readsig, &my_sendsig,
-				     _NSIG * sizeof (sigpacket), "sigwait",
+				     PIPE_DEPTH * sizeof (sigpacket), "sigwait",
 				     PIPE_ADD_PID);
   if (err)
     {
@@ -587,6 +604,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   int rc = 1;
   bool its_me;
   HANDLE sendsig;
+  HANDLE mtx;
   sigpacket pack;
   bool communing = si.si_signo == __SIGCOMMUNE;
 
@@ -611,6 +629,20 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       p = myself;
     }
 
+  char mtx_name[MAX_PATH];
+  mtx = CreateMutex (&sec_none_nih, FALSE,
+		     shared_name (mtx_name, "sig_send", p->pid));
+  cygwait (mtx, INFINITE);
+  if (si.si_signo == __SIGFLUSHFAST && sigq.queue_left < PIPE_DEPTH)
+    while (sigq.queue_left < PIPE_DEPTH + SIGQ_ROOM)
+      if (WAIT_SIGNALED == cygwait (NULL, 10, cw_sig_eintr))
+	{
+	  ReleaseMutex (mtx);
+	  _my_tls.call_signal_handler ();
+	  cygwait (mtx, INFINITE);
+	  continue;
+	}
+
   /* If myself is the stub process, send signal to the child process
      rather than myself. The fact that myself->dwProcessId is not equal
      to the current process id indicates myself is the stub process. */
@@ -757,6 +789,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       cygwait (NULL, 10, cw_mask);
       res = 0;
     }
+  ReleaseMutex (mtx);
+  CloseHandle (mtx);
 
   if (!res)
     {
@@ -1311,23 +1345,37 @@ talktome (siginfo_t *si)
     new cygthread (commune_process, size, si, "commune");
 }
 
-/* Add a packet to the beginning of the queue.
-   Should only be called from signal thread.  */
+/* Add a packet to the end of the queue to process signals
+   in the correct order. Should only be called from signal thread.  */
 void
 pending_signals::add (sigpacket& pack)
 {
-  sigpacket *se;
+  sigpacket *se = NULL, *q = &start;
 
-  se = sigs + pack.si.si_signo;
-  if (se->si.si_signo)
-    return;
-  *se = pack;
   lock ();
-  se->next = start.next;
-  se->prev = &start;
-  se->prev->next = se;
-  if (se->next)
-    se->next->prev = se;
+  assert (queue_left > 0);
+
+  while (q->next)
+    q = q->next;
+  if (q->si.si_signo == pack.si.si_signo)
+    q->usecount++;
+  else
+    {
+      for (int i = 0; i < SIGQ_DEPTH; i++)
+	if (sigs[i].si.si_signo == 0)
+	  {
+	    se = sigs + i;
+	    *se = pack;
+	    break;
+	  }
+      assert (se != NULL);
+      queue_left--;
+
+      se->usecount = 1;
+      q->next = se;
+      se->next = NULL;
+      se->prev = q;
+    }
   unlock ();
 }
 
@@ -1354,9 +1402,9 @@ wait_sig (VOID *)
     {
       DWORD nb;
       sigpacket pack = {};
-      if (sigq.retry)
+      if (sigq.retry || (sigq.queue_left == 0 && !sig_held))
 	pack.si.si_signo = __SIGFLUSH;
-      else if (sigq.start.next
+      else if (sigq.start.next && !sig_held
 	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
 	{
 	  Sleep (GetTickCount () - t0 > 10 ? 1 : 0);
@@ -1501,11 +1549,22 @@ wait_sig (VOID *)
 		{
 		  if (q->si.si_signo && q->process () > 0)
 		    {
-		      q->si.si_signo = 0;
-		      q->prev->next = q->next;
-		      if (q->next)
-			q->next->prev = q->prev;
+		      if (--q->usecount == 0)
+			{
+			  q->si.si_signo = 0;
+			  q->prev->next = q->next;
+			  if (q->next)
+			    q->next->prev = q->prev;
+			  sigq.queue_left++;
+			}
+		      else
+			q = q->prev;
 		    }
+		  else if (NOTSTATE (myself, PID_STOPPED))
+		    /* Stop processing further to prevent signals from
+		       being processed in a disorderd manner, except for
+		       the process is in the PID_STOPPED state. */
+		    break;
 		}
 	      sigq.unlock ();
 	      /* At least one signal still queued?  The event is used in select
-- 
2.45.1


Return-Path: <SRS0=UdKb=V6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 46A26385840E
	for <cygwin-patches@cygwin.com>; Tue, 11 Mar 2025 08:48:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 46A26385840E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 46A26385840E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741682880; cv=none;
	b=BmRnRuqHV/CUrhp3zlR/EGdFWQBb/gYx62TJzc8lgdARnqyMe4Av8G1dgy6v0ukGpNaE5FdghU2fNufeHSHscoQNWhE9whsxzvHhMy7G0pNhxc4REfgTNfMAqd/Aq7wtPACq8enn6MwS+L5WuesIh7Eae7REupE9wyOz8TfJ310=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741682880; c=relaxed/simple;
	bh=qNz2saoir9931w42ZipsM/t6dTQUI5LSh/PlPCdzZqw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=OpvH2MALMpv+Z0LutLhb91e1XcA1Hg2tIdcT9ayNmZZC5sso0iOZIDifgnUcMoqb26dzlWOpSbccfiTX/h7hfQHbcdRn2iqibwyA7Z1B7ovN+1SLL8LJoNPFg/Wq6WZqjbRwAQ+6jFCVYFh7q3B/Xi7gMDzEl2N/MBTi+RdTYX8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 46A26385840E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Gxc2yZZA
Received: from localhost.localdomain by mta-snd-w04.mail.nifty.com
          with ESMTP
          id <20250311084758136.VPGN.109987.localhost.localdomain@nifty.com>;
          Tue, 11 Mar 2025 17:47:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: signal: Redesign signal queue handling
Date: Tue, 11 Mar 2025 17:47:28 +0900
Message-ID: <20250311084741.1143-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741682878;
 bh=03xk27dLaU6at04FK60vG/1U1RMZJsflzY2nZUBPVeA=;
 h=From:To:Cc:Subject:Date;
 b=Gxc2yZZAOz94bDbgW7/38zCO2d+nDSGrPxBKFeWoizi94w2aAEP5lWemDSFgKUIB2Zf6qGMa
 Tcme2dQa8Uuy/l27rEU8oyMlYpBAzNYKElJWL0wk4aHTWYNgaCQux3y7qbhcAU+LtLnF9NiePI
 qJ2Gg6oT2SUnrvvP5YseK+PpAD7D7FffwuAFPQcwWh5P7x2BLouh4hRF9188A4txmFSrLKvRMl
 xv89HyTahklqa5rTU6MMO4BBFp5ITnz9+KyuONTcAxdZGoGYmheY0OiYGf04XrI86jjmjXa6Qs
 IvFoE2tRE58/lypjMcCR1uDnUMqtPcBATaH3jvjiPwl70Grg==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SCC_5_SHORT_WORD_LINES,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The previous implementation of the signal queue behaves as:
1) Signals in the queue are processed in a disordered manner.
2) If the same signal is already in the queue, new signal is discarded.

Strictly speaking, these behaviours do not violate POSIX. However,
these could be a cause of unexpected behaviour in some software. In
Linux, some important signals such as SIGSTOP/SIGCONT do not seem to
behave like that.
This patch prevents SIGKILL, SIGSTOP, SIGCONT, and SIGRT* from that
issue. Moreover, if SA_SIGINFO is set in sa_flags, the signal is
treated almost as the same.

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
Fixes: 7ac6173643b1 ("(pending_signals): New class.")
Reported by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Christian Franke <Christian.Franke@t-online.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc |  21 +----
 winsup/cygwin/sigproc.cc    | 176 +++++++++++++++++++++++++++++++-----
 2 files changed, 158 insertions(+), 39 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 68c7af16a..101a9e953 100644
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
@@ -1488,7 +1482,10 @@ sigpacket::process ()
     }
   else if (ISSTATE (myself, PID_STOPPED))
     {
-      rc = -1;		/* Don't send signals when stopped */
+      if (si.si_signo == SIGSTOP)
+	rc = 1;		/* Ignore (discard) SIGSTOP */
+      else
+	rc = -1;	/* Don't send signals when stopped */
       goto done;
     }
   else if (!sigtls)
@@ -1547,15 +1544,7 @@ sigpacket::process ()
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
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8739f18f5..ecd289a5f 100644
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
 
+#define PIPE_DEPTH _NSIG /* Historically, the pipe size is _NSIG packet */
+#define SIGQ_ROOM 4
+#define SIGQ_DEPTH (PIPE_DEPTH + SIGQ_ROOM)
+
 /*
  * Global variables
  */
@@ -93,6 +98,10 @@ static NO_COPY HANDLE my_readsig;
 /* Used in select if a signalfd is part of the read descriptor set */
 HANDLE NO_COPY my_pendingsigs_evt;
 
+/* Used by sig_send() with __SIGFLUSHFAST */
+static NO_COPY HANDLE sigflush_evt;
+static NO_COPY HANDLE sigflush_done_evt;
+
 /* Function declarations */
 static int checkstate (waitq *);
 static __inline__ bool get_proc_lock (DWORD, DWORD);
@@ -104,21 +113,23 @@ static void wait_sig (VOID *arg);
 
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
@@ -441,15 +452,22 @@ sig_clear (int sig, bool need_lock)
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
+	q->prev->next = q->next;
+	if (q->next)
+	  q->next->prev = q->prev;
+	queue_left++;
+      }
   if (need_lock)
     unlock ();
 }
@@ -469,6 +487,7 @@ pending_signals::clear (_cygtls *tls)
 	q->prev->next = q->next;
 	if (q->next)
 	  q->next->prev = q->prev;
+	queue_left++;
       }
   unlock ();
 }
@@ -509,7 +528,7 @@ sigproc_init ()
   char char_sa_buf[1024];
   PSECURITY_ATTRIBUTES sa = sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
   DWORD err = fhandler_pipe::create (sa, &my_readsig, &my_sendsig,
-				     _NSIG * sizeof (sigpacket), "sigwait",
+				     PIPE_DEPTH * sizeof (sigpacket), "sigwait",
 				     PIPE_ADD_PID);
   if (err)
     {
@@ -519,6 +538,8 @@ sigproc_init ()
   ProtectHandle (my_readsig);
   myself->sendsig = my_sendsig;
   my_pendingsigs_evt = CreateEvent (NULL, TRUE, FALSE, NULL);
+  sigflush_evt = CreateEvent (NULL, FALSE, FALSE, NULL);
+  sigflush_done_evt = CreateEvent (NULL, FALSE, FALSE, NULL);
   if (!my_pendingsigs_evt)
     api_fatal ("couldn't create pending signal event, %E");
 
@@ -587,6 +608,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   int rc = 1;
   bool its_me;
   HANDLE sendsig;
+  HANDLE mtx;
   sigpacket pack;
   bool communing = si.si_signo == __SIGCOMMUNE;
 
@@ -745,6 +767,37 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   unsigned cw_mask;
   cw_mask = pack.si.si_signo == __SIGFLUSHFAST ? 0 : cw_sig_restart;
 
+  char mtx_name[MAX_PATH];
+  shared_name (mtx_name, "sig_send", p->pid);
+  mtx = CreateMutex (&sec_none_nih, FALSE, mtx_name);
+  cygwait (mtx, INFINITE, cw_mask);
+
+  if (its_me && si.si_signo == __SIGFLUSHFAST)
+    {
+      /* Currently, __SIGFLUSH is automatically processed in wait_sig() by
+	 itself if pending signals exist. Therefore, sending __SIGFLUSH* is
+	 not absolutely necessary. So, if there is not enough space in the
+	 queue or the pipe, do not send __SIGFLUSHFAST to avoid deadlock. */
+      IO_STATUS_BLOCK io;
+      FILE_PIPE_LOCAL_INFORMATION fpli;
+      fpli.WriteQuotaAvailable = 0;
+      NtQueryInformationFile (my_sendsig, &io, &fpli, sizeof (fpli),
+			      FilePipeLocalInformation);
+      int pkts_in_pipe =
+	PIPE_DEPTH - fpli.WriteQuotaAvailable / sizeof (sigpacket);
+      if (sigq.queue_left < pkts_in_pipe + 2
+	  || fpli.WriteQuotaAvailable < sizeof (sigpacket))
+	{
+	  ReleaseMutex (mtx);
+	  CloseHandle (mtx);
+	  ResetEvent (sigflush_done_evt);
+	  SetEvent (sigflush_evt);
+	  cygwait (sigflush_done_evt, INFINITE, cw_mask);
+	  rc = 0;
+	  goto out;
+	}
+    }
+
   DWORD nb;
   BOOL res;
   /* Try multiple times to send if packsize != nb since that probably
@@ -754,9 +807,13 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       res = WriteFile (sendsig, leader, packsize, &nb, NULL);
       if (!res || packsize == nb)
 	break;
+      ReleaseMutex (mtx);
       cygwait (NULL, 10, cw_mask);
+      cygwait (mtx, INFINITE, cw_mask);
       res = 0;
     }
+  ReleaseMutex (mtx);
+  CloseHandle (mtx);
 
   if (!res)
     {
@@ -1311,23 +1368,85 @@ talktome (siginfo_t *si)
     new cygthread (commune_process, size, si, "commune");
 }
 
-/* Add a packet to the beginning of the queue.
+static inline bool
+is_sigsys (int sig)
+{
+  return sig == SIGKILL || sig == SIGSTOP || sig == SIGCONT;
+}
+
+static inline bool
+is_sigrt (int sig)
+{
+  return sig >= SIGRTMIN && sig <= SIGRTMAX;
+}
+
+static inline bool
+is_sigsysrt (int sig)
+{
+  return is_sigsys (sig) || is_sigrt (sig);
+}
+
+/* Add a packet to the end of the queue to process signals
+   in the order they are issued except for SIGRT*.
    Should only be called from signal thread.  */
 void
 pending_signals::add (sigpacket& pack)
 {
-  sigpacket *se;
+  sigpacket *se = NULL, *q = &start;
+  bool queue_once = !is_sigsysrt (pack.si.si_signo)
+    && !(global_sigs[pack.si.si_signo].sa_flags & SA_SIGINFO);
 
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
+  if (pack.si.si_signo != SIGKILL)
+    while (q->next)
+      {
+	/* Linux man signal(7) says:
+	   "If different real-time signals are sent to a process, they are
+	   delivered starting with the lowest-numbered signal." */
+	if (is_sigrt (q->next->si.si_signo) && is_sigrt (pack.si.si_signo)
+	    && q->next->si.si_signo > pack.si.si_signo)
+	  break;
+	/* Linux man signal(7) says:
+	   "If both standard and real-time signals are pending for a process,
+	   POSIX leaves it unspecified which is delivered first.  Linux, like
+	   many other implementations, gives priority to standard signals in
+	   this case." */
+	if (is_sigrt (q->next->si.si_signo) && !is_sigrt (pack.si.si_signo))
+	  break;
+	q = q->next;
+	/* Linux man signal(7) says:
+	   "if multiple instances of a standard signal are delivered while
+	   that signal is currently blocked, then only one instance is
+	   queued." */
+	/* POSIX.1-2004 says on sigaction():
+	   "If SA_SIGINFO is set in sa_flags, then subsequent occurrences
+	   of sig generated by sigqueue() or as a result of any signal-
+	   generating function that supports the specification of an
+	   application-defined value (when sig is already pending) shall
+	   be queued in FIFO order until delivered or accepted;" */
+	if (queue_once && q->si.si_signo == pack.si.si_signo)
+	  {
+	    unlock ();
+	    return;
+	  }
+      }
+
+  assert (queue_left > 0);
+  for (int i = 0; i < SIGQ_DEPTH; i++)
+    if (sigs[i].si.si_signo == 0)
+      {
+	se = sigs + i;
+	*se = pack;
+	break;
+      }
+  assert (se != NULL);
+  queue_left--;
+
+  if (q->next)
+    q->next->prev = se;
+  se->next = q->next;
+  se->prev = q;
+  q->next = se;
   unlock ();
 }
 
@@ -1354,12 +1473,14 @@ wait_sig (VOID *)
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
-	  Sleep (GetTickCount () - t0 > 10 ? 1 : 0);
+	  yield ();
+	  if (GetTickCount () - t0 > 10)
+	    WaitForSingleObject (sigflush_evt, 1);
 	  pack.si.si_signo = __SIGFLUSH;
 	}
       else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
@@ -1505,7 +1626,15 @@ wait_sig (VOID *)
 		      q->prev->next = q->next;
 		      if (q->next)
 			q->next->prev = q->prev;
+		      sigq.queue_left++;
 		    }
+		  else if (is_sigsysrt (q->si.si_signo)
+		       || ((global_sigs[q->si.si_signo].sa_flags & SA_SIGINFO)
+			   && NOTSTATE (myself, PID_STOPPED)))
+		    /* Stop processing further to prevent the signals from
+		       being processed in a disorderd manner if the signal
+		       is a realtime signal or SA_SIGINFO is set. */
+		    break;
 		}
 	      sigq.unlock ();
 	      /* At least one signal still queued?  The event is used in select
@@ -1526,6 +1655,7 @@ wait_sig (VOID *)
       if (clearwait && !have_execed)
 	proc_subproc (PROC_CLEARWAIT, 0);
 skip_process_signal:
+      SetEvent (sigflush_done_evt);
       if (pack.wakeup)
 	{
 	  sigproc_printf ("signalling pack.wakeup %p", pack.wakeup);
-- 
2.45.1


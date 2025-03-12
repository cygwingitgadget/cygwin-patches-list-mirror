Return-Path: <SRS0=oSj3=V7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 4768F3858D21
	for <cygwin-patches@cygwin.com>; Wed, 12 Mar 2025 03:28:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4768F3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4768F3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741750103; cv=none;
	b=lcLOplpm/Vzq3Ewb0D+qldQmggriXWUBgjMIM5g5CvR+5BjJXjTSc/jSW2+bzStaHfmeMAwlXH9i8uZnIOb07syb8jHjUNckErOuIdReYfRdIi78kF6JTEWmZ3cBe2t26Zc5Zu2fwTst1sGldLqFQW6WH0QiUT5RAlwP7l5iX6o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741750103; c=relaxed/simple;
	bh=NK+sBCVuWBqr6AH3XKp+nIoGpxnwWwGxr8WcRIL2d1E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vrNfTSUvWBvzCx0nMJ14Wj+SNhhMs6wL3ifKq25yCAOybnlo043zGvGv4bDG0a9Go0xjjTXrjCPXomsITjlKbvjANQjFKvMu9+QXcOiNWRB5oav8/o9y/kISacy60+jRbDIg6TTkUr2CS11YYZcowmatFPpERgX/4S2uH34BXlk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4768F3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HrQDI7af
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250312032820199.XTRO.17135.localhost.localdomain@nifty.com>;
          Wed, 12 Mar 2025 12:28:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 1/6] Cygwin: signal: Redesign signal queue handling
Date: Wed, 12 Mar 2025 12:27:27 +0900
Message-ID: <20250312032748.233077-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741750100;
 bh=lwrdXNH+vsd7bhWKvd7XSGVbkmx/jo5SCIJaBij0G70=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HrQDI7afoUpgKY26zzzipm0AiWXo11Ana6fNduvC0/gAM9+KJRdPrepXkGJ7Rk67HPeYOK1B
 SyvNppPUh8TmDOIASIj82RIWSAda6aP+TmVZlpN1PS0rSGjIZICtkI/udvR31RIZXwH6TIHRf8
 4JNQ3Cq+i8Xorj+IJVPUdggqjZMZ5r8a+uACszXIKb+XTaX0df0hjavIzxzmz6nxqDI+1NTNkU
 JjsmVtH/yGSGBwdaIjzdNhcMsyQM0w8JX7yCuKnKie3gWcyB1HX+xUGobFNEShqFlJaa8K46Tt
 gDIkx2DIVEkhLyjbtRnDzXSW/dVKvz/DH4dE1u0uxcZ5s7MA==
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
 winsup/cygwin/sigproc.cc | 128 ++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8739f18f5..ab3acfd24 100644
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
@@ -104,15 +109,16 @@ static void wait_sig (VOID *arg);
 
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
@@ -441,15 +447,22 @@ sig_clear (int sig, bool need_lock)
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
@@ -469,6 +482,7 @@ pending_signals::clear (_cygtls *tls)
 	q->prev->next = q->next;
 	if (q->next)
 	  q->next->prev = q->prev;
+	queue_left++;
       }
   unlock ();
 }
@@ -509,7 +523,7 @@ sigproc_init ()
   char char_sa_buf[1024];
   PSECURITY_ATTRIBUTES sa = sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
   DWORD err = fhandler_pipe::create (sa, &my_readsig, &my_sendsig,
-				     _NSIG * sizeof (sigpacket), "sigwait",
+				     PIPE_DEPTH * sizeof (sigpacket), "sigwait",
 				     PIPE_ADD_PID);
   if (err)
     {
@@ -1311,23 +1325,85 @@ talktome (siginfo_t *si)
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
 
@@ -1354,12 +1430,12 @@ wait_sig (VOID *)
     {
       DWORD nb;
       sigpacket pack = {};
-      if (sigq.retry)
+      if (sigq.retry || sigq.queue_left == 0)
 	pack.si.si_signo = __SIGFLUSH;
       else if (sigq.start.next
 	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
 	{
-	  Sleep (GetTickCount () - t0 > 10 ? 1 : 0);
+	  Sleep ((sig_held || GetTickCount () - t0 > 10) ? 1 : 0);
 	  pack.si.si_signo = __SIGFLUSH;
 	}
       else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
@@ -1505,7 +1581,15 @@ wait_sig (VOID *)
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
-- 
2.45.1


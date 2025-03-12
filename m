Return-Path: <SRS0=oSj3=V7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 5F33C3858C2D
	for <cygwin-patches@cygwin.com>; Wed, 12 Mar 2025 03:28:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F33C3858C2D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F33C3858C2D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741750132; cv=none;
	b=x5TxA/Gw/y3LSZF09m6Jx8EMc/GV299NxgGHiQ98y/URW8RDxV+d0Ou5AiO/QFQVLEpwBl2TUGOUxnUNngX3M3uBJj5sdThhx25sSpXi4Sci6vdg76dHILkB9liGfJ6RdmjezZvT4vHqA2RNfQmo7gBsI7VXQO8dAH55ZM4rrlM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741750132; c=relaxed/simple;
	bh=iT+aGeQY1yHrLqC/ICCrR5mzoZwplKuc7LwC6kYEDnM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qn8lE18nWE/OWyZsWVLfkMSvcim9hVxSa4F4dfibCDu3uyMbRyWYb4qbpza74By/H88fmezuSDneuksOzAyO0iAFTpJHKvj7/p89xvT0RCw+vE400LSeJP7jO4M+Ytpvuau9gnmaxWTJKPWNeuzPtB5i3ULHx4Un+J14WLUv1yo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F33C3858C2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=n884wYCu
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250312032844224.XTSC.17135.localhost.localdomain@nifty.com>;
          Wed, 12 Mar 2025 12:28:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v3 4/6] Cygwin: signal: Do not send __SIGFLUSHFAST if the pipe/queue is full
Date: Wed, 12 Mar 2025 12:27:30 +0900
Message-ID: <20250312032748.233077-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741750124;
 bh=Km7hBAfhH1cixUgFl4LUqlBaaXP7y0tL+nlXo9/qrvQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n884wYCusCjOvKDU6rt8JzgpygoTrOTxBsQGnZTWH6kEREkvP8bqAfxDnh85gR2ja+xwyXC1
 iy8w6+jcV/VBsRJB2um9DVYQBEAne1VvSAQ7eL/4A2Kmm+hmlWuTOio/BmeaxCN77600bTacWT
 CO/lROP6TmmuWSxv8LpxodLg3wiSbPv2N5PdiTXw7/SgJfgMnDG5U/N463Xo5fPnV/9MTFBmWC
 p8DEf0L3W7S2azafos+j7sannRExjuOMiSibx5FWJ2PSQ62F7jhwaUb3FacPoHiOtqTxpi+62Y
 J6IRd/JU5CJ4Cxmbif9OOPwsGWr7aXB+Dibh/AdfV/dBf2qw==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If __SIGFLUSHFAST is sent while the signal queue or the pipe is full,
it causes deadlock. The mechanism is as follows.

When sending __SIGFLUSHFAST, sig_send() waits for response (wakeup
event) from wait_sig(). Therefore, the main thread does not process
signals while waiting the wakeup event. However, if main thread
does not process signals, signals in the queue are not dequeued.
As a result, the sigpacket for __SIGFLUSHFAST stays in the signal
pipe and not being processed. Thus the wakeup event will never be
triggered.

This did not occur with old signal queue design, because the queue
never becomes full. This patch use alternative way for flushing
the queue if the queue and the pipe is full, i.e., sending a event
to trigger flushing in wait_sig().

Addresses: https://cygwin.com/pipermail/cygwin-patches/2025q1/013461.html
Fixes: XXXXXXXXXXXX ("Cygwin: signal: Redesign signal queue handling")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 48 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index ab3acfd24..8f1eb142a 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -98,6 +98,10 @@ static NO_COPY HANDLE my_readsig;
 /* Used in select if a signalfd is part of the read descriptor set */
 HANDLE NO_COPY my_pendingsigs_evt;
 
+/* Used by sig_send() with __SIGFLUSHFAST */
+static NO_COPY HANDLE sigflush_evt;
+static NO_COPY HANDLE sigflush_done_evt;
+
 /* Function declarations */
 static int checkstate (waitq *);
 static __inline__ bool get_proc_lock (DWORD, DWORD);
@@ -125,6 +129,7 @@ public:
   void clear (_cygtls *tls);
   friend void sig_dispatch_pending (bool);
   friend void wait_sig (VOID *arg);
+  friend sigset_t sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls);
 };
 
 static NO_COPY pending_signals sigq;
@@ -533,6 +538,8 @@ sigproc_init ()
   ProtectHandle (my_readsig);
   myself->sendsig = my_sendsig;
   my_pendingsigs_evt = CreateEvent (NULL, TRUE, FALSE, NULL);
+  sigflush_evt = CreateEvent (NULL, FALSE, FALSE, NULL);
+  sigflush_done_evt = CreateEvent (NULL, FALSE, FALSE, NULL);
   if (!my_pendingsigs_evt)
     api_fatal ("couldn't create pending signal event, %E");
 
@@ -601,6 +608,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
   int rc = 1;
   bool its_me;
   HANDLE sendsig;
+  HANDLE mtx;
   sigpacket pack;
   bool communing = si.si_signo == __SIGCOMMUNE;
 
@@ -759,6 +767,37 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
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
@@ -768,9 +807,13 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
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
@@ -1435,7 +1478,9 @@ wait_sig (VOID *)
       else if (sigq.start.next
 	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
 	{
-	  Sleep ((sig_held || GetTickCount () - t0 > 10) ? 1 : 0);
+	  yield ();
+	  if (sig_held || GetTickCount () - t0 > 10)
+	    WaitForSingleObject (sigflush_evt, 1);
 	  pack.si.si_signo = __SIGFLUSH;
 	}
       else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
@@ -1610,6 +1655,7 @@ wait_sig (VOID *)
       if (clearwait && !have_execed)
 	proc_subproc (PROC_CLEARWAIT, 0);
 skip_process_signal:
+      SetEvent (sigflush_done_evt);
       if (pack.wakeup)
 	{
 	  sigproc_printf ("signalling pack.wakeup %p", pack.wakeup);
-- 
2.45.1


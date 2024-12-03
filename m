Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 6AF653858C48
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 14:02:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6AF653858C48
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6AF653858C48
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733234575; cv=none;
	b=DF7XHPVixspo2IdbOOf6NYVhgLViEjLoOzL+bwIOU2EZVt6E++rApyzghwfO5DtLUFspOiOAg57SCHVXKR6RowPiVJ0CJGHfHRABDHddK437ZUEGTlBUSt4Qcjfrz+lR940tK4EZdgl89ZD9Q0bLpX1sBOfgWBJNSLZ5iOm4BOg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733234575; c=relaxed/simple;
	bh=CgmHTglH0KUG9BkcoXx3Q1LBMtaYIa0dZ9PSh5sYaJo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=wsMTnfU70U6D153/U1lQDiDJkCCLbTIF9gBTGXjk621Ald5xEhBdg/avPNwBYYhtX5lk4r2kAM0a5CXpjDT1jpVJjhHktX8eNq+/9df9JryiIX8TcnuDna12v+W/JcT9nG3k/eEiA/eAjsUoR339vcDI2D5JR1QrZIeB5L0M0R8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6AF653858C48
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Dyorrr4U
Received: from localhost.localdomain by mta-snd-w10.mail.nifty.com
          with ESMTP
          id <20241203140252773.FAQS.96847.localhost.localdomain@nifty.com>;
          Tue, 3 Dec 2024 23:02:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the queue chain when cleared
Date: Tue,  3 Dec 2024 23:01:51 +0900
Message-ID: <20241203140203.8351-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
References: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733234572;
 bh=NsFajj3/2PUVateJ+EKmNLBQHsSo9ok6z7ZwU+/VLPc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Dyorrr4U16509tvIO8NXOTdDS3VR3DKqmml8kauHsz06Ch1xsGkXRaM0SIo4LeZ8ENuePoH2
 WrjzwiJd+u6IKDas6hBs4CiW2akN16jwpFNkFUli+rDVinXDUAigQdxzC3azZvgj8lMZGYWc1y
 B4gadl6iESHP/wqmxznuUwJthHacw1n4aac/NVWwi1xGPprbKgm34XH1w0ZvCWRvy05rDVHFyU
 t0YidoMXPuRuu+CMwOZNwOoYj9bygrDXTdkQ21ilwgL6QYy4REYnpCWbVLzreJO5AUpKR9UyqF
 o/C+XK+tgu+NKmZZZspwFVWwHk4A6FY3yfS5gRydAKrz4qcg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The queue is cleaned up by removing the entries having si_signo == 0
while processing the queued signals, however, sigpacket::process() may
set si_signo in the queue to 0 of the entry already processed but not
succeed by calling sig_clear(). This patch ensures the sig_clear()
to remove the entry from the queue chain. For this purpose, the pointer
prev has been added to the sigpacket. This is to handle the following
case appropriately.

Consider the queued signal chain of:
A->B->C->D
without pointer prev. Assume that the pointer 'q' and 'qnext' point to
C, and process() is processing C. If B is cleared in process(), A->next
should be set to to C in sigpacket::clear().

Then, if process() for C succeeds, C should be removed from the queue,
so A->next should be set to D. However, we cannot do that because we do
not have the pointer to A in the while loop in wait_sig().

With the pointer prev, we can easily access A and C in sigpacket::clear()
as well as A and D in the while loop in wait_sig() using the pointer prev
and next without pursuing the chain.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/sigproc.h |  3 +-
 winsup/cygwin/sigproc.cc               | 48 +++++++++++++++++---------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
index 46e26db19..8b7062aae 100644
--- a/winsup/cygwin/local_includes/sigproc.h
+++ b/winsup/cygwin/local_includes/sigproc.h
@@ -50,8 +50,9 @@ struct sigpacket
   {
     HANDLE wakeup;
     HANDLE thread_handle;
-    struct sigpacket *next;
   };
+  struct sigpacket *next;
+  struct sigpacket *prev;
   int process ();
   int setup_handler (void *, struct sigaction&, _cygtls *);
 };
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 4d50a5865..8ffb90a2c 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -111,7 +111,7 @@ class pending_signals
 public:
   void add (sigpacket&);
   bool pending () {retry = !!start.next; return retry;}
-  void clear (int sig) {sigs[sig].si.si_signo = 0;}
+  void clear (int sig);
   void clear (_cygtls *tls);
   friend void sig_dispatch_pending (bool);
   friend void wait_sig (VOID *arg);
@@ -432,21 +432,35 @@ sig_clear (int sig)
   sigq.clear (sig);
 }
 
+/* Clear pending signals of specific si_signo.
+   Called from sigpacket::process(). */
+void
+pending_signals::clear (int sig)
+{
+  sigpacket *q = sigs + sig;
+  if (!sig || !q->si.si_signo)
+    return;
+  q->si.si_signo = 0;
+  q->prev->next = q->next;
+  if (q->next)
+    q->next->prev = q->prev;
+}
+
 /* Clear pending signals of specific thread.  Called under TLS lock from
    _cygtls::remove_pending_sigs. */
 void
 pending_signals::clear (_cygtls *tls)
 {
-  sigpacket *q = &start, *qnext;
+  sigpacket *q = &start;
 
-  while ((qnext = q->next))
-    if (qnext->sigtls == tls)
+  while ((q = q->next))
+    if (q->sigtls == tls)
       {
-	qnext->si.si_signo = 0;
-	q->next = qnext->next;
+	q->si.si_signo = 0;
+	q->prev->next = q->next;
+	if (q->next)
+	  q->next->prev = q->prev;
       }
-    else
-      q = qnext;
 }
 
 /* Clear pending signals of specific thread.  Called from _cygtls::remove */
@@ -1299,7 +1313,10 @@ pending_signals::add (sigpacket& pack)
     return;
   *se = pack;
   se->next = start.next;
-  start.next = se;
+  se->prev = &start;
+  se->prev->next = se;
+  if (se->next)
+    se->next->prev = se;
 }
 
 /* Process signals by waiting for signal data to arrive in a pipe.
@@ -1450,17 +1467,16 @@ wait_sig (VOID *)
 	case __SIGFLUSHFAST:
 	  if (!sig_held)
 	    {
-	      sigpacket *qnext;
 	      /* Check the queue for signals.  There will always be at least one
 		 thing on the queue if this was a valid signal.  */
-	      while ((qnext = q->next))
+	      while ((q = q->next))
 		{
-		  if (qnext->si.si_signo && qnext->process () <= 0)
-		    q = qnext;
-		  else
+		  if (q->si.si_signo && q->process () > 0)
 		    {
-		      q->next = qnext->next;
-		      qnext->si.si_signo = 0;
+		      q->si.si_signo = 0;
+		      q->prev->next = q->next;
+		      if (q->next)
+			q->next->prev = q->prev;
 		    }
 		}
 	      /* At least one signal still queued?  The event is used in select
-- 
2.45.1


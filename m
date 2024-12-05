Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 85CBD3858C41
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 12:26:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 85CBD3858C41
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 85CBD3858C41
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733401611; cv=none;
	b=XT6pMa27ShJw8XOHcalz5nxl0CiMv+HuPKgsj8ApHeLIRMNnuLysTaV2WVtMKEgfvGbwBMJ3N2aZxlG5k4n6VtnLJkNBmLsYzzwrm0pJCm5dBGUeP+U+6h10VUISk01HoCvb+6UlqWGPMKf2EI6AlzoRWp5I0oTv9097GiZHhIU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733401611; c=relaxed/simple;
	bh=tpxiz6uGGzDuqh9aV91hbAxHvaR7ZaoGk9UWlCcMniw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=LJHNsnDL16Md1za360fSECWBWh52IpnDeGH1lUThFLOqxKwozyGQnJ8Op+a9oUFAxY0IUsPKQm63QTzEqj9zvERlcDjmj75k8XyPUaK8kUqKZQ8+CRJSzZgUEpYnhwtvnl+LP2NSDHs7geETqqgHlf5pPlznSGQ1qjPu863maiA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 85CBD3858C41
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nQp9LlgP
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241205122648873.PQFY.12429.localhost.localdomain@nifty.com>;
          Thu, 5 Dec 2024 21:26:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH 1/3] Cygwin: signal: Remove queue entry from the queue chain when cleared
Date: Thu,  5 Dec 2024 21:25:41 +0900
Message-ID: <20241205122604.939-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241205122604.939-1-takashi.yano@nifty.ne.jp>
References: <20241205122604.939-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733401608;
 bh=Jmu4JiKP+lbVJKAnds75z/00eX+qZng+IVTeou0k93o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nQp9LlgPOTdloLbJ6x0DGLmpT+XfIRTouKiJDcsPadDBwSjnOYo1xgeSLRE9bT8E41oxou5N
 R84WLGTbO8mXmjUzm30MOeXfpIuIXJ2uL/nXbloHj+oo/87WZakKiWNLBOf1Zk8rZRqUBIsdc2
 0Df5j0gMAB4ZIbtreck8M6R8pxjjskiQGdSs//n3jx4pjWr9bA+vhuMgklc0VzM49eL0Zc7/R5
 c5XcbhAfUs//YeSDv1t6Z68c8cz/kUJSdZdPCspm93xEqqXjlF/IOau/sCgm5GXndVED5DckRi
 g8OmxU5UiqLA04txe2Kj1olTYxjlU0gZz1VBQg4aSO8TaNug==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
index 9680f6968..7e02e61f7 100644
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
@@ -1300,7 +1314,10 @@ pending_signals::add (sigpacket& pack)
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
@@ -1455,17 +1472,16 @@ wait_sig (VOID *)
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


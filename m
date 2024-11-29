Return-Path: <SRS0=zjkU=SY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 33C613858D29
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 11:48:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 33C613858D29
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 33C613858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732880935; cv=none;
	b=LhVvZxNwo6zNTLpGtEAurxst+NLL+kDJ2YQuRbvd6ny3Y8ejlnqtgN47/KzTPHztMXCEr3lay0216J0iEvXtleBEH99kfngWSPo1ByMWmn3mNQHijzkZzI3oM4EDNeVXjCQK6ipumvVHMsQWNTrMUFIiskYwAGkWoZkHYdEIlIU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732880935; c=relaxed/simple;
	bh=6CwKEUk2mykmRVc8dw4K7FSvzxkL3JAT/9e0dXEr15c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=nFEAz8KugWYwIzYpjTfLVJJL5mGW9WxS15ItSl94QyO4onQYXf8j497oUN6opytasLcdJ10JZtpjORffw382GkxdRSfhTYJ7VvqC46J/qfNJuX6fR9KfT1RU0LQh7i/qU9t9brKH8khn34iDKAsaJep1RH1aQY4AGi5/08tHEO0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 33C613858D29
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=li4E6kk7
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20241129114849956.PXBH.115271.localhost.localdomain@nifty.com>;
          Fri, 29 Nov 2024 20:48:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the queue chain when cleared
Date: Fri, 29 Nov 2024 20:48:18 +0900
Message-ID: <20241129114835.14497-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732880930;
 bh=gQX4XvHFpj4brAd0hbvqlu9iRoez0at/f1CSXBX2JjA=;
 h=From:To:Cc:Subject:Date;
 b=li4E6kk7RRmmANYvEiM7oxatGeiYv/ziyUC4gbXut/0klK1KZOoGLX8qZ7A4ulCKi4NCvfsz
 44TQF8mtDUpa9iNgE6XtHcgtUmYZEdmJ6N1XgMQe7/BuE5Qrqfa/05dS/8RkHZI6gkug1fNRtv
 9EJG2orMwK/FRAJhHgEV0OgASQDRPjIAdA1YuW5cPXV2tmbHqlWYi5Gm12XtBXrYkNl9Appw1i
 QoSGos3Xe8AziruZq/fBysrTt3u/ahGyBpsnxVSrfsbXcfTvrCTiwwg1N+z49xoxsdeMACGFu6
 Ys/yjPMXq4+YNogixeKjsZtsdIlQdEP08bg+Ou8bIt8DrymQ==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The queue is cleaned up by removing the entries having si_signo == 0
while processing the queued signals, however, sipacket::process() may
set si_signo in the queue to 0 of the entry already processed but not
succeed by calling sig_clear(). This patch ensures the sig_clear()
to remove the entry from the queue chain.

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


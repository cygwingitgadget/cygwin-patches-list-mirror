Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 236453858C52
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 14:23:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 236453858C52
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 236453858C52
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737383016; cv=none;
	b=FUQyNYhIXV1y+TyzuLRuQjvxcIPuW6fwp3M1twhP5KUjuPjuVhmlSxOZSMpKQIijquhOBCpn7T7hZ9B9l73jJWQZy81BjyKz41fq4wnncUgN3mB0ksLYKC++zV2GJEGD9ayi/XRlBAHMm+7vNJNzXThT6Y1gl7Jk1og9BohbXPk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737383016; c=relaxed/simple;
	bh=488Cg6NoeIFY6ABLtWEopFuJYdmOwMdRv6ry6CoVnk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=hEOL4YjUTMgIJi4a0xFKd2nFmu/KfOSJXAcbEFKhcr0izhLv1Tq1NgNgWBGDheWVukXJA9081uTIbDULoL/oKgN3IWCKYpHa6ANGs2LELOYF+r9huMdgx8uukTStEWW+xU8/uIxPRfE4YBZS2gZOwzPDAuxdxLu30/t9KaNRic0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 236453858C52
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nanENstP
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20250120142332969.SWVM.67063.localhost.localdomain@nifty.com>;
          Mon, 20 Jan 2025 23:23:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: signal: Avoid frequent TLS lock/unlock for SIGCONT processing
Date: Mon, 20 Jan 2025 23:23:05 +0900
Message-ID: <20250120142316.3606760-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737383013;
 bh=bp63h/ZcD8WCeJ1WVl5yG77DWSHu2lqiTjkvWtoyhVA=;
 h=From:To:Cc:Subject:Date;
 b=nanENstP3EzfgBH56a54sXy8C1477cWQ4esW35oQZyvqck2TznDUYbzqXWqIAdbnO6vxhODo
 eTGl+TR/Obtewo5ztJWlVZsUdUxcjqj3GCnhkMvXiQbNd3X9/pjRO0dXpAxmJzpkB5ZuGffDDl
 Pk+yRcs1g/hmVS/w1EPTp9r47yuRD2yrXNIQkll0xZBTEWfvU3aZ4Ezuxie+W0lTsqsUFgPU1t
 Hy1ulkeCw4KUJQtzwatfjjlq/xa0c5UsViT+VxxPns/C8a0y8cvNK7rDNnTE1wnxz3WAFGXg1A
 be3OwrZJJrmYM6KkRrJcB0acva1qQ5n9/3s9sPcLLwSXrzZw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

It seems that current _cygtls::handle_SIGCONT() code sometimes falls
into a deadlock due to frequent TLS lock/unlock operation in the
yield() loop. With this patch, the yield() in the wait loop is placed
outside the TLS lock to avoid frequent TLS lock/unlock.

Fixes: 9ae51bcc51a7 ("Cygwin: signal: Fix another deadlock between main and sig thread")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc           | 36 ++++++++++-----------------
 winsup/cygwin/local_includes/cygtls.h |  4 +--
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 4dc4be278..f576c5ff2 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1420,7 +1420,7 @@ api_fatal_debug ()
 
 /* Attempt to carefully handle SIGCONT when we are stopped. */
 void
-_cygtls::handle_SIGCONT (threadlist_t * &tl_entry)
+_cygtls::handle_SIGCONT ()
 {
   if (NOTSTATE (myself, PID_STOPPED))
     return;
@@ -1431,23 +1431,17 @@ _cygtls::handle_SIGCONT (threadlist_t * &tl_entry)
      Make sure that any pending signal is handled before trying to
      send a new one.  Then make sure that SIGCONT has been recognized
      before exiting the loop.  */
-  bool sigsent = false;
-  while (1)
-    if (current_sig)	/* Assume that it's ok to just test sig outside of a
-			   lock since setup_handler does it this way.  */
-      {
-	cygheap->unlock_tls (tl_entry);
-	yield ();	/* Attempt to schedule another thread.  */
-	tl_entry = cygheap->find_tls (_main_tls);
-      }
-    else if (sigsent)
-      break;		/* SIGCONT has been recognized by other thread */
-    else
-      {
-	current_sig = SIGCONT;
-	set_signal_arrived (); /* alert sig_handle_tty_stop */
-	sigsent = true;
-      }
+  while (current_sig)  /* Assume that it's ok to just test sig outside of a */
+    yield ();          /* lock since setup_handler does it this way.  */
+
+  lock ();
+  current_sig = SIGCONT;
+  set_signal_arrived (); /* alert sig_handle_tty_stop */
+  unlock ();
+
+  while (current_sig == SIGCONT)
+    yield ();
+
   /* Clear pending stop signals */
   sig_clear (SIGSTOP, false);
   sig_clear (SIGTSTP, false);
@@ -1479,11 +1473,7 @@ sigpacket::process ()
   myself->rusage_self.ru_nsignals++;
 
   if (si.si_signo == SIGCONT)
-    {
-      tl_entry = cygheap->find_tls (_main_tls);
-      _main_tls->handle_SIGCONT (tl_entry);
-      cygheap->unlock_tls (tl_entry);
-    }
+    _main_tls->handle_SIGCONT ();
 
   /* SIGKILL is special.  It always goes through.  */
   if (si.si_signo == SIGKILL)
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 2d490646a..e0de712f4 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -194,7 +194,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   class cygthread *_ctinfo;
   class san *andreas;
   waitq wq;
-  int current_sig;
+  volatile int current_sig;
   unsigned incyg;
   volatile unsigned stacklock;
   __tlsstack_t *stackptr;
@@ -274,7 +274,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   {
     will_wait_for_signal = false;
   }
-  void handle_SIGCONT (threadlist_t * &);
+  void handle_SIGCONT ();
   static void cleanup_early(struct _reent *);
 private:
   void call2 (DWORD (*) (void *, void *), void *, void *);
-- 
2.45.1


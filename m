Return-Path: <SRS0=9b+q=SW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 8D3BC3858D34
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 11:23:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8D3BC3858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8D3BC3858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732706606; cv=none;
	b=C/b9DYvI7jADJWrFTkNvz9ULCAm/HHSLZm6Bf0CyGtm9gTzyHLbB0QNKI5gcLOJ/smcVwM53dj9WL2x8Bq0tWGN8mjoxuONFGRjXvP2a/J+Mqt2SqyiApIloucTdhR24Ik7H3c7oiS7m32cfePIUsXCqamgeHW+mfJb3gdKgCNc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732706606; c=relaxed/simple;
	bh=in9ktMm1k0w77YQBYcWQj8JzgWlpmgksFw3bXq2HFk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=K7iSdGz63EHQe2/dCkSVuZ0KSjWu3q2xI9a/XD09TgbylNmPQn8pcb0Qazp9f7ferOBV6iecYqb5cco7r3PVXwbnKvuBnzkKvJD6zkol5IQlRbMpaQcbYwdj4h3xj+nzCbVcWWtgDHhVWQYAAX+UfiAqQQZ38iIJZE4jMx2Dau4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D3BC3858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JSl5C5f3
Received: from localhost.localdomain by mta-snd-w10.mail.nifty.com
          with ESMTP
          id <20241127112323159.JKHL.96847.localhost.localdomain@nifty.com>;
          Wed, 27 Nov 2024 20:23:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 8/8] Cygwin: signal: Fix another deadlock between main and sig thread
Date: Wed, 27 Nov 2024 20:22:54 +0900
Message-ID: <20241127112308.6958-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732706603;
 bh=yMJjidreqS7280qv8sp11/q4dJgGszAbt8d5AEthoL4=;
 h=From:To:Cc:Subject:Date;
 b=JSl5C5f3OxTuvTcSD4AltzPIzVj6Jt+WAe4TKS/KzTBAbQStC1S4raqVmG4pFTg5eRDfMOtn
 /W/hDyOUEHCBvQ1iRKoQQ8BYn43Qb5L1T/MaTzJV6ZSdvu42Lv1jOW8Ocbags/iK2OaruXDB7L
 tF7JNPW0mHd7+pVaoGeOj6V6Qm1biQ+uLqsCXB3Ye6V9e68/jL2OASe86aozLPx0bCaJVAPx1S
 MS8KkIK2x2vaCzp5UfD+/1CdMhEp2RA7vm9EQdh+0YWxa/4110DXKuWngP2w6Xqz8V7sax7ih8
 Wqm1BppbKUTpRlNQAK1aSCOb+MLdRtfXwE4CDKPIbTXG8mgw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In _cygtls::handle_SIGCONT(), the sig thread waits for the main thread
processing the signal without unlocking tls area. This causes a deadlock
if the main thread tries to acquire a lock for the tls area meanwhile.
With this patch, unlock tls before calling yield() in handle_SIGCONT().

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 26158dc3e9c2("* exceptions.cc (sigpacket::process): Lock _cygtls area of thread before accessing it.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc           | 10 +++++++---
 winsup/cygwin/local_includes/cygtls.h |  4 +++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 3b31e65c1..0f8c21939 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1421,7 +1421,7 @@ api_fatal_debug ()
 
 /* Attempt to carefully handle SIGCONT when we are stopped. */
 void
-_cygtls::handle_SIGCONT ()
+_cygtls::handle_SIGCONT (threadlist_t * &tl_entry)
 {
   if (NOTSTATE (myself, PID_STOPPED))
     return;
@@ -1436,7 +1436,11 @@ _cygtls::handle_SIGCONT ()
   while (1)
     if (current_sig)	/* Assume that it's ok to just test sig outside of a
 			   lock since setup_handler does it this way.  */
-      yield ();		/* Attempt to schedule another thread.  */
+      {
+	cygheap->unlock_tls (tl_entry);
+	yield ();	/* Attempt to schedule another thread.  */
+	tl_entry = cygheap->find_tls (_main_tls);
+      }
     else if (sigsent)
       break;		/* SIGCONT has been recognized by other thread */
     else
@@ -1478,7 +1482,7 @@ sigpacket::process ()
   if (si.si_signo == SIGCONT)
     {
       tl_entry = cygheap->find_tls (_main_tls);
-      _main_tls->handle_SIGCONT ();
+      _main_tls->handle_SIGCONT (tl_entry);
       cygheap->unlock_tls (tl_entry);
     }
 
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index fb5b02b4c..ca9ef7dfb 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -159,6 +159,8 @@ extern "C" int __ljfault (jmp_buf, int);
 
 typedef uintptr_t __tlsstack_t;
 
+struct threadlist_t;
+
 class _cygtls
 {
 public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
@@ -269,7 +271,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   {
     will_wait_for_signal = false;
   }
-  void handle_SIGCONT ();
+  void handle_SIGCONT (threadlist_t * &);
   static void cleanup_early(struct _reent *);
 private:
   void call2 (DWORD (*) (void *, void *), void *, void *);
-- 
2.45.1


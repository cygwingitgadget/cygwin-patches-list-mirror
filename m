Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.177])
	by sourceware.org (Postfix) with ESMTPS id 8932A385C6EC
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 06:44:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8932A385C6EC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8932A385C6EC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.177
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753166685; cv=none;
	b=ns1Rqh03OwcIiDuT+aZxQ6mCYfyi3Dzkk+HPhiiYxzEP5QJN36WcLg9lPlc7hIxWLbPf3lY2v1cj59RKZA6fJfOpGcpbO5f3EcAeV3QrVd8SfEptf8oK43u76krWJaJk3rOxm1CLvJuPMpd7rN8xthRn1h9nXjX4Yadd7WFmCVc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753166685; c=relaxed/simple;
	bh=naWhhX24zbb99XuvyTU+gVwWPEielw64Ltlaw9kukVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=r0KRqvF1ln1InxICKW94YzTXMzym5g8Aq/V2whrnw3doCvDPmP/Hlg6hDvdbc7M0VLaQl8EKtoztUMnviD3X/gYjvopz0g+WyfqKdE3n0IDWETcL315ewISjbYou2RPwEhdQGN1V4OAwS5KxfmluoMai+uQjuME4EPh5gX7P7wk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8932A385C6EC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=URHNv3v+
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250722064442827.TQVN.62593.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 15:44:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v6 1/3] Cygwin: cygheap: Add lock()/unlock() method
Date: Tue, 22 Jul 2025 15:44:00 +0900
Message-ID: <20250722064415.1590-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250722064415.1590-1-takashi.yano@nifty.ne.jp>
References: <20250722064415.1590-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753166682;
 bh=Dxz4jTf3fTYI30sOdYZhPlaXRSjyq+Qba1mvKbaymbQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=URHNv3v+JAguOfC1kKaU8C79J7EhGsQbXQ+oX981/9QMWbSGgigcB3k3GVjKKJUxqhAtvKIh
 4vqeR7bIx26bfGkJ/R2XDzHfZamQxTJTB6aY4B0JIDXzeZ7jAVG0c3r2qNZ+V91YwYfVcCJVCn
 G2D0uazASyRd7Srrbsx51xkGdTN9grzINg/DlFDeoExArUw0Pd7GKGPYNL1YJ5jIXDXJiMgjI+
 gF+UgMJkr29cFKOWCfoAd46XKKgadGgE6C75oX67/mfo4cpwJGd6PhU24G3Y+6TEYfoStyIZ3I
 kx3pZX+qCd8upCW0S0/9V8e1MJBgjOD93lTfSdneDvuuj0kA==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

...so that cygheap can be locked/unlocked from outside of mm/cygheap.cc.

Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/cygheap.h |  5 +++++
 winsup/cygwin/mm/cygheap.cc            | 12 ++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_includes/cygheap.h
index fed87ec2b..d9e936c1e 100644
--- a/winsup/cygwin/local_includes/cygheap.h
+++ b/winsup/cygwin/local_includes/cygheap.h
@@ -498,6 +498,9 @@ struct threadlist_t
 
 struct init_cygheap: public mini_cygheap
 {
+private:
+  static SRWLOCK cygheap_protect;
+public:
   _cmalloc_entry *chain;
   char *buckets[NBUCKETS];
   UNICODE_STRING installation_root;
@@ -541,6 +544,8 @@ struct init_cygheap: public mini_cygheap
   threadlist_t *find_tls (int, bool&);
   sigset_t compute_sigblkmask ();
   void unlock_tls (threadlist_t *t) { if (t) ReleaseMutex (t->mutex); }
+  inline void lock () { AcquireSRWLockExclusive (&cygheap_protect); }
+  inline void unlock () { ReleaseSRWLockExclusive (&cygheap_protect); }
 };
 
 
diff --git a/winsup/cygwin/mm/cygheap.cc b/winsup/cygwin/mm/cygheap.cc
index 338886468..1c9b8037b 100644
--- a/winsup/cygwin/mm/cygheap.cc
+++ b/winsup/cygwin/mm/cygheap.cc
@@ -35,7 +35,7 @@ static mini_cygheap NO_COPY cygheap_dummy =
 init_cygheap NO_COPY *cygheap = (init_cygheap *) &cygheap_dummy;
 void NO_COPY *cygheap_max;
 
-static NO_COPY SRWLOCK cygheap_protect = SRWLOCK_INIT;
+SRWLOCK NO_COPY init_cygheap::cygheap_protect = SRWLOCK_INIT;
 
 struct cygheap_entry
 {
@@ -367,7 +367,7 @@ _cmalloc (unsigned size)
   if (b >= NBUCKETS)
     return NULL;
 
-  AcquireSRWLockExclusive (&cygheap_protect);
+  cygheap->lock ();
   if (cygheap->buckets[b])
     {
       rvc = (_cmalloc_entry *) cygheap->buckets[b];
@@ -379,7 +379,7 @@ _cmalloc (unsigned size)
       rvc = (_cmalloc_entry *) _csbrk (bucket_val[b] + sizeof (_cmalloc_entry));
       if (!rvc)
 	{
-	  ReleaseSRWLockExclusive (&cygheap_protect);
+	  cygheap->unlock ();
 	  return NULL;
 	}
 
@@ -387,19 +387,19 @@ _cmalloc (unsigned size)
       rvc->prev = cygheap->chain;
       cygheap->chain = rvc;
     }
-  ReleaseSRWLockExclusive (&cygheap_protect);
+  cygheap->unlock ();
   return rvc->data;
 }
 
 static void
 _cfree (void *ptr)
 {
-  AcquireSRWLockExclusive (&cygheap_protect);
+  cygheap->lock ();
   _cmalloc_entry *rvc = to_cmalloc (ptr);
   unsigned b = rvc->b;
   rvc->ptr = cygheap->buckets[b];
   cygheap->buckets[b] = (char *) rvc;
-  ReleaseSRWLockExclusive (&cygheap_protect);
+  cygheap->unlock ();
 }
 
 static void *
-- 
2.45.1


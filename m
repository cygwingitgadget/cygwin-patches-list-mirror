Return-Path: <SRS0=Jqgh=2C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 4DB2D3858D3C
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 16:12:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4DB2D3858D3C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4DB2D3858D3C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753114339; cv=none;
	b=gYwLQPTdfDZqVBMdi9EutFs9JL0u0GVvQ5f0UEFwVUj9/DpZzI/T9UKgNXH73yassPkcMMoB842iHE96Vy3K+Z+5TAiQRcRsi/a0Xfc1fEjwpsqokqMIh38jqWhzlChfftNWSQanWFYWgOQw4CxuUvsMjNJi9lloSUpMSWcT0ss=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753114339; c=relaxed/simple;
	bh=naWhhX24zbb99XuvyTU+gVwWPEielw64Ltlaw9kukVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qb0HBL9G0A08ER3yENwUG7oOAaD/vf9OFCiIETzw3go4BVuQ6pnFpHnNpF53xqaQbal4X3twCSHDlxatXkQyc92p3bkz2XaneYleGwA85Z3yH4kO3FYLf0JZA+OHz92W4OY0ZPyPpiXEyuWF8dPW9pk8jRPcgBu1oOGbGrvCZVM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250721161217757.TETB.91923.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 01:12:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v4 1/3] Cygwin: cygheap: Add lock()/unlock() method
Date: Tue, 22 Jul 2025 01:11:40 +0900
Message-ID: <20250721161151.1053-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250721161151.1053-1-takashi.yano@nifty.ne.jp>
References: <20250721161151.1053-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753114337;
 bh=Dxz4jTf3fTYI30sOdYZhPlaXRSjyq+Qba1mvKbaymbQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ahkMHjC0qzTbk6jue44Pi7oQoEKpixTN1ICW2IA59/BPaVTEoQiBVPJijazPwsXuQv8fU93z
 iBeyJjz71Gh4rWx/9xb6CmowguhoRF7vpzc5tQsIuedWD/8YQQtBQ1PtmxH7jjlSoucQRVtaqU
 E6E5MoT0SJ9vClJLRushjP686gkIF9Yx4KSiq+6wFvbOkgoZii+x8KklTUi/6LtX1mcZUimEMO
 8UZf3XT0hnAuOlMDi7Uk9usCE7dkAGVSJzjJcfhLlv4QtUnGLJyUbANGGlYjxpfIOOcCGLRyzL
 XN2bNb8WiV9YFKfn3IKTz3LRy+3pIeF/QdbaCZVv23bQ9Qzg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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


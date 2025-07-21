Return-Path: <SRS0=Jqgh=2C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id E32C43858C56
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 13:47:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E32C43858C56
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E32C43858C56
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753105624; cv=none;
	b=QJv2lE8AFjqxbB1JQE1yWm7n/SFWRQXA6glC5Cz2YQ+6yaQLXSZAlYGVJUS3VzCOYB4A79Gl4OEP3Jxd1ZABLba6Yv0eJ2brq+dS2nGHbLUTjcT69pSK8htXQJO6wWg+SAF9kNJ0qzHr1WZfx/Qvdq7bKzQ9etgzgYdzWCSxJlI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753105624; c=relaxed/simple;
	bh=oMIPkW6cILfBjj9AXPu16VsWslWj1P13naymwpgnuY8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=G31yjUxlonfVU+Ras/YQksM35Ojv7PAkUBTpKzzPWVxdiK2zrF9jSW/fSSabyh+Aiowfz9XpcOFCR+u9n00NxlrR0sdgiHWRqmJF+FflkeK6HjrWkFTTqMi18Wv6A9VNpTSjNpV07nxpeZkOWBDCcPnTPhyUlDe2wmxrbLmZl3Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E32C43858C56
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Ysrbj2/o
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250721134702316.SKBT.74565.localhost.localdomain@nifty.com>;
          Mon, 21 Jul 2025 22:47:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 1/3] Cygwin: cygheap: Add locl()/unlock() method
Date: Mon, 21 Jul 2025 22:46:17 +0900
Message-ID: <20250721134628.2908-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
References: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753105622;
 bh=86Ot7PFskI+kEFGu9C1VAKKXm0EDhCpPnipCYw0X/X8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ysrbj2/oe6WfvtzRAR93DuPowR3UyVvl4f1oDCKCoYmfYllNtYCg5Ac2qDV53onLB0HPvzDH
 DvPs/Gb4KQTX11zzR4CheWIGUBwH2qrePuDDb3SM3dg0ee3x6t4kMJs13dJTFeYYuLfH5a5IYj
 mNhrQqeEO5aOsk9uOlsVfedX9IwDcLE/9uY+hdT84lIrrB6AR/eMUETndQbwJoTlvNOa6nneYf
 8rcOKUlJ7H2Sf7690xJM/Tk51Zlq4k+f54hViCMizUnS4HPFFRsxE/zCPL0/S8Wu4IyhTNU+OP
 YWgrXY7pN6eb4pvPVGTvaiPBsV8QLup1quaZrxgrFOFs5iVw==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

...so that cygheap can be locked/unlocked from outside of mm/cygheap.cc.

Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/cygheap.h |  2 ++
 winsup/cygwin/mm/cygheap.cc            | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_includes/cygheap.h
index fed87ec2b..aa928bc55 100644
--- a/winsup/cygwin/local_includes/cygheap.h
+++ b/winsup/cygwin/local_includes/cygheap.h
@@ -541,6 +541,8 @@ struct init_cygheap: public mini_cygheap
   threadlist_t *find_tls (int, bool&);
   sigset_t compute_sigblkmask ();
   void unlock_tls (threadlist_t *t) { if (t) ReleaseMutex (t->mutex); }
+  void lock ();
+  void unlock ();
 };
 
 
diff --git a/winsup/cygwin/mm/cygheap.cc b/winsup/cygwin/mm/cygheap.cc
index 338886468..2ed21e6ce 100644
--- a/winsup/cygwin/mm/cygheap.cc
+++ b/winsup/cygwin/mm/cygheap.cc
@@ -262,6 +262,18 @@ init_cygheap::init_installation_root ()
     }
 }
 
+void
+init_cygheap::lock ()
+{
+  AcquireSRWLockExclusive (&cygheap_protect);
+}
+
+void
+init_cygheap::unlock ()
+{
+  ReleaseSRWLockExclusive (&cygheap_protect);
+}
+
 /* Initialize bucket_val.  The value is the max size of a block
    fitting into the bucket.  The values are powers of two and their
    medians: 32, 48, 64, 96, ...
@@ -367,7 +379,7 @@ _cmalloc (unsigned size)
   if (b >= NBUCKETS)
     return NULL;
 
-  AcquireSRWLockExclusive (&cygheap_protect);
+  cygheap->lock ();
   if (cygheap->buckets[b])
     {
       rvc = (_cmalloc_entry *) cygheap->buckets[b];
@@ -379,7 +391,7 @@ _cmalloc (unsigned size)
       rvc = (_cmalloc_entry *) _csbrk (bucket_val[b] + sizeof (_cmalloc_entry));
       if (!rvc)
 	{
-	  ReleaseSRWLockExclusive (&cygheap_protect);
+	  cygheap->unlock ();
 	  return NULL;
 	}
 
@@ -387,19 +399,19 @@ _cmalloc (unsigned size)
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


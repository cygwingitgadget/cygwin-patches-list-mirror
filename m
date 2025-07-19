Return-Path: <SRS0=jPCG=2A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 661A93858430
	for <cygwin-patches@cygwin.com>; Sat, 19 Jul 2025 21:48:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 661A93858430
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 661A93858430
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752961729; cv=none;
	b=knBNqZVIG9y6Xsuzc3NwGs/LzNEvnIv9eskKcZbQob8fIw6eKVYqmJdcBKyavhEf68bg2jDXloMBOx4LxdcunTMuoUCrlcNv/XiBsUDEMb7kZb0Az7NdJRHagQRfk1yOnpuagQVSDTya5reNsRycSTvu+GX3YuR/Kd1YV85pOI4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752961729; c=relaxed/simple;
	bh=y7OysSjafBHKufzzjILgTG9FB0+Ul84hC5FhkyF9QE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ZkzWb8qtYxtPA6qcqOYjfWWyrkvMuRWIK4PeUdVmDLoNd6baQAGFK3NOJR4FmgImYmkOb8kaN1mDz6f4dUVcljlmyy48EvhCUZF7xHbAbYgVME342phuloFuj7o03yPSgJUguxZf217zOEmefkyKDQyc5mL6IvoJ7g5fVUy8uG4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 661A93858430
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kRJmoam4
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20250719214847814.XWZR.116286.localhost.localdomain@nifty.com>;
          Sun, 20 Jul 2025 06:48:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/2] Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
Date: Sun, 20 Jul 2025 06:48:12 +0900
Message-ID: <20250719214823.1556-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250719214823.1556-1-takashi.yano@nifty.ne.jp>
References: <20250719214823.1556-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1752961727;
 bh=IbPLE4D9g75CQcOpChtIm6IrPx7dcch4EpSJlYQGlgc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kRJmoam4FQOckSqBR61P5GW0WQwdCIkB+oHdffN2Etxbu9Ehotl0l+0yn0nIsf/7gtKMz99D
 P2BPmdXv/UeJHy0AoR4GTzAP7QpN/bLTWEnA9TnNNNQnKPSBVQglj8tf8jDQOGbfVslxIidPz6
 /eQDU5Bi0bViD8ncxnrbHXp7za2L/6TsjPE1urE3ztKUVuFYYu5bnilyQ4Gb1JVNyz1HvhNg42
 v+0RryYTrs0+MxvPoafQ4gfYD2lwJbsiG35qlAedtf2BGqBEc6ExV9jINQM4Fp2pWvEA0HWlm6
 tgIcIwjz+4fpcCwguuTw21/iRJYVOeSzYurGNvbETtJzG69Q==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

...completion in child process because the cygheap should not be
changed to avoid mismatch between child_info::cygheap_max and
::cygheap_max. Otherwise, child_copy() might copy cygheap being
modified by other process.

Fixes: 977ad5434cc0 ("* spawn.cc (spawn_guts): Call refresh_cygheap before creating a new process to ensure that cygheap_max is up-to-date.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/cygheap.h |  2 ++
 winsup/cygwin/mm/cygheap.cc            | 22 +++++++++++++++++-----
 winsup/cygwin/spawn.cc                 |  4 +++-
 3 files changed, 22 insertions(+), 6 deletions(-)

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
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cb58b6eed..fd623f4c5 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -542,7 +542,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
       if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
-      refresh_cygheap ();
 
       if (mode == _P_DETACH)
 	/* all set */;
@@ -611,6 +610,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
 
+      cygheap->lock ();
+      refresh_cygheap ();
       wchar_t wcmd[(size_t) cmd];
       if (!::cygheap->user.issetuid ()
 	  || (::cygheap->user.saved_uid == ::cygheap->user.real_uid
@@ -844,6 +845,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	/* Just mark a non-cygwin process as 'synced'.  We will still eventually
 	   wait for it to exit in maybe_set_exit_code_from_windows(). */
 	synced = iscygwin () ? sync (pi.dwProcessId, pi.hProcess, INFINITE) : true;
+      cygheap->unlock ();
 
       switch (mode)
 	{
-- 
2.45.1


Return-Path: <SRS0=g3Q1=WL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id E01563858D33
	for <cygwin-patches@cygwin.com>; Mon, 24 Mar 2025 05:53:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E01563858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E01563858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742795640; cv=none;
	b=r9Vl1woYxHjMOFxghG3em46SdEuq7y3Ma2LGoc0ESMNUmjEP5YwerX6HP+npRNJUOEQalN5Ve12H3+ozWnwzU3HdzRpThF0H3G0uYxRQ1/k3MTFS0Glx2mnykU60le+DFoH3kG3CAHlemd+6cvshyvBesWQB/bvVIwyDpgzGjks=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742795640; c=relaxed/simple;
	bh=onPLLeARgDQtCYVI6J8WqygpsW10WLNgx9JBgEjSYdc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qwuKHm8qozBw2iK5HIQoRnGyqOlCX21zN+IFInEoeh69cYiMnxwnhIoEOCcB8r0whgl10P1KR87yAkJC+DCQjX1N2U/q4GTuzC/WC5DAjNP5hhRFItD6b4SnqcI2UfmVwqKp1d2hxURBDUggT0R7o4qUPkFfqZBLGI/ON5y+dZc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E01563858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bZWUsrJF
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20250324055357905.ENKB.86286.localhost.localdomain@nifty.com>;
          Mon, 24 Mar 2025 14:53:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired multiple times.
Date: Mon, 24 Mar 2025 14:53:21 +0900
Message-ID: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742795637;
 bh=3rXuQOl6TbOSOspuh0v26ZFjZvIPsWmhlDu7eYoWitU=;
 h=From:To:Cc:Subject:Date;
 b=bZWUsrJFtHtIrTH036cjdr/o1OH9pyJejjZYt4x/gIuIen5kVIfK6W6dd+B7OrRvfDTLOO0h
 eVbEFEvV9ltO/ANCuWvL/YGEG0UuJw88V19bTBJ/HDONj0l7pM+bx4aygwZOIR8K6ERqFnKyih
 0M1QfwgDIup74Iq/RPzwANexyN5JFYw30/aGaglLUVCxglTFZc0zA9Wki5rUyOAxLbtCrGX6VM
 MCvR+VpBgBo46WpHKvsd6/cyFkkvgPv1DzmTmzWK/pUuYZuFeeO2lQeCThnsbAIXRmYmaj3+vu
 WGYhWH73EJQ9ETjpIlH8OwG6inkGscWsce5uoIdxr8gbxw3g==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the fast_mutex defined in thread.h could not be aquired
multiple times, i.e., the thread causes deadlock if it attempted to
acquire a lock already acquired by the thread. For example, a deadlock
occurs if another pthread_key_create() is called in the destructor
specified in the previous pthread_key_create(). This is because the
run_all_destructors() calls the desructor via keys.for_each() where
both for_each() and pthread_key_create() (that calls List_insert())
attempt to acquire the lock. With this patch, the fast_mutex can be
acquired multiple times by the same thread similar to the behaviour
of a Windows mutex. In this implementation, the mutex is released
only when the number of unlock() calls matches the number of lock()
calls.

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257705.html
Fixes: 1a821390d11d ("fix race condition in List_insert")
Reported-by: Yuyi Wang <Strawberry_Str@hotmail.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/thread.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/local_includes/thread.h b/winsup/cygwin/local_includes/thread.h
index b3496281e..025bfa2fc 100644
--- a/winsup/cygwin/local_includes/thread.h
+++ b/winsup/cygwin/local_includes/thread.h
@@ -31,7 +31,7 @@ class fast_mutex
 {
 public:
   fast_mutex () :
-    lock_counter (0), win32_obj_id (0)
+    tid (0), counter_self (0), lock_counter (0), win32_obj_id (0)
   {
   }
 
@@ -55,17 +55,29 @@ public:
 
   void lock ()
   {
-    if (InterlockedIncrement (&lock_counter) != 1)
+    if (!locked () && InterlockedIncrement (&lock_counter) != 1)
       cygwait (win32_obj_id, cw_infinite, cw_sig | cw_sig_restart);
+    tid = GetCurrentThreadId ();
+    counter_self++;
   }
 
   void unlock ()
   {
+    if (!locked () || --counter_self > 0)
+      return;
+    tid = 0;
     if (InterlockedDecrement (&lock_counter))
       ::SetEvent (win32_obj_id);
   }
 
+  bool locked ()
+  {
+    return tid == GetCurrentThreadId ();
+  }
+
 private:
+  DWORD tid;
+  int counter_self;
   LONG lock_counter;
   HANDLE win32_obj_id;
 };
-- 
2.45.1


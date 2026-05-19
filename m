Return-Path: <SRS0=fysI=DQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 31D8A4BB3BCC
	for <cygwin-patches@cygwin.com>; Tue, 19 May 2026 23:46:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 31D8A4BB3BCC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 31D8A4BB3BCC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779234403; cv=none;
	b=cY90pK3esmutUg4OBFYYlXQX6/32iR4MxriscYtEAXJa0aTwg9UmfS3VD+DWamHh24T0lict5e2U4FshN8pDM+04Lr9Ho6pqzYHvCoJEGb/R3zaxDi0O7NANIupZ58RvbaHhqB/4fHE1JWQSpGIZ5SHMZxW/ssGiaBAiknUqNgw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779234403; c=relaxed/simple;
	bh=lVPH9YgjL3jroNN7j0Y8vB3WwIE5SeTlRt4upFa0Gu0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vDjhMha3GUmdVCFYKDZh7UpHlt70A0WEub0D47HxM+agwiPok8IMbhF641/7BFS+uAvhgFF/Ulj1S6cY4v8RKJxB5IT1Uy89ZDkpuhCFYmZhm9o7DAW6gqLUIWax7dTEv8Znvbu+9LPBgCD1+FexD5U/HU4UuHmSfHhwrTWk5u8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JJQrMAer
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31D8A4BB3BCC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JJQrMAer
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260519234638638.LXSX.102121.HP-Z230@nifty.com>;
          Wed, 20 May 2026 08:46:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: fork: Call pthread::atforkprepare() in the constructor
Date: Wed, 20 May 2026 08:46:22 +0900
Message-ID: <20260519234631.19257-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1779234398;
 bh=Du57M8GtoVdEKrYBGxO2Jcm2Bw5Lt3t3M/ihb8drjXA=;
 h=From:To:Cc:Subject:Date;
 b=JJQrMAerF0Moj3WqIuS5wY5ZSMjCfxQuo9fb7pUT+YkOAwZSA3slKOWsZW4yy8fR2urQzfXS
 e4HRuP+HO/aUPY5EXKjVp6/iAbIPxHmcTcdpvPNLgEhVxiS9iYshoEDi6SF2ZAUnRk9QJJCHln
 rjLk0+uhnWG1DEiVBg8aZOxCss2/uQB65HCKu7gCNqREWO31mrai1ERPaNhbxuJVaEuAXLb0rm
 OA1VoimN9TnvWoUPnnQrrTlNbflADljAYET2AX6fFCtpnRY9P8H61Ai9S+Sr9ft+PracmWhbdB
 GdP9W+EM4U0mDSaktqNoYlUmDFrFnjTtBev998W4/shwjCWQ==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Since the commit 5f515cf3d6e3, if one thread calls fclose() while
another thread calls fork(), a deadlock can occur. The mechanism
is as follows.
  1) fclose() first calls __sfp_lock_acquire() and, then calls
     lock_process::locker.acquire() via cygheap_fdget().
  2) fork() first calls lock_process::locker.acuire() via the
     constructor of the lock_process class in the hold_everything
     class, and then calls __sfp_lock_acquire() via __fp_lock_all()
     in atforkprepare().
  3) As a result, the thread calling fclose() tries to acquire the
     lock_process lock while holding __sfp_lock, and the thread
     calling fork() tries to acquire __sfp_lock while holding the
     lock_process lock.
This leads to a deadlock. Before the commit 5f515cf3d6e3, __sfp_lock
was acquired in the constructor of the lock_pthread class in the
hold_everything class, and since lock_pthread is defined before
lock_process, this deadlock did not occur.

This patch moves the atforkprepare() call back into the constructor
of the lock_pthread class, restoring the previous lock qcquisition
order.

Fixes: 5f515cf3d6e3 ("Cygwin: add _Fork() system call per POSIX.1-2024")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/local_includes/sigproc.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
index 92cda94dc..21367877c 100644
--- a/winsup/cygwin/local_includes/sigproc.h
+++ b/winsup/cygwin/local_includes/sigproc.h
@@ -131,7 +131,15 @@ class lock_pthread
 {
   bool bother;
 public:
-  lock_pthread (): bother (1) {}
+  lock_pthread (bool do_atfork_handlers): bother (1)
+  {
+    /* POSIX.1-2024: _Fork() does not call any handler established
+		     by pthread_atfork(). */
+    if (do_atfork_handlers)
+      dont_bother ();
+    else
+      prepare ();
+  }
   void prepare ()
   {
     pthread::atforkprepare ();
@@ -166,15 +174,8 @@ class hold_everything
   lock_process process;
 
 public:
-  hold_everything (bool& x, bool do_atfork_handlers): ischild (x)
-  {
-    /* POSIX.1-2024: _Fork() does not call any handler established
-		     by pthread_atfork(). */
-    if (do_atfork_handlers)
-      pthread.dont_bother ();
-    else
-      pthread.prepare ();
-  }
+  hold_everything (bool& x, bool do_atfork_handlers): ischild (x),
+  pthread (do_atfork_handlers) {}
   operator int () const {return signals;}
 
   ~hold_everything()
-- 
2.51.0


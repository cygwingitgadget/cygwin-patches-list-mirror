Return-Path: <SRS0=fysI=DQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id D25634BB3BCC
	for <cygwin-patches@cygwin.com>; Tue, 19 May 2026 23:51:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D25634BB3BCC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D25634BB3BCC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779234703; cv=none;
	b=XSkziBICEm7bwamIfZOT7UQWHHXW8T/noM2yN4i8eDCVcn9EEAxRrgZ82Q1VXCpyhywz1gfarIb0f0sLjR24/MbtzI7AmBUQX6+BO99iCBHXWqBFCROHLc5d7VSzABaERItLaqTLRLdDC5HPuTA2s4Y20a2Pt0P1u5+gatU9yOw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779234703; c=relaxed/simple;
	bh=dNls29N8L6iG4SJBYhf1aS+qF35Dtpx5BygYKnC3t6I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ROOqE1O9E7/kic8PhK5cIhPaiRJraT3Lr4D6AHpILcbSYmSC2ELjXwqmPLdt30/hFMUdZYyYMOu+XFBNG+ZF1sB4sOagSBRpYNuLVz9w4vjTtJuBjOZqXZRmPDCtbhORHyyZ511PBNUUMTDhqRVfybpy0Lql04neeW5Xibw6T3w=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jDi6pwtn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D25634BB3BCC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jDi6pwtn
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260519235140317.MLEC.17441.HP-Z230@nifty.com>;
          Wed, 20 May 2026 08:51:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: fork: Call pthread::atforkprepare() in lock_pthread()
Date: Wed, 20 May 2026 08:51:21 +0900
Message-ID: <20260519235133.19276-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1779234700;
 bh=ctmQyp2djM4Elvyz4/eoDOhU/mRvbcKqZhLu3kB94wE=;
 h=From:To:Cc:Subject:Date;
 b=jDi6pwtnBzVknCEdUq7K1zcPPhLZkqKMgLYFaEOkax6adUjpn8UdoIZgfdqZevvF58eYfPe9
 fBwZ29ePAkm7cb5LSO3RkASqxsQqTbh1VplG4PZO7mf6o7K7ab+uXJHHzv+gur61PVz1kimHSW
 B6/ziDp/4CEQ9yI57/6lWAwmNhXRohH6pgHgNvqjbcq+SdDFGH2ioMkG64839dXw15yHKV3z8x
 EAZS6Rknl5JrBwOM7CC2OKrhWjBO7JAuNRx0gLzV+4Egg5IbougLWy60ZnXZx2IBVn90jgosI2
 tRwfwnFhksBtYfsdEWbxxlBm8RyGHrJlDQmqJFXy/XTUxfHw==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
v2: Fix the commit title

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


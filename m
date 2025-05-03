Return-Path: <SRS0=J3gq=XT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 5BEAC3858D21
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 06:03:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BEAC3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BEAC3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746252239; cv=none;
	b=RFliq+/zj55ggVDWtLJxqcvGjX/nraqu8fxrkb87SFYZ4t3oArSAN7myN32PkDIVf8ocBt4TelOGG/U5p0hCaf0OH1PLFip1TI2Uw/o1UZ/qayWfhsrtstyW4JsoJ6bdQ+EL0NG9SQVokw6N7mjo3JAvZdqRKzYMOkJAOox+EI0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746252239; c=relaxed/simple;
	bh=4rpzthr7kqOsJF06AprwML4fuEhqO5kwG0NLFGlj6Gw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=v9JXg/n9SUGsjXJ0jYl8E7xjAMAEntK6ZuChzo0Ako87HxPwq6MGVH412nyyz66CCI+0jWzb/1jfmLk+xRWIkjTh1fGHUyPgkb7n71Ukar+gdIF09ji2wGs/SUfpjKrMEatLr85TCS48MrOXlxWeo2uhQJLZ8YKDR5AzwSBSJbI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BEAC3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=i/66O6/X
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20250503060355734.RUNP.84842.localhost.localdomain@nifty.com>;
          Sat, 3 May 2025 15:03:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: signal: Revive toggling incyg flag in call_signal_handler()
Date: Sat,  3 May 2025 15:03:32 +0900
Message-ID: <20250503060341.10915-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746252235;
 bh=Hx+L9nsyYOdKw5gbSXnOegqPjB7/uI8B7RmuzR6kKYU=;
 h=From:To:Cc:Subject:Date;
 b=i/66O6/X2x4oFXwEyt0ycIVLU952eUKxY/Vjqk8OdELBHYR9W88YViEurd8rR6inYTGPNRTH
 hQGsyCFgRbnhc4yy7ilfUd6pxSafCYXUAKPSbvvwQlfEGjg3ygXCfcF818uBjzGRTbv1rrD5tP
 UOPsWUBNm34ZU06UPYv+4N3FYAu1MnieZqwadJBZ3MHnUcW+ClAUa4xWrutw1WkyNSX8tJkZU4
 e80BjzJK4ZiA32sDfeK+P+WmWz45kMFGPsjsd0eQA4oaK6QjbVRi4qZ2lNWUsSijC6IgPhHjf4
 VKHmiiKBgIpm+95XAmDbpCmQQserU6VlM+T1Xr7DdUWzUs3A==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit 68991cda8185 dropped toggling incyg flag in the function
call_signal_handler(). However this seems to cause another problem
that the command "stress-ng --kill 0 -t 5" sometimes leaves child
processes hanging. With this patch additional mechanism to determin
whether the target thread is inside cygwin1.dll has been introduced
instead. This mechanism utilizes _cygtls::inside_kernel() function
with additional argument to return true if the code is in the cygwin
DLL even if incyg flag is not set.

Fixes: 68991cda8185 ("Cygwin: signal: Do not handle signals while waiting for wakeup evt")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc           | 9 +++++++--
 winsup/cygwin/local_includes/cygtls.h | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index d1c98e46f..9763a1b04 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -440,7 +440,7 @@ cygwin_exception::dumpstack ()
 }
 
 bool
-_cygtls::inside_kernel (CONTEXT *cx)
+_cygtls::inside_kernel (CONTEXT *cx, bool inside_cygwin)
 {
   int res;
   MEMORY_BASIC_INFORMATION m;
@@ -462,6 +462,8 @@ _cygtls::inside_kernel (CONTEXT *cx)
   else if (h == hntdll)
     res = true;				/* Calling GetModuleFilename on ntdll.dll
 					   can hang */
+  else if (h == cygwin_hmodule && inside_cygwin)
+    res = true;
   else if (h == user_data->hmodule)
     res = false;
   else if (!GetModuleFileNameW (h, checkdir,
@@ -921,7 +923,7 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
   /* Delay the interrupt if we are
      1) somehow inside the DLL
      2) in a Windows DLL.  */
-  if (incyg || inside_kernel (cx))
+  if (incyg || inside_kernel (cx, true))
     interrupted = false;
   else
     {
@@ -1756,6 +1758,7 @@ _cygtls::call_signal_handler ()
 
       int this_errno = saved_errno;
       reset_signal_arrived ();
+      incyg = false;
       current_sig = 0;	/* Flag that we can accept another signal */
 
       /* We have to fetch the original return address from the signal stack
@@ -1868,6 +1871,8 @@ _cygtls::call_signal_handler ()
 	}
       unlock ();
 
+      incyg = true;
+
       set_signal_mask (_my_tls.sigmask, (this_sa_flags & SA_SIGINFO)
 					? context1.uc_sigmask : this_oldmask);
       if (this_errno >= 0)
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index 079ada99a..4698352ae 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -229,7 +229,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   bool interrupt_now (CONTEXT *, siginfo_t&, void *, struct sigaction&);
   void interrupt_setup (siginfo_t&, void *, struct sigaction&);
 
-  bool inside_kernel (CONTEXT *);
+  bool inside_kernel (CONTEXT *, bool inside_cygwin = false);
   void signal_debugger (siginfo_t&);
 
 #ifdef CYGTLS_HANDLE
-- 
2.45.1


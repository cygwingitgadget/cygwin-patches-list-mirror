Return-Path: <SRS0=MFHH=WM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 78F433858D33
	for <cygwin-patches@cygwin.com>; Tue, 25 Mar 2025 10:16:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78F433858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 78F433858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742897789; cv=none;
	b=CuV5omQhnmysJJNAZk6dZ3Tgh6vcZRO3FYxyxMPst5Z2jITr+CNfmgYlqPCreP9jn9+Vewd8mmLeCqcdZ1JT+aYeat7bA7OrfvIzVxNazqrrzP9DFM9ImB+MH2q4PQfYIV1xQob13I58gFv3ZvvKGFO6CUhYZAFV89Aj4pxff7o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742897789; c=relaxed/simple;
	bh=xNMfAclRbqq3gBW35zLKKASot7oaguLpS7qmR+6vHRE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=RwB7Uh6bKpaAztmojKtdHK4/gDJIH/MuvvfoEMUnPTYXWKQLyEz1Udubq8fDH1OU79F1GN6sOQ1wFUBPFS+n3Pl6kHxPo5OF6Zo9aGRMoXoWFP+88wtK/oZYU8nDkpt4sgin3HMqDRi9lo/65jgF8RkAmfalreNrAHbqIq2/OBQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 78F433858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Lo+Q4cjw
Received: from localhost.localdomain by mta-snd-e07.mail.nifty.com
          with ESMTP
          id <20250325101625150.ELHV.70161.localhost.localdomain@nifty.com>;
          Tue, 25 Mar 2025 19:16:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Bruno Haible <bruno@clisp.org>
Subject: [PATCH] Cygwin: signal: Do not copy context to stack area in call_signal_handler()
Date: Tue, 25 Mar 2025 19:16:01 +0900
Message-ID: <20250325101611.1872-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742897785;
 bh=RlK0qDOHivaiZ3/kNZ4B0OHI34Fn9vgLP7CGTUsYaYU=;
 h=From:To:Cc:Subject:Date;
 b=Lo+Q4cjwLdLhoBmUkYkSoH2JfhJrQIMwZyFwIbvbqMcCQ37HpkCSdTYEOwQ2AqIZKobUTIG3
 f86n0NgUptnG/vwMCUN/yhcBzhBkE6YwjA03bIZtomNedFqm8HV7baZck6NqHc6XxvgKrVX9u2
 DJRYeerKWoqPPbTA41522hEv3duOh19XnxMk50s/dU3d/x7Jt9q/85F/hYD7cXXxyR853zEAOc
 4uUZj+233D3WX6qpN/khlPRmF4xbg7PQlamnchsQcxsoinZh8gKpSAWzCtcp4E/6sBSQiodDLn
 /CdKMrt0CMcauzF9dfcBGPb/DbM/BrSy85Lpin98sSmoKXBA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit 0210c77311ae, the context passed to signal handler
cannot be accessed from the signal handler that uses alternate stack.
This is because the context locally copied is on the stack that is
different area from the signal handler uses. With this patch, copy
the context to malloc'ed memory area to avoid this situation.

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257714.html
Fixes: 0210c77311ae ("Cygwin: signal: Use context locally copied in call_signal_handler()")
Reported-by: Bruno Haible <bruno@clisp.org>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 7 ++++++-
 winsup/cygwin/release/3.6.1 | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 2e25aa214..00dcb3dca 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1660,7 +1660,11 @@ altstack_wrapper (int sig, siginfo_t *siginfo, ucontext_t *sigctx,
 int
 _cygtls::call_signal_handler ()
 {
-  ucontext_t context1 = context;
+  /* To copy the context, do not use auto variable allocated on the stack,
+     because it cannot be accessed by the signal handler that uses
+     alternate signal stack. Instead, use malloc()'ed area. */
+  ucontext_t &context1 = *(ucontext_t *) malloc (sizeof (ucontext_t));
+  context1 = context;
 
   int this_sa_flags = SA_RESTART;
   while (1)
@@ -1869,6 +1873,7 @@ _cygtls::call_signal_handler ()
 	set_errno (this_errno);
     }
   context = context1;
+  free (&context1);
 
   /* FIXME: Since 2011 this return statement always returned 1 (meaning
      SA_RESTART is effective) if the thread we're running in is not the
diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
index 40ef2973f..838f6d3ac 100644
--- a/winsup/cygwin/release/3.6.1
+++ b/winsup/cygwin/release/3.6.1
@@ -10,3 +10,8 @@ Fixes:
 - getlocalename_l: Fix a crash and handle LC_ALL according to final
   POSIX-1.2024 docs.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257715.html
+
+- Do not copy context to stack area in call_signal_handler() because
+  this may cause access violation if context is accessed in the signal
+  handler.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257714.html
-- 
2.45.1


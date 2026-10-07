Return-Path: <SRS0=07bK=H5=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by sourceware.org (Postfix) with ESMTPS id 616BE4BA2E2B
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 18:46:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 616BE4BA2E2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 616BE4BA2E2B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::102f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791398789; cv=none;
	b=h/nrB+cHbhoc9I5aWyqalSC8pUb8lSTvptU2+1w+s5GLiQpzqzRJtnYsx2JqBQHHGGid4DnYFIBmqaCaAp0EUOsujKPpqWOCgL6LbWTIZikIa6oIXiXQfvJFkv/XkUUfhYBvSuDFRSh3UfMeREhwIMVJraPpd9rGKTJpzE8YNZw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791398789; c=relaxed/simple;
	bh=+M3T4VFxdRAI4+R70MtOppH14+G+N5PfL/VPpGlU8Ss=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=GVw2hI9FZY6mDf1X3EVcK/W1etbfYkkuJoV9KWnLW2J9qTjbiM67OIsgQGRT7otGFzWBXfd6XCx9jSKRy8Xz2gFSM0mD6ftPxrqgorgcqxsaCJNaMtzvhMzg90SW/09R/+LwJ3L7XJZxs1hFP75Q7VNXBGIVzmIX3BiP4GGdDbY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KrY2NLGe
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 616BE4BA2E2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KrY2NLGe
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3a49623b865so2738211a91.0
        for <cygwin-patches@cygwin.com>; Wed, 07 Oct 2026 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791398788; x=1792003588; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=spkkevPsn5QPujZsk0H/KcqFhhckMG+MpN87/dqzP/g=;
        b=KrY2NLGe2z1q1vNl5jOxuE3B1jBWIkAsoRTyN8fRWlhulxf9MrYB5+gYRTZPEC4bAr
         OmJWo2Kksk59H53y3U7lUr8TAhuuaKEWrq/eTB2q2o4TEvdNb+DS813gIKM5tf7tDtMh
         odmndMu5XSVkqOuVZSYiU7XAZ+QBHNY7BI1HbUZAWPUleFTCzEWgQMDydPaSv3lO9ec7
         +08xiYCkz3M+A1U27zevtt8L+mZI/bmhGUQPi/WtJJQ3es08+68z3vBgqlIPkh81gZy9
         7zCyXHtnI5Co7Hz1sfcCLKCIgOlU0ZIrsejRbd6Bv8Fe3mV8o4pINh072d8tRq5n/6K5
         P3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791398788; x=1792003588;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=spkkevPsn5QPujZsk0H/KcqFhhckMG+MpN87/dqzP/g=;
        b=DqdUNZXPV4zbRL+bPU34CE+6YwIE9A5dU1VA+XaSOAwzMfZo9wJgkWfFQ29AWksKWQ
         xiQZS9V+ffcKqq6/DiHhwP+GgWnSBjZLUSOS5jiEWA2xTIMuFErRvlcRgDtfRow6FiVP
         YiNjNxcR5alLsSnOGYuLbyZ1U4IlUpJeOeghvyZbILcUT0g/BhtcXY7PH03ikb30nd7j
         ipnLdJJOgWnyzYnezX9jtjOJIjA+E+u8+6deUZX9NL1EW1prfd4MMsO9CtAS4itcwZ/V
         cDeqeUH7i/LnNx6+ovBKAcDbvecypPlwOSRrZNGGNTtP1eq2R0WaV3odIP0q8qBUvvyI
         sldQ==
X-Gm-Message-State: AFq9FYLb8Um8cjWLjVQqb4ZRISZ/ewWFvoBbxtrSt00du16sK3QE725t
	TA+K/xxDvOEWDxkdSMuFZCTntA+DPZ4I7k10XXDyW0UYzPzMk/dJVkkjfWRYzA==
X-Gm-Gg: AYBFou0eda7s6ZCt9kMlYOap9Q4z+2XhpQm3a5NcIQqvCJ6eU1NDCY1Tr9f+O03Eh9r
	wA38LPM9hByPPhuY3piZmvz9n7jsDUNnbBQ39w7DSXmiBq0PHLdMylXVbfsMCZQPyIQqYPCeVO6
	B6M3pGP53fp5F7J7SfpYXNbqz6ENNfZ7jbBci+34cNwA7fg9az7GqEUSVF0yTGIdnTCasarMlT+
	vj0VAOtubF+IrEaScciwAo/rri2QXTkoCsbHvF7gEQHP80JLY8GB+g8Ns5ue4C0JT6cXBhW9h/z
	BBDVyzmowccyirmbRSeXzz4zAyN+5WnYfMj++J2F0SKIlRmMcVJ3MMm7fSxuFzoNLISrOLa+wFN
	+749kcgVIM8B/tbck7HMwIisdS5+X1jOVmlL12ri9VQHHWZjUM7TRnrSHmcMUVPxYHyPyWOQjld
	3bp8YK/qXB3pY+tUnIiCRg7dSHAO3tlP7bVp35xw6G7l3fmBdn+7lk1lQhdjiF4dAtIDO6kAZy
X-Received: by 2002:a17:90b:4fc5:b0:3a7:db88:3495 with SMTP id 98e67ed59e1d1-3a8a1d5b8fcmr2722516a91.52.1791398788268;
        Wed, 07 Oct 2026 11:46:28 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.6.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aa0cc1fbb2sm620901a91.17.2026.10.07.11.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:46:27 -0700 (PDT)
Message-Id: <pull.12.cygwin.1791398786755.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 18:46:26 +0000
Subject: [PATCH] Cygwin: signal: preserve runtime nesting across user handlers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CMake/libuv `posix_spawn` callers can hang waiting for `SIGCHLD` after
nested signal delivery. Restoring `_cygtls::incyg` to `1` loses the
concrete nesting level; subsequent balancing can leave it at zero,
disabling the controlled signal-wakeup path.

Preserve the incoming count, including zero, to keep runtime nesting
balanced. The public-API regression targets lost wakeups after nested
delivery, including within `pthread_once`.

This was suggested by Takashi Yano on May 28th, 2025 in
https://inbox.sourceware.org/cygwin-patches/20250528125311.2589-1-takashi.yano@nifty.ne.jp/,
part of which was applied as 8201c57dd1 (Cygwin: signal: Revert
_cygtls::inside_kernel() change, 2025-05-28). The remaining part is what
is applied here, together with a regression test that exercises the code
path that is fixed by it.

Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Cygwin: signal: preserve runtime nesting across user handlers
    
    This patch addresses the hangs experienced in
    https://github.com/msys2/msys2-runtime/pull/375#issuecomment-5967746825.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-12%2Fdscho%2Favoid-hangs-in-signal-handling-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-12/dscho/avoid-hangs-in-signal-handling-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/12

 winsup/cygwin/exceptions.cc                 |  3 +-
 winsup/cygwin/release/3.6.11                |  3 ++
 winsup/testsuite/Makefile.am                |  1 +
 winsup/testsuite/winsup.api/pthread/once2.c | 60 +++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 winsup/testsuite/winsup.api/pthread/once2.c

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 138ef5a74..df7c9bad3 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1837,6 +1837,7 @@ _cygtls::call_signal_handler ()
 
       int this_errno = saved_errno;
       reset_signal_arrived ();
+      unsigned incyg_orig = incyg;
       incyg = 0;
       current_sig = 0;	/* Flag that we can accept another signal */
 
@@ -1950,7 +1951,7 @@ _cygtls::call_signal_handler ()
 	}
       unlock ();
 
-      incyg = 1;
+      incyg = incyg_orig;
 
       set_signal_mask (_my_tls.sigmask, (this_sa_flags & SA_SIGINFO)
 					? context1.uc_sigmask : this_oldmask);
diff --git a/winsup/cygwin/release/3.6.11 b/winsup/cygwin/release/3.6.11
index a31435834..4deecfd01 100644
--- a/winsup/cygwin/release/3.6.11
+++ b/winsup/cygwin/release/3.6.11
@@ -24,3 +24,6 @@ Fixes:
   Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.html
 
 - Fix a few more historical console bugs.
+
+- Preserve runtime nesting across signal handlers, fixing potential hangs
+  in posix_spawn callers such as CMake.
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 8f2967a6d..65320a8aa 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -298,6 +298,7 @@ check_PROGRAMS = \
 	winsup.api/pthread/mutex8n \
 	winsup.api/pthread/mutex8r \
 	winsup.api/pthread/once1 \
+	winsup.api/pthread/once2 \
 	winsup.api/pthread/priority1 \
 	winsup.api/pthread/priority2 \
 	winsup.api/pthread/rwlock1 \
diff --git a/winsup/testsuite/winsup.api/pthread/once2.c b/winsup/testsuite/winsup.api/pthread/once2.c
new file mode 100644
index 000000000..7da165370
--- /dev/null
+++ b/winsup/testsuite/winsup.api/pthread/once2.c
@@ -0,0 +1,60 @@
+/* Test signal delivery after a pthread_once initializer handles a signal. */
+
+#include "test.h"
+#include <poll.h>
+#include <signal.h>
+#include <time.h>
+
+static volatile sig_atomic_t seen;
+
+static void
+handler (int signo)
+{
+  (void) signo;
+  ++seen;
+}
+
+static void
+initialize (void)
+{
+  assert (raise (SIGALRM) == 0);
+}
+
+int
+main (void)
+{
+  struct sigaction action = {0};
+  stack_t stack = {0};
+  stack.ss_sp = malloc (SIGSTKSZ);
+  stack.ss_size = SIGSTKSZ;
+  assert (stack.ss_sp != NULL);
+  assert (sigaltstack (&stack, NULL) == 0);
+
+  action.sa_handler = handler;
+  assert (sigemptyset (&action.sa_mask) == 0);
+
+  for (int onstack = 0; onstack < 2; ++onstack)
+    {
+      pthread_once_t once = PTHREAD_ONCE_INIT;
+      action.sa_flags = onstack ? SA_ONSTACK : 0;
+      assert (sigaction (SIGALRM, &action, NULL) == 0);
+      seen = 0;
+      assert (pthread_once (&once, initialize) == 0);
+      assert (seen == 1);
+
+      struct timespec before, after;
+      assert (clock_gettime (CLOCK_MONOTONIC, &before) == 0);
+      alarm (1);
+      assert (poll (NULL, 0, 5000) == -1 && errno == EINTR);
+      assert (clock_gettime (CLOCK_MONOTONIC, &after) == 0);
+      long elapsed_ms = (after.tv_sec - before.tv_sec) * 1000
+			+ (after.tv_nsec - before.tv_nsec) / 1000000;
+      assert (elapsed_ms < 4000);
+      assert (seen == 2);
+    }
+
+  stack.ss_flags = SS_DISABLE;
+  assert (sigaltstack (&stack, NULL) == 0);
+  free (stack.ss_sp);
+  return 0;
+}

base-commit: 867eb7748e6e5a0e8430ce9f46af27b4b1e8f204
-- 
cygwingitgadget

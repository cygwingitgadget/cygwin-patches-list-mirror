Return-Path: <SRS0=Hss8=SF=gmail.com=shnusongshaobo@sourceware.org>
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by sourceware.org (Postfix) with ESMTPS id 54DC13858D21
	for <cygwin-patches@cygwin.com>; Sun, 10 Nov 2024 03:13:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 54DC13858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 54DC13858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::435
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731208388; cv=none;
	b=QCcanAvyAR6nzux0Wlo81hWHLy0bk8luxJzA3HAynDmdVjprxuvuJyfM80sYQkifPRB7B2ST9WHvWs15pnrgK4ePoqmNxipjwt92e82sSp/Gc1w4WWXXCVpEEzGSaksRiaJsHbCER8xGEExMANUYeisNMkY5wF10srgmBYOSNfs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731208388; c=relaxed/simple;
	bh=7f+BzpISfyNZpJjS7DrvlEQqn3Eb85jrzpqAD8HHUuY=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=uF56odpJ+JiUMFdRBfvnmXnaQoZRhMhBqA08XUbM66oyQgVhGdnNTQLqSsfB3CuTcqQJ+F9K5ti4lVFxI1LW0n88BSBs/twpiJJQiJp4K6l+bfMdP8RbYBFzjwBz6N5z28NGxa1YBec42Ak0BfTcK9YesxFF6+kw0zFJ2LGY81o=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso3148398b3a.2
        for <cygwin-patches@cygwin.com>; Sat, 09 Nov 2024 19:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731208385; x=1731813185; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhy14fyjw5yJNN9ZJHqyrNKSv27dGs0/VvglVHeu39k=;
        b=lY/Veuzb/Mivkh3ibE33Y9BPQV9DftKPCyVIx/n2h0lUvoRqtoTZu8YytDjzBF4T0N
         ZSZDfowzWYcrORdadPj7o0zn3W50R2yXpb6321bcugU9FrX2Ar9B0BPtkFzoQGZWkLcE
         OV1a7Mg4NKunAzC1nnNPZBbkJJ+LtUNFhL/7yu3dU0fcu2FBEb/CtCoPN6jQvZGFr/W6
         5lPGf2vYcArNtfln0vTWkrIW0UigkKbzaWUjfzkUd0ctw2E9HNoSBwmJsRn6prEap9h7
         /c8h/I5cuaboFO3/U1AP5jmIb4F4Y7siogI81vMXvrRBa0Bc5W6IPXlyaF3pNROq6OI3
         NOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731208385; x=1731813185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vhy14fyjw5yJNN9ZJHqyrNKSv27dGs0/VvglVHeu39k=;
        b=GAohqKxyY7YwDAFqzZIDrEOFerbOJ3GVQ7dg6cYkYGTR+FJLkf7e78iU4q0gYDSBjo
         7ClxYTrwD0aYZLAFrpjMR0fgYKSm5gUPHTn5JqAu4+qtiwT2OAalCadIDLcTz/gidnd6
         5AMFofMO8MULJE6pvOZzk+556sWz604xsSgyeqZMtm7q7xr1HxBaG3ZUopLQHwEUrTXg
         pjfJ4vAg2UQ3mdyZcj8rt+8QzwaOJDk84hpEDQS1JaKijNeWyST4RnnTabZfbN6IH4ow
         cetVQGfP8mD2VHvNtca89Ja1ZYA712imjpsReMJKEadcO3Xd8PbYUHTxEdgq9+nNgwTG
         n0Rw==
X-Gm-Message-State: AOJu0Ywevh/QjBBjrd1aUzqQRBZn3EN8l2uBuZiZKW+riqiL8nnS6rYu
	EfDr13Ct6XzgSep+YBgEsogsVL2sUOvnyViJsrmPSIhtGK6Orh2itv2DPb9xzIM=
X-Google-Smtp-Source: AGHT+IFda5TItoEABYVKqSgjxWAkIdEq4znEmjlNVGwxdk8GWKpvdfTWHRzNRZhCtobXTRpaTtkdFQ==
X-Received: by 2002:a05:6a20:4313:b0:1db:f0af:2277 with SMTP id adf61e73a8af0-1dc22b90c76mr13049340637.38.1731208385125;
        Sat, 09 Nov 2024 19:13:05 -0800 (PST)
Received: from localhost.localdomain ([60.179.215.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm5943644a12.76.2024.11.09.19.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 19:13:04 -0800 (PST)
From: Shaobo Song <shnusongshaobo@gmail.com>
To: cygwin-patches@cygwin.com
Cc: takashi.yano@nifty.ne.jp,
	Shaobo Song <shnusongshaobo@gmail.com>
Subject: [PATCH] Cygwin: pthread: Correct pthread_cleanup macros to avoid potential syntax errors
Date: Sun, 10 Nov 2024 11:12:39 +0800
Message-Id: <20241110031239.10960-1-shnusongshaobo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This commit revises `pthread_cleanup_push` and `pthread_cleanup_pop` macros to
use a `do { ... } while(0)` wrapper, preventing syntax errors when used in
certain contexts. The original code could fail if used within a conditional
statement without braces, causing unintended behavior or compilation issues.
Example of error:

  if (condition)
      pthread_cleanup_push(cleanup_fn, arg);
  pthread_cleanup_pop(1);

This would fail due to unmatched braces in the macro expansion. The new
structure ensures the macro expands correctly in all cases.

Signed-off-by: Shaobo Song <shnusongshaobo@gmail.com>
---
 winsup/cygwin/include/pthread.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 66d367d62..1f8f0881d 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -110,10 +110,13 @@ typedef struct _pthread_cleanup_handler
 void _pthread_cleanup_push (__pthread_cleanup_handler *handler);
 void _pthread_cleanup_pop (int execute);
 
-#define pthread_cleanup_push(_fn, _arg) { __pthread_cleanup_handler __cleanup_handler = \
-					 { _fn, _arg, NULL }; \
-					 _pthread_cleanup_push( &__cleanup_handler );
-#define pthread_cleanup_pop(_execute) _pthread_cleanup_pop( _execute ); }
+#define pthread_cleanup_push(_fn, _arg)
+  do { \
+    __pthread_cleanup_handler __cleanup_handler = { _fn, _arg, NULL }; \
+    _pthread_cleanup_push(&__cleanup_handler)
+#define pthread_cleanup_pop(_execute) \
+    _pthread_cleanup_pop(_execute); \
+  } while (0)
 
 /* Condition variables */
 int pthread_cond_broadcast (pthread_cond_t *);
-- 
2.25.1


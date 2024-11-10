Return-Path: <SRS0=Hss8=SF=gmail.com=shnusongshaobo@sourceware.org>
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by sourceware.org (Postfix) with ESMTPS id 433933858D21
	for <cygwin-patches@cygwin.com>; Sun, 10 Nov 2024 04:15:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 433933858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 433933858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::430
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731212155; cv=none;
	b=f0axWtYHsHVv9DPpeS53aB9UMM1q11/5Lyc9OHcpmlPreHJMUezYh20TIM1R41T7Ic2DyDy0ruXawqs5VFxOgvIkfRt3acOQ/1squLPdnWUaV3wS0UiRrZ3/g5roiURMDyeQ3rU6UMCEteQna8u6bIceDHbTZIBqoT8XeCEUIgs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731212155; c=relaxed/simple;
	bh=MIE7NMi9DpthtvE0yu6Pz+qTjtlZCMy1EwXazVeAKxo=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=j4XLDtyngqbG7UyjiO4FzQE6KhLOwVFEOMwGYL9ZpyT1FZA/0Utg69GUw3M+7qpc5YJfhfd3hMOn86pcZd1leapFzwDpOkXmrbpkgEkmr+QuBTOKYUCve5yGqRjohWEligFb1MSDsOU3yoAd90OGJIQMZeLJZpcodP/RKL8cGQo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2849237b3a.3
        for <cygwin-patches@cygwin.com>; Sat, 09 Nov 2024 20:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731212152; x=1731816952; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12KubY/bfbK/3FdfcNtPureX7yM63sySqDwUAyDCbGM=;
        b=OztGMj09Uv7y3aFEGV1v0L7Viqtaeg98mwpnnFPEAvuvqGFqfudd1B+PNrzhfBLAEN
         AcPZTsMBvQxAmr2KS5NXT4EnU+TTREs0h7Ef0D2CO84UAQGAT2POCvlOPmpZGVh0v1ci
         wd67wMGLFTzhkWHPxAULR+AosF4GDBD4KIcKFT52lHTzDU6ujP5Q55UpDwQA/WUu7eRD
         aVm7Tu4xB3T18AnGb8o9N28C1U16jPovHecm1Hxb7IitjUGGK3oyIOM1x7KOgwqJTaWR
         suKiAnbGmPirPrZKU05mQzdf5PccaTVIUza+AV2f4Y8JM+q3iApGNDzPfl9mH2f08B/x
         wN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731212152; x=1731816952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12KubY/bfbK/3FdfcNtPureX7yM63sySqDwUAyDCbGM=;
        b=I15wCZMbFPGll2we3rTkxGSXGkQcRMlU2lEP27ElD62RTkWG+0SVQop+GomOlrtKYE
         DSQIxOkPLf0aJaOqk97OfEIAjqqpFpH/V2C018HgA3CQ9M4X14cg8+NqTzN1ERPc026i
         GYtTL7XDf7F67IJPRUCN9fs2Noxx8WzmtUVkhDn46g/wJhvKiObKC1Py2Ly/zRtC5CBS
         V3xUO/edYHWIe8DWtDAiWWgg3lozfCPzjnwe0EXgIEKLi1g/IQ4B+UUZ+JUjQ7OoJ5VM
         JNBPehJE01g6rZRdCljbG+d3HND9xUW/vcWj/xrv37MWl7klbvswC3v+sKDP9LL+n4UW
         JwRQ==
X-Gm-Message-State: AOJu0YzFxqKxLs5Gg0Y5Rt/ElmqHSsOSVPfvQ56M3pX6NG6nVateFG5K
	I24VuvElJb8jP963Ar2rdpcCjmhGSBTE9myEDyyAuneML6NAMFoq/wcB+pxu3Ec=
X-Google-Smtp-Source: AGHT+IGfujpet53vYq6laUzfMiB7wj/aBo+uxRHLWLzXKZXHgvCC5PZK7d/TThj09O6HTVctNrsI6A==
X-Received: by 2002:a05:6a00:1819:b0:71d:f510:b791 with SMTP id d2e1a72fcca58-724132cd1b1mr12005328b3a.12.1731212151873;
        Sat, 09 Nov 2024 20:15:51 -0800 (PST)
Received: from localhost.localdomain ([148.135.115.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a8446sm6367179b3a.113.2024.11.09.20.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 20:15:51 -0800 (PST)
From: Shaobo Song <shnusongshaobo@gmail.com>
To: cygwin-patches@cygwin.com
Cc: takashi.yano@nifty.ne.jp,
	Shaobo Song <shnusongshaobo@gmail.com>
Subject: [PATCH v3] Cygwin: pthread: Correct pthread_cleanup macros to avoid potential syntax errors
Date: Sun, 10 Nov 2024 12:15:04 +0800
Message-Id: <20241110041504.16520-1-shnusongshaobo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This commit revises `pthread_cleanup_push` and `pthread_cleanup_pop` macros to
use a `do { ... } while(0)` wrapper, preventing syntax errors when used in
certain contexts. The original code could fail when they are wrapped within a
`do { ... } while(0)`, causing unintended behavior or compilation issues.
Example of error:

  #include <pthread.h>

  #define pthread_cleanup_push_wrapper(_fn, _arg) do { \
    pthread_cleanup_push(_fn, _arg); \
  } while (0)

  #define pthread_cleanup_pop_wrapper(_execute) do { \
    pthread_cleanup_pop(_execute); \
  } while (0)

  void cleanup_fn (void *arg) {}

  void *thread_func (void *arg)
  {
    pthread_cleanup_push_wrapper(cleanup_fn, NULL);
    pthread_cleanup_pop_wrapper(1);
    return NULL;
  }

  int main (int argc, char **argv) {
    pthread_t thread_id;
    pthread_create(&thread_id, NULL, thread_func, NULL);
  }

This would fail due to unmatched braces in the macro expansion. The new
structure ensures the macro expands correctly in all cases.

Signed-off-by: Shaobo Song <shnusongshaobo@gmail.com>
---
 winsup/cygwin/include/pthread.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 66d367d62..cf2fcb04b 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -110,10 +110,13 @@ typedef struct _pthread_cleanup_handler
 void _pthread_cleanup_push (__pthread_cleanup_handler *handler);
 void _pthread_cleanup_pop (int execute);
 
-#define pthread_cleanup_push(_fn, _arg) { __pthread_cleanup_handler __cleanup_handler = \
-					 { _fn, _arg, NULL }; \
-					 _pthread_cleanup_push( &__cleanup_handler );
-#define pthread_cleanup_pop(_execute) _pthread_cleanup_pop( _execute ); }
+#define pthread_cleanup_push(_fn, _arg) \
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


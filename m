Return-Path: <SRS0=Hss8=SF=gmail.com=shnusongshaobo@sourceware.org>
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by sourceware.org (Postfix) with ESMTPS id 47E3F3858D28
	for <cygwin-patches@cygwin.com>; Sun, 10 Nov 2024 03:25:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 47E3F3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 47E3F3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::62f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731209141; cv=none;
	b=xxy3KTUWaVwAOi2W4veaCF7TUIbQ9eM0r1wfI88OsdLfrq/nC2HWCdq0VAEa3ubkOcpSj5V9yB5y3gYIO5zCImg7xth0yMjyF14ZXda9HRDNHO1yR1pNg1SwDG7dyIOYu12Dm5ILAtjBGLnl+o2PxbDmhLyU2hMhpTElc7pd/eI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731209141; c=relaxed/simple;
	bh=YGJeTtYGqcBcyBtsJPNLWBHNYrh5AzzL12ESanNsv90=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=c5WjsBY4IPKUhWohFrq0Tdusd/CcJKHppwtJo1XgAQj26svCnml0NBjuXLUEN1ycsjbL0aU8c1nSnUo+1a1WorfNUCC617Mahn/NWKb9OzncUWial2gd+Ys1GOwdxj6UtNGUmrxxfyKV6QGdq8CQKYFQHNiKnOeOaqcNMCM7hYY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-20c8b557f91so37672135ad.2
        for <cygwin-patches@cygwin.com>; Sat, 09 Nov 2024 19:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731209136; x=1731813936; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u3iUlgmdystCpZqJZXHcGsk8zq4BiJ0yimzEaTMymaM=;
        b=IzeU6tCTyBs31Dso83KjU5QxfuWPMki15r5X7gqf0kYjPcY/wWKPv/tUXU+8QDU8Sf
         q1x9mgG/QB0RFr/ZHJU24uneEdUi9KysAAOOdS6Uvamf5oPLNVQ+A6D/m5ScY21N/Pnj
         NFMsM8NbpUZ/Tw2ZCcl4TVYEWRN+5lfrKauGq/K/OCcfH+5SA8TMzYKjZGkVdmLcEss2
         yuVyAdTP4Q6sYM2Kmjdcg8ZdUMABGgbs/XXaAKaKAqcTWbLCcf9wSNrs//eywGuCLEs7
         rauMXGIYH8HCP37TkzZPOZp5sve+n8nE1PpsjwfLQYudlTtj3RRzJb/0naa0QdXkCzWc
         hk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731209136; x=1731813936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3iUlgmdystCpZqJZXHcGsk8zq4BiJ0yimzEaTMymaM=;
        b=OAiBmDKvXe4P5wirTqtBGxR+22bZ+2x5MyZKzjCLnh7NCJSVOE5Pf72jQpgWpSQZSO
         q1vLimJUCVFag3yfOsXYpM/dysxA3u9DHwIkJ2FOEV19J7vrT3gGr3SKIXSNIy0WI40O
         RWpsP0LZKA4LlD75waz/iuF4j/3r92K8NABoWVmUxrkq3MCl559XOYgZOGcrWnvxvyKT
         AesAnZIcQnwt73RpXZFSgtCdGt1wGoZcf2Kws1t4Qh8mGcvLuWQgb1j2TNhPZ6wKDUjJ
         KyGNn2gA1QqojIhF8dQtvM2GWGDdwjD2IYGH+XyWyAymOALTtVT+8cbzIEBCW6XygqPP
         O+Fg==
X-Gm-Message-State: AOJu0YyqyABTgKkYpyl9p1Mf/6qryF7WjhZRCsW00liXSwtPDRVi+oUs
	b7KlR4tf9fuYo2cy/UOEO4rIapVnvW90y5Rtwcc9FiunAaEwOo96tlsPRRQaLyI=
X-Google-Smtp-Source: AGHT+IH9L3uVqjJkxPTd36bzy4VbXGi8nOCZbgg/GlCKgKsuZ4rUeZoDVpwDHdZsQ2jwdA+icumdqw==
X-Received: by 2002:a17:903:11c6:b0:20e:5792:32ed with SMTP id d9443c01a7336-21183d6795fmr86416945ad.41.1731209135920;
        Sat, 09 Nov 2024 19:25:35 -0800 (PST)
Received: from localhost.localdomain ([60.179.215.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e590fcsm52156345ad.202.2024.11.09.19.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 19:25:35 -0800 (PST)
From: Shaobo Song <shnusongshaobo@gmail.com>
To: cygwin-patches@cygwin.com
Cc: takashi.yano@nifty.ne.jp,
	Shaobo Song <shnusongshaobo@gmail.com>
Subject: [PATCH v2] Cygwin: pthread: Correct pthread_cleanup macros to avoid potential syntax errors
Date: Sun, 10 Nov 2024 11:25:03 +0800
Message-Id: <20241110032503.12604-1-shnusongshaobo@gmail.com>
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


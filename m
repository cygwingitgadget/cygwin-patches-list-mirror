Return-Path: <schn27@gmail.com>
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by sourceware.org (Postfix) with ESMTPS id 3410F3858022
 for <cygwin-patches@cygwin.com>; Mon, 23 Aug 2021 14:28:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3410F3858022
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-x130.google.com with SMTP id v19so13055010lfo.7
 for <cygwin-patches@cygwin.com>; Mon, 23 Aug 2021 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Asz5lbGFmLK+suEgi9D0rZvHxpX9tEAYI8itKRwxCDw=;
 b=OR5LlOBXosBLOW9wj1/ThUp8O/Rgc4AKGikh6vvAzWXli93lMq3KH5RHBcvK+a+NyM
 xJGEGTlylsPcsOMVsqk48ZJnsOKSDXRCHemh2xms6w/ds3otyOHXNAbNK1LjDYWUScXl
 mX2lT8QLGQIQ8OPOngjHKElwt2cnuUvhRhhTJWHTBDi4U6GeOrWRxo+9gDE4awNvDRKs
 KotqtoO0na+kb8HPZkFC9FOdAdivzbnAR1bkXEDLb/fu5uGupP+57XxBeVRNxzx4s83/
 SlO5QyAf3Nmdk1+xqAHDVoxwyRU4UJDDAUAuvutvgPk0SnKUepVypg3NinGPS6cZoCp6
 SHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Asz5lbGFmLK+suEgi9D0rZvHxpX9tEAYI8itKRwxCDw=;
 b=ItkV47RHgxd5xLDfe8lW+/Dszp1kG/2RMBkshyPdmauhuMPbQ9Q/edAeLSfr47FeY6
 QQanOKRs6E2VCyilpJR+Q0D7iyPZb34lXch21VREZSkqOa5eL/1Tpd2W9AQQ4ZoH9xGQ
 RHFKtlZFQDFztEP3GKFKYgqoVJO71At01plaQiBnCaVbpAsWmmPqwvOhxfOJ1syLmYkk
 TMDV4BlAHGpGKCrPW4BT5rzvKLjC5G8Umb57fljpEkOQ1VmrKZUHU3MHikC4Bkc4RuqH
 DoNVwpx7Omjt5r15gygdNjU9OSY3aI6pzNzpjvwpACla0MlcAKZpodBhKKoZqw6qE/s1
 giCA==
X-Gm-Message-State: AOAM530q1whjgjUHXf6yD5gtCpgjiNNxxTmyo/OHdPnSeFP3xD3Z4Qlh
 Aw+6UP6kNpGqUWftih9T17IOkQhh4xw=
X-Google-Smtp-Source: ABdhPJwo/Q83Ooql7F5kf5wrZVDPv/BHvhwyoZGI3LkvPBqoKLLxefODPIPHJCrz1dqQcZmzIKpZwQ==
X-Received: by 2002:ac2:4552:: with SMTP id j18mr24115528lfm.3.1629728884668; 
 Mon, 23 Aug 2021 07:28:04 -0700 (PDT)
Received: from localhost.localdomain ([188.243.182.161])
 by smtp.gmail.com with ESMTPSA id g17sm1455155lfv.34.2021.08.23.07.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 07:28:03 -0700 (PDT)
From: Aleksandr Malikov <schn27@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fix race condition in List_insert
Date: Mon, 23 Aug 2021 17:27:48 +0300
Message-Id: <20210823142748.1012-1-schn27@gmail.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 23 Aug 2021 14:28:16 -0000

From: Aleksand Malikov <schn27@gmail.com>

Revert mx parameter and mutex lock while operating the list.
Mutex was removed with 94d24160 informing that:
'Use InterlockedCompareExchangePointer to ensure race safeness
without using a mutex.'

But it does not.

Calling pthread_mutex_init and pthread_mutex_destroy from two or
more threads occasionally leads to hang in pthread_mutex_destroy.

To not change the behaviour of other cases where List_insert was called,
List_insert_nolock is added.
---
 winsup/cygwin/thread.cc |  8 ++++----
 winsup/cygwin/thread.h  | 17 +++++++++++++++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 4d0ea27..7c6a919 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -1595,7 +1595,7 @@ pthread_rwlock::add_reader ()
 {
   RWLOCK_READER *rd = new RWLOCK_READER;
   if (rd)
-    List_insert (readers, rd);
+    List_insert_nolock (readers, rd);
   return rd;
 }
 
@@ -2165,7 +2165,7 @@ pthread::atfork (void (*prepare)(void), void (*parent)(void), void (*child)(void
   if (prepcb)
   {
     prepcb->cb = prepare;
-    List_insert (MT_INTERFACE->pthread_prepare, prepcb);
+    List_insert_nolock (MT_INTERFACE->pthread_prepare, prepcb);
   }
   if (parentcb)
   {
@@ -2174,7 +2174,7 @@ pthread::atfork (void (*prepare)(void), void (*parent)(void), void (*child)(void
     while (*t)
       t = &(*t)->next;
     /* t = pointer to last next in the list */
-    List_insert (*t, parentcb);
+    List_insert_nolock (*t, parentcb);
   }
   if (childcb)
   {
@@ -2183,7 +2183,7 @@ pthread::atfork (void (*prepare)(void), void (*parent)(void), void (*child)(void
     while (*t)
       t = &(*t)->next;
     /* t = pointer to last next in the list */
-    List_insert (*t, childcb);
+    List_insert_nolock (*t, childcb);
   }
   return 0;
 }
diff --git a/winsup/cygwin/thread.h b/winsup/cygwin/thread.h
index 6b699cc..ddb2d7d 100644
--- a/winsup/cygwin/thread.h
+++ b/winsup/cygwin/thread.h
@@ -111,7 +111,20 @@ typedef enum
 } verifyable_object_state;
 
 template <class list_node> inline void
-List_insert (list_node *&head, list_node *node)
+List_insert (fast_mutex &mx, list_node *&head, list_node *node)
+{
+  if (!node)
+    return;
+  mx.lock ();
+  do
+    node->next = head;
+  while (InterlockedCompareExchangePointer ((PVOID volatile *) &head,
+					    node, node->next) != node->next);
+  mx.unlock ();
+}
+
+template <class list_node> inline void
+List_insert_nolock (list_node *&head, list_node *node)
 {
   if (!node)
     return;
@@ -163,7 +176,7 @@ template <class list_node> class List
 
   void insert (list_node *node)
   {
-    List_insert (head, node);
+    List_insert (mx, head, node);
   }
 
   void remove (list_node *node)
-- 
2.32.0.windows.2


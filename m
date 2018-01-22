Return-Path: <cygwin-patches-return-9014-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48371 invoked by alias); 22 Jan 2018 05:52:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48351 invoked by uid 89); 22 Jan 2018 05:52:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=HX-Greylist:Mon, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jan 2018 05:52:05 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id A53A48123D	for <cygwin-patches@cygwin.com>; Mon, 22 Jan 2018 05:52:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-8.rdu2.redhat.com [10.10.120.8])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 332797D4F6	for <cygwin-patches@cygwin.com>; Mon, 22 Jan 2018 05:52:04 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: Declare pthread_rwlock_timedrdlock, pthread_rwlock_timedwrlock
Date: Mon, 22 Jan 2018 05:52:00 -0000
Message-Id: <20180122055151.12900-1-yselkowi@redhat.com>
X-SW-Source: 2018-q1/txt/msg00022.txt.bz2

These were added in commit 8128f5482f2b1889e2336488e9d45a33c9972d11 but
without their public declarations.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/pthread.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 6d3bfd0eb..3dfc2bc80 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -191,8 +191,12 @@ int pthread_spin_unlock (pthread_spinlock_t *);
 int pthread_rwlock_destroy (pthread_rwlock_t *rwlock);
 int pthread_rwlock_init (pthread_rwlock_t *rwlock, const pthread_rwlockattr_t *attr);
 int pthread_rwlock_rdlock (pthread_rwlock_t *rwlock);
+int pthread_rwlock_timedrdlock (pthread_rwlock_t *rwlock,
+				const struct timespec *abstime);
 int pthread_rwlock_tryrdlock (pthread_rwlock_t *rwlock);
 int pthread_rwlock_wrlock (pthread_rwlock_t *rwlock);
+int pthread_rwlock_timedwrlock (pthread_rwlock_t *rwlock,
+				const struct timespec *abstime);
 int pthread_rwlock_trywrlock (pthread_rwlock_t *rwlock);
 int pthread_rwlock_unlock (pthread_rwlock_t *rwlock);
 int pthread_rwlockattr_init (pthread_rwlockattr_t *rwlockattr);
-- 
2.15.1

Return-Path: <cygwin-patches-return-8542-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76890 invoked by alias); 1 Apr 2016 23:40:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76866 invoked by uid 89); 1 Apr 2016 23:40:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=sigval, locks, Locks, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 01 Apr 2016 23:39:55 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id D6AEF1E21	for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2016 23:39:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u31NdqUv030275	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 1 Apr 2016 19:39:53 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/4] Feature test macros overhaul: Cygwin pthread.h
Date: Fri, 01 Apr 2016 23:40:00 -0000
Message-Id: <1459553988-14384-1-git-send-email-yselkowi@redhat.com>
In-Reply-To: <1459551179-9404-1-git-send-email-yselkowi@redhat.com>
References: <1459551179-9404-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q2/txt/msg00017.txt.bz2

As a Cygwin-specific header, there is no need to guard functions based on
capability macros.  Instead, guard several blocks based on additions or
removals in later versions of POSIX.1, along with a few which are only
XSI or GNU extensions.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/pthread.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 84e0a14..83631dd 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -75,9 +75,6 @@ int pthread_attr_getinheritsched (const pthread_attr_t *, int *);
 int pthread_attr_getschedparam (const pthread_attr_t *, struct sched_param *);
 int pthread_attr_getschedpolicy (const pthread_attr_t *, int *);
 int pthread_attr_getscope (const pthread_attr_t *, int *);
-int pthread_attr_getstack (const pthread_attr_t *, void **, size_t *);
-int pthread_attr_getstackaddr (const pthread_attr_t *, void **)
-    __attribute__ ((__deprecated__));
 int pthread_attr_init (pthread_attr_t *);
 int pthread_attr_setdetachstate (pthread_attr_t *, int);
 int pthread_attr_setguardsize (pthread_attr_t *, size_t);
@@ -86,16 +83,18 @@ int pthread_attr_setschedparam (pthread_attr_t *, const struct sched_param *);
 int pthread_attr_setschedpolicy (pthread_attr_t *, int);
 int pthread_attr_setscope (pthread_attr_t *, int);
 
-#ifdef _POSIX_THREAD_ATTR_STACKADDR
+#if __POSIX_VISIBLE >= 200112
+int pthread_attr_getstack (const pthread_attr_t *, void **, size_t *);
 int pthread_attr_setstack (pthread_attr_t *, void *, size_t);
+#endif
+#if __POSIX_VISIBLE < 200809
+int pthread_attr_getstackaddr (const pthread_attr_t *, void **)
+    __attribute__ ((__deprecated__));
 int pthread_attr_setstackaddr (pthread_attr_t *, void *)
     __attribute__ ((__deprecated__));
 #endif
-
-#ifdef _POSIX_THREAD_ATTR_STACKSIZE
 int pthread_attr_getstacksize (const pthread_attr_t *, size_t *);
 int pthread_attr_setstacksize (pthread_attr_t *, size_t);
-#endif
 
 int pthread_cancel (pthread_t);
 /* Macros for cleanup_push and pop;
@@ -135,6 +134,7 @@ int pthread_condattr_setclock (pthread_condattr_t *, clockid_t);
 int pthread_condattr_setpshared (pthread_condattr_t *, int);
 
 /* Barriers */
+#if __POSIX_VISIBLE >= 200112
 int pthread_barrierattr_init (pthread_barrierattr_t *);
 int pthread_barrierattr_setpshared (pthread_barrierattr_t *, int);
 int pthread_barrierattr_getpshared (const pthread_barrierattr_t *, int *);
@@ -143,6 +143,7 @@ int pthread_barrier_init (pthread_barrier_t *,
                           const pthread_barrierattr_t *, unsigned);
 int pthread_barrier_destroy (pthread_barrier_t *);
 int pthread_barrier_wait (pthread_barrier_t *);
+#endif
 
 /* Threads */
 int pthread_create (pthread_t *, const pthread_attr_t *,
@@ -150,7 +151,9 @@ int pthread_create (pthread_t *, const pthread_attr_t *,
 int pthread_detach (pthread_t);
 int pthread_equal (pthread_t, pthread_t);
 void pthread_exit (void *) __attribute__ ((__noreturn__));
+#if __POSIX_VISIBLE >= 200112
 int pthread_getcpuclockid (pthread_t, clockid_t *);
+#endif
 int pthread_getschedparam (pthread_t, int *, struct sched_param *);
 void *pthread_getspecific (pthread_key_t);
 int pthread_join (pthread_t, void **);
@@ -177,13 +180,16 @@ int pthread_mutexattr_setpshared (pthread_mutexattr_t *, int);
 int pthread_mutexattr_settype (pthread_mutexattr_t *, int);
 
 /* Spinlocks */
+#if __POSIX_VISIBLE >= 200112
 int pthread_spin_destroy (pthread_spinlock_t *);
 int pthread_spin_init (pthread_spinlock_t *, int);
 int pthread_spin_lock (pthread_spinlock_t *);
 int pthread_spin_trylock (pthread_spinlock_t *);
 int pthread_spin_unlock (pthread_spinlock_t *);
+#endif
 
 /* RW Locks */
+#if __XSI_VISIBLE >= 500 || __POSIX_VISIBLE >= 200112
 int pthread_rwlock_destroy (pthread_rwlock_t *rwlock);
 int pthread_rwlock_init (pthread_rwlock_t *rwlock, const pthread_rwlockattr_t *attr);
 int pthread_rwlock_rdlock (pthread_rwlock_t *rwlock);
@@ -196,12 +202,15 @@ int pthread_rwlockattr_getpshared (const pthread_rwlockattr_t *attr,
 				   int *pshared);
 int pthread_rwlockattr_setpshared (pthread_rwlockattr_t *attr, int pshared);
 int pthread_rwlockattr_destroy (pthread_rwlockattr_t *rwlockattr);
+#endif
 
 int pthread_once (pthread_once_t *, void (*)(void));
 
+#if __XSI_VISIBLE >= 500
 /* Concurrency levels - X/Open interface */
 int pthread_getconcurrency (void);
 int pthread_setconcurrency (int);
+#endif
 
 
 pthread_t pthread_self (void);
@@ -214,11 +223,15 @@ void pthread_testcancel (void);
 
 /* Non posix calls */
 
+#if __GNU_VISIBLE
 int pthread_getattr_np (pthread_t, pthread_attr_t *);
 int pthread_sigqueue (pthread_t *, int, const union sigval);
+int pthread_yield (void);
+#endif
+#if __MISC_VISIBLE /* HP-UX, others? */
 int pthread_suspend (pthread_t);
 int pthread_continue (pthread_t);
-int pthread_yield (void);
+#endif
 
 #ifdef __cplusplus
 }
-- 
2.7.4

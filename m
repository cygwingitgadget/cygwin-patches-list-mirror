Return-Path: <cygwin-patches-return-8819-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28508 invoked by alias); 17 Aug 2017 01:41:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22134 invoked by uid 89); 17 Aug 2017 01:41:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Aug 2017 01:41:21 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 50E2276B24	for <cygwin-patches@cygwin.com>; Thu, 17 Aug 2017 01:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 50E2276B24
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=eblake@redhat.com
Received: from red.redhat.com (ovpn-120-34.rdu2.redhat.com [10.10.120.34])	by smtp.corp.redhat.com (Postfix) with ESMTP id EBC2168D77	for <cygwin-patches@cygwin.com>; Thu, 17 Aug 2017 01:41:19 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] headers: avoid bareword attributes
Date: Fri, 18 Aug 2017 14:56:00 -0000
Message-Id: <20170817014119.8792-1-eblake@redhat.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00021.txt.bz2

Always use the __-decorated form of an attribute name in public
headers, as the bareword form is in the user's namespace, and we
don't want compilation to break just because the user defines the
bareword to mean something else.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 winsup/cygwin/include/cygwin/config.h | 2 +-
 winsup/cygwin/include/cygwin/signal.h | 2 +-
 winsup/cygwin/include/pthread.h       | 4 ++--
 winsup/cygwin/include/sys/ucontext.h  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/include/cygwin/config.h b/winsup/cygwin/include/cygwin/config.h
index dad6a350b..aede45f77 100644
--- a/winsup/cygwin/include/cygwin/config.h
+++ b/winsup/cygwin/include/cygwin/config.h
@@ -41,7 +41,7 @@ extern "C" {
 #else
 #include "../tlsoffsets.h"
 #endif
-__attribute__((gnu_inline))
+__attribute__((__gnu_inline__))
 extern inline struct _reent *__getreent (void)
 {
   register char *ret;
diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/cygwin/signal.h
index a8c852ddb..630afc817 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -46,7 +46,7 @@ struct _fpstate
   __uint32_t padding[24];
 };

-struct __attribute__ ((aligned (16))) __mcontext
+struct __attribute__ ((__aligned__ (16))) __mcontext
 {
   __uint64_t p1home;
   __uint64_t p2home;
diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 9e8eb6f2b..6d3bfd0eb 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -223,8 +223,8 @@ void pthread_testcancel (void);

 #if __GNU_VISIBLE
 int pthread_getattr_np (pthread_t, pthread_attr_t *);
-int pthread_getname_np (pthread_t, char *, size_t) __attribute__((nonnull(2)));
-int pthread_setname_np (pthread_t, const char *) __attribute__((nonnull(2)));
+int pthread_getname_np (pthread_t, char *, size_t) __attribute__((__nonnull__(2)));
+int pthread_setname_np (pthread_t, const char *) __attribute__((__nonnull__(2)));
 int pthread_sigqueue (pthread_t *, int, const union sigval);
 int pthread_yield (void);
 #endif
diff --git a/winsup/cygwin/include/sys/ucontext.h b/winsup/cygwin/include/sys/ucontext.h
index 8795476fc..58dc3874a 100644
--- a/winsup/cygwin/include/sys/ucontext.h
+++ b/winsup/cygwin/include/sys/ucontext.h
@@ -13,7 +13,7 @@ details. */

 typedef struct __mcontext mcontext_t;

-typedef __attribute__ ((aligned (16))) struct __ucontext {
+typedef __attribute__ ((__aligned__ (16))) struct __ucontext {
 	mcontext_t	uc_mcontext;
 	struct __ucontext *uc_link;
 	sigset_t	uc_sigmask;
-- 
2.13.5

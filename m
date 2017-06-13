Return-Path: <cygwin-patches-return-8780-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 71778 invoked by alias); 13 Jun 2017 20:01:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71454 invoked by uid 89); 13 Jun 2017 20:01:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 13 Jun 2017 20:01:16 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 77AAB3DE3C	for <cygwin-patches@cygwin.com>; Tue, 13 Jun 2017 20:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 77AAB3DE3C
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=yselkowi@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 77AAB3DE3C
Received: from localhost.localdomain (ovpn-120-23.rdu2.redhat.com [10.10.120.23])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 195566046E	for <cygwin-patches@cygwin.com>; Tue, 13 Jun 2017 20:01:18 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Feature test macros overhaul: Cygwin signal.h
Date: Tue, 13 Jun 2017 20:01:00 -0000
Message-Id: <20170613200108.10620-1-yselkowi@redhat.com>
X-SW-Source: 2017-q2/txt/msg00051.txt.bz2

This should match newlib's <sys/signal.h>.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/cygwin/signal.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/cygwin/signal.h
index f30499505..700d45c13 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -190,6 +190,8 @@ struct _sigcommune
   };
 };
 
+#if __POSIX_VISIBLE >= 199309
+
 #define __SI_PAD_SIZE 32
 #ifdef __INSIDE_CYGWIN__
 # ifndef max
@@ -251,6 +253,8 @@ typedef struct
 } siginfo_t;
 #pragma pack(pop)
 
+#endif /* __POSIX_VISIBLE >= 199309 */
+
 enum
 {
   SI_USER = 0,				/* sent by kill, raise, pthread_kill */
@@ -314,6 +318,8 @@ enum
 
 typedef void (*_sig_func_ptr)(int);
 
+#if __POSIX_VISIBLE
+
 struct sigaction
 {
   __extension__ union
@@ -344,11 +350,17 @@ struct sigaction
    Do not use.  */
 #define _SA_INTERNAL_MASK 0xf000	/* bits in this range are internal */
 
+#endif /* __POSIX_VISIBLE */
+
+#if __BSD_VISIBLE || __XSI_VISIBLE >= 4 || __POSIX_VISIBLE >= 200809
+
 #undef	MINSIGSTKSZ
 #define	MINSIGSTKSZ	 8192
 #undef	SIGSTKSZ
 #define	SIGSTKSZ	32768
 
+#endif /* __BSD_VISIBLE || __XSI_VISIBLE >= 4 || __POSIX_VISIBLE >= 200809 */
+
 #define	SIGHUP	1	/* hangup */
 #define	SIGINT	2	/* interrupt */
 #define	SIGQUIT	3	/* quit */
@@ -397,20 +409,32 @@ struct sigaction
 
 #define SIG_HOLD ((_sig_func_ptr)2)	/* Signal in signal mask */
 
+#if __POSIX_VISIBLE >= 200809
 void psiginfo (const siginfo_t *, const char *);
+#endif
+#if __POSIX_VISIBLE
 int sigwait (const sigset_t *, int *);
+#endif
+#if __POSIX_VISIBLE >= 199309
 int sigwaitinfo (const sigset_t *, siginfo_t *);
+#endif
+#if __XSI_VISIBLE >= 4
 int sighold (int);
 int sigignore (int);
 int sigrelse (int);
 _sig_func_ptr sigset (int, _sig_func_ptr);
+#endif
 
+#if __POSIX_VISIBLE >= 199309
 int sigqueue(pid_t, int, const union sigval);
+#endif
+#if __BSD_VISIBLE || __XSI_VISIBLE >= 4 || __POSIX_VISIBLE >= 200809
 int siginterrupt (int, int);
+#endif
 #ifdef __INSIDE_CYGWIN__
 extern const char *sys_sigabbrev[];
 extern const char *sys_siglist[];
-#else
+#elif __BSD_VISIBLE
 extern const char __declspec(dllimport) *sys_sigabbrev[];
 extern const char __declspec(dllimport) *sys_siglist[];
 #endif
-- 
2.12.3

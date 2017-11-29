Return-Path: <cygwin-patches-return-8946-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64480 invoked by alias); 29 Nov 2017 17:45:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63968 invoked by uid 89); 29 Nov 2017 17:45:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 17:45:40 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 2E58261B8F	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-11.rdu2.redhat.com [10.10.120.11])	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1EFC60BE1	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 17:45:38 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] cygwin: add Object Size Checking to sys/poll.h
Date: Wed, 29 Nov 2017 17:45:00 -0000
Message-Id: <20171129174527.10536-1-yselkowi@redhat.com>
X-SW-Source: 2017-q4/txt/msg00076.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/ssp/poll.h | 26 ++++++++++++++++++++++++++
 winsup/cygwin/include/sys/poll.h |  4 ++++
 2 files changed, 30 insertions(+)
 create mode 100644 winsup/cygwin/include/ssp/poll.h

diff --git a/winsup/cygwin/include/ssp/poll.h b/winsup/cygwin/include/ssp/poll.h
new file mode 100644
index 000000000..831e626d6
--- /dev/null
+++ b/winsup/cygwin/include/ssp/poll.h
@@ -0,0 +1,26 @@
+#ifndef _SSP_POLL_H_
+#define _SSP_POLL_H_
+
+#include <ssp/ssp.h>
+
+#if __SSP_FORTIFY_LEVEL > 0
+__BEGIN_DECLS
+
+__ssp_decl(int, poll, (struct pollfd *__fds, nfds_t __nfds, int __timeout))
+{
+  __ssp_check (__fds, __nfds * sizeof(*__fds), __ssp_bos);
+  return __ssp_real_poll (__fds, __nfds, __timeout);
+}
+
+#if __GNU_VISIBLE
+__ssp_decl(int, ppoll, (struct pollfd *__fds, nfds_t __nfds, const struct timespec *__timeout_ts, const sigset_t *__sigmask))
+{
+  __ssp_check (__fds, __nfds * sizeof(*__fds), __ssp_bos);
+  return __ssp_real_ppoll (__fds, __nfds, __timeout_ts, __sigmask);
+}
+#endif
+
+__END_DECLS
+
+#endif /* __SSP_FORTIFY_LEVEL > 0 */
+#endif /* _SSP_POLL_H_ */
diff --git a/winsup/cygwin/include/sys/poll.h b/winsup/cygwin/include/sys/poll.h
index 0da4c3f03..65822edb3 100644
--- a/winsup/cygwin/include/sys/poll.h
+++ b/winsup/cygwin/include/sys/poll.h
@@ -47,4 +47,8 @@ extern int ppoll __P ((struct pollfd *fds, nfds_t nfds,
 
 __END_DECLS
 
+#if __SSP_FORTIFY_LEVEL > 0
+#include <ssp/poll.h>
+#endif
+
 #endif /* _SYS_POLL_H */
-- 
2.15.0

Return-Path: <cygwin-patches-return-8947-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65304 invoked by alias); 29 Nov 2017 17:45:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65072 invoked by uid 89); 29 Nov 2017 17:45:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KB_WAM_FROM_NAME_SINGLEWORD,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 17:45:42 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 8DCA6C070E20	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-11.rdu2.redhat.com [10.10.120.11])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B86B609A5	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 17:45:40 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] cygwin: add Object Size Checking to sys/socket.h
Date: Wed, 29 Nov 2017 17:45:00 -0000
Message-Id: <20171129174527.10536-2-yselkowi@redhat.com>
In-Reply-To: <20171129174527.10536-1-yselkowi@redhat.com>
References: <20171129174527.10536-1-yselkowi@redhat.com>
X-SW-Source: 2017-q4/txt/msg00077.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/ssp/socket.h | 20 ++++++++++++++++++++
 winsup/cygwin/include/sys/socket.h |  4 ++++
 2 files changed, 24 insertions(+)
 create mode 100644 winsup/cygwin/include/ssp/socket.h

diff --git a/winsup/cygwin/include/ssp/socket.h b/winsup/cygwin/include/ssp/socket.h
new file mode 100644
index 000000000..3abbddbdf
--- /dev/null
+++ b/winsup/cygwin/include/ssp/socket.h
@@ -0,0 +1,20 @@
+#ifndef _SSP_SOCKET_H_
+#define _SSP_SOCKET_H_
+
+#include <ssp/ssp.h>
+
+#if __SSP_FORTIFY_LEVEL > 0
+__BEGIN_DECLS
+
+__ssp_redirect0(ssize_t, recv, \
+    (int __fd, void *__buf, size_t __len, int __flags), \
+    (__fd, __buf, __len, __flags));
+
+__ssp_redirect0(ssize_t, recvfrom, \
+    (int __fd, void *__buf, size_t __len, int __flags, struct sockaddr *__from, socklen_t *__fromlen), \
+    (__fd, __buf, __len, __flags, __from, __fromlen));
+
+__END_DECLS
+
+#endif /* __SSP_FORTIFY_LEVEL > 0 */
+#endif /* _SSP_SOCKET_H_ */
diff --git a/winsup/cygwin/include/sys/socket.h b/winsup/cygwin/include/sys/socket.h
index 8bab35b68..9e897a9ff 100644
--- a/winsup/cygwin/include/sys/socket.h
+++ b/winsup/cygwin/include/sys/socket.h
@@ -50,4 +50,8 @@ extern "C"
 };
 #endif
 
+#if __SSP_FORTIFY_LEVEL > 0
+#include <ssp/socket.h>
+#endif
+
 #endif /* _SYS_SOCKET_H */
-- 
2.15.0

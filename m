Return-Path: <cygwin-patches-return-8998-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21851 invoked by alias); 17 Jan 2018 09:05:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21812 invoked by uid 89); 17 Jan 2018 09:05:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jan 2018 09:05:39 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 2F4172BA8	for <cygwin-patches@cygwin.com>; Wed, 17 Jan 2018 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9468F6EE68	for <cygwin-patches@cygwin.com>; Wed, 17 Jan 2018 09:05:36 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: add asm/bitsperlong.h, dummy asm/posix_types.h headers
Date: Wed, 17 Jan 2018 09:05:00 -0000
Message-Id: <20180117090521.11992-1-yselkowi@redhat.com>
X-SW-Source: 2018-q1/txt/msg00006.txt.bz2

These changes are necessary for cross-compiling the Linux kernel.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/asm/bitsperlong.h | 18 ++++++++++++++++++
 winsup/cygwin/include/asm/posix_types.h | 14 ++++++++++++++
 winsup/cygwin/include/asm/types.h       |  2 ++
 3 files changed, 34 insertions(+)
 create mode 100644 winsup/cygwin/include/asm/bitsperlong.h
 create mode 100644 winsup/cygwin/include/asm/posix_types.h

diff --git a/winsup/cygwin/include/asm/bitsperlong.h b/winsup/cygwin/include/asm/bitsperlong.h
new file mode 100644
index 000000000..48037b645
--- /dev/null
+++ b/winsup/cygwin/include/asm/bitsperlong.h
@@ -0,0 +1,18 @@
+/* asm/bitsperlong.h
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef __ASM_BITSPERLONG_H
+#define __ASM_BITSPERLONG_H
+
+#ifdef __x86_64__
+#define __BITS_PER_LONG 64
+#else
+#define __BITS_PER_LONG 32
+#endif
+
+#endif /* __ASM_BITSPERLONG_H */
diff --git a/winsup/cygwin/include/asm/posix_types.h b/winsup/cygwin/include/asm/posix_types.h
new file mode 100644
index 000000000..4e9aac057
--- /dev/null
+++ b/winsup/cygwin/include/asm/posix_types.h
@@ -0,0 +1,14 @@
+/* asm/posix_types.h
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _ASM_POSIX_TYPES_H
+#define _ASM_POSIX_TYPES_H
+
+/* This is just a placeholder to simplify cross-compiling the Linux kernel */
+
+#endif /* _ASM_POSIX_TYPES_H */
diff --git a/winsup/cygwin/include/asm/types.h b/winsup/cygwin/include/asm/types.h
index c2342efc1..e1e947054 100644
--- a/winsup/cygwin/include/asm/types.h
+++ b/winsup/cygwin/include/asm/types.h
@@ -9,6 +9,8 @@ details. */
 #ifndef _ASM_TYPES_H
 #define _ASM_TYPES_H
 
+#include <asm/bitsperlong.h>
+
 typedef __signed__ char __s8;
 typedef unsigned char __u8;
 
-- 
2.15.1

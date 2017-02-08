Return-Path: <cygwin-patches-return-8692-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2507 invoked by alias); 8 Feb 2017 23:05:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2493 invoked by uid 89); 8 Feb 2017 23:05:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=sk:yselkow, 910, endian.h, endianh
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Feb 2017 23:05:21 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id C54337FB85	for <cygwin-patches@cygwin.com>; Wed,  8 Feb 2017 23:05:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-129.rdu2.redhat.com [10.10.120.129] (may be forged))	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v18N5KEA021550	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Wed, 8 Feb 2017 18:05:21 -0500
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: create separate bits/byteswap.h
Date: Wed, 08 Feb 2017 23:05:00 -0000
Message-Id: <20170208230508.12016-1-yselkowi@redhat.com>
X-SW-Source: 2017-q1/txt/msg00033.txt.bz2

Match glibc behaviour to expose the public bswap_* macros only with an
explicity #include <byteswap.h>; #include'ing <endian.h> should not expose
them.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/bits/byteswap.h | 37 +++++++++++++++++++++++++++++++++++
 winsup/cygwin/include/byteswap.h      | 25 +----------------------
 winsup/cygwin/include/endian.h        | 26 ++++++++++++------------
 3 files changed, 51 insertions(+), 37 deletions(-)
 create mode 100644 winsup/cygwin/include/bits/byteswap.h

diff --git a/winsup/cygwin/include/bits/byteswap.h b/winsup/cygwin/include/bits/byteswap.h
new file mode 100644
index 0000000..20ed5bb
--- /dev/null
+++ b/winsup/cygwin/include/bits/byteswap.h
@@ -0,0 +1,37 @@
+/* bits/byteswap.h
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _BITS_BYTESWAP_H
+#define _BITS_BYTESWAP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+static __inline unsigned short
+__bswap_16 (unsigned short __x)
+{
+  return (__x >> 8) | (__x << 8);
+}
+
+static __inline unsigned int
+__bswap_32 (unsigned int __x)
+{
+  return (__bswap_16 (__x & 0xffff) << 16) | (__bswap_16 (__x >> 16));
+}
+
+static __inline unsigned long long
+__bswap_64 (unsigned long long __x)
+{
+  return (((unsigned long long) __bswap_32 (__x & 0xffffffffull)) << 32) | (__bswap_32 (__x >> 32));
+}
+
+#ifdef __cplusplus
+}
+#endif
+#endif /* _BITS_BYTESWAP_H */
diff --git a/winsup/cygwin/include/byteswap.h b/winsup/cygwin/include/byteswap.h
index 5e3f221..05bb5ca 100644
--- a/winsup/cygwin/include/byteswap.h
+++ b/winsup/cygwin/include/byteswap.h
@@ -9,33 +9,10 @@ details. */
 #ifndef _BYTESWAP_H
 #define _BYTESWAP_H
 
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-static __inline unsigned short
-__bswap_16 (unsigned short __x)
-{
-  return (__x >> 8) | (__x << 8);
-}
-
-static __inline unsigned int
-__bswap_32 (unsigned int __x)
-{
-  return (__bswap_16 (__x & 0xffff) << 16) | (__bswap_16 (__x >> 16));
-}
-
-static __inline unsigned long long
-__bswap_64 (unsigned long long __x)
-{
-  return (((unsigned long long) __bswap_32 (__x & 0xffffffffull)) << 32) | (__bswap_32 (__x >> 32));
-}
+#include <bits/byteswap.h>
 
 #define bswap_16(x) __bswap_16(x)
 #define bswap_32(x) __bswap_32(x)
 #define bswap_64(x) __bswap_64(x)
 
-#ifdef __cplusplus
-}
-#endif
 #endif /* _BYTESWAP_H */
diff --git a/winsup/cygwin/include/endian.h b/winsup/cygwin/include/endian.h
index a17ff99..5a43ad0 100644
--- a/winsup/cygwin/include/endian.h
+++ b/winsup/cygwin/include/endian.h
@@ -35,17 +35,17 @@ details. */
 
 #if __BSD_VISIBLE
 
-#include <byteswap.h>
+#include <bits/byteswap.h>
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
-#define htobe16(x) bswap_16(x)
-#define htobe32(x) bswap_32(x)
-#define htobe64(x) bswap_64(x)
+#define htobe16(x) __bswap_16(x)
+#define htobe32(x) __bswap_32(x)
+#define htobe64(x) __bswap_64(x)
 
-#define be16toh(x) bswap_16(x)
-#define be32toh(x) bswap_32(x)
-#define be64toh(x) bswap_64(x)
+#define be16toh(x) __bswap_16(x)
+#define be32toh(x) __bswap_32(x)
+#define be64toh(x) __bswap_64(x)
 
 #define htole16(x) (x)
 #define htole32(x) (x)
@@ -67,13 +67,13 @@ details. */
 #define be32toh(x) (x)
 #define be64toh(x) (x)
 
-#define htole16(x) bswap_16(x)
-#define htole32(x) bswap_32(x)
-#define htole64(x) bswap_64(x)
+#define htole16(x) __bswap_16(x)
+#define htole32(x) __bswap_32(x)
+#define htole64(x) __bswap_64(x)
 
-#define le16toh(x) bswap_16(x)
-#define le32toh(x) bswap_32(x)
-#define le64toh(x) bswap_64(x)
+#define le16toh(x) __bswap_16(x)
+#define le32toh(x) __bswap_32(x)
+#define le64toh(x) __bswap_64(x)
 
 #endif /*__BYTE_ORDER == __BIG_ENDIAN*/
 
-- 
2.8.3

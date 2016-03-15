Return-Path: <cygwin-patches-return-8398-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115642 invoked by alias); 15 Mar 2016 03:14:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115593 invoked by uid 89); 15 Mar 2016 03:14:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1380, 1623, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 15 Mar 2016 03:14:35 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (Postfix) with ESMTPS id 2F02B1836	for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 03:14:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-22.rdu2.redhat.com [10.10.116.22])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2F3EWa1015749	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2016 23:14:33 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: define byteswap.h inlines as macros
Date: Tue, 15 Mar 2016 03:14:00 -0000
Message-Id: <1458011636-8548-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q1/txt/msg00104.txt.bz2

The bswap_* "functions" are macros in glibc, so they may be tested for
by the preprocessor (e.g. #ifdef bswap_16).

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/byteswap.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/include/byteswap.h b/winsup/cygwin/include/byteswap.h
index cd5a726..9f73c5a 100644
--- a/winsup/cygwin/include/byteswap.h
+++ b/winsup/cygwin/include/byteswap.h
@@ -16,23 +16,27 @@ extern "C" {
 #endif
 
 static __inline unsigned short
-bswap_16 (unsigned short __x)
+__bswap_16 (unsigned short __x)
 {
   return (__x >> 8) | (__x << 8);
 }
 
 static __inline unsigned int
-bswap_32 (unsigned int __x)
+__bswap_32 (unsigned int __x)
 {
-  return (bswap_16 (__x & 0xffff) << 16) | (bswap_16 (__x >> 16));
+  return (__bswap_16 (__x & 0xffff) << 16) | (__bswap_16 (__x >> 16));
 }
 
 static __inline unsigned long long
-bswap_64 (unsigned long long __x)
+__bswap_64 (unsigned long long __x)
 {
-  return (((unsigned long long) bswap_32 (__x & 0xffffffffull)) << 32) | (bswap_32 (__x >> 32));
+  return (((unsigned long long) __bswap_32 (__x & 0xffffffffull)) << 32) | (__bswap_32 (__x >> 32));
 }
 
+#define bswap_16(x) __bswap_16(x)
+#define bswap_32(x) __bswap_32(x)
+#define bswap_64(x) __bswap_64(x)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.7.0

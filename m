Return-Path: <cygwin-patches-return-8803-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87681 invoked by alias); 7 Jul 2017 22:38:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87648 invoked by uid 89); 7 Jul 2017 22:38:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=sooner, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jul 2017 22:38:21 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id BF493A4F99	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2017 22:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com BF493A4F99
Authentication-Results: ext-mx02.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx02.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=yselkowi@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com BF493A4F99
Received: from localhost.localdomain (ovpn-120-7.rdu2.redhat.com [10.10.120.7])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D5B55B83E	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2017 22:38:19 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fix guard on struct siginfo_t
Date: Fri, 07 Jul 2017 22:38:00 -0000
Message-Id: <20170707223811.229596-1-yselkowi@redhat.com>
X-SW-Source: 2017-q3/txt/msg00005.txt.bz2

Add line breaks to make it clearer that the struct packing applies to more
than one struct.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
We probably should consider a 2.8.2 sooner rather than later.

 winsup/cygwin/include/cygwin/signal.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/cygwin/signal.h
index e73874c62..af0833688 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -175,7 +175,10 @@ typedef struct sigevent
   pthread_attr_t *sigev_notify_attributes; /* notification attributes */
 } sigevent_t;
 
+#if __POSIX_VISIBLE >= 199309
+
 #pragma pack(push,4)
+
 struct _sigcommune
 {
   __uint32_t _si_code;
@@ -190,8 +193,6 @@ struct _sigcommune
   };
 };
 
-#if __POSIX_VISIBLE >= 199309
-
 #define __SI_PAD_SIZE 32
 #ifdef __INSIDE_CYGWIN__
 # ifndef max
@@ -251,6 +252,7 @@ typedef struct
 #endif /*__INSIDE_CYGWIN__*/
   };
 } siginfo_t;
+
 #pragma pack(pop)
 
 #endif /* __POSIX_VISIBLE >= 199309 */
-- 
2.12.3

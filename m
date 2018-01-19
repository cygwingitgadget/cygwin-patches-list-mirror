Return-Path: <cygwin-patches-return-9004-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47711 invoked by alias); 19 Jan 2018 06:01:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47685 invoked by uid 89); 19 Jan 2018 06:01:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=Hx-languages-length:603, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 06:01:17 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 31B094B8C;	Fri, 19 Jan 2018 06:01:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id B73BF60BE7;	Fri, 19 Jan 2018 06:01:15 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Cc: newlib@sourceware.org
Subject: [PATCH v2 1/3] Guard langinfo.h nl_item from multiple typedefs
Date: Fri, 19 Jan 2018 06:01:00 -0000
Message-Id: <20180119060059.6552-1-yselkowi@redhat.com>
In-Reply-To: <20180119055837.13016-1-yselkowi@redhat.com>
References: <20180119055837.13016-1-yselkowi@redhat.com>
X-SW-Source: 2018-q1/txt/msg00012.txt.bz2

This is a prerequisite of adding nl_types.h support to Cygwin.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 newlib/libc/include/langinfo.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/newlib/libc/include/langinfo.h b/newlib/libc/include/langinfo.h
index 59381d6b6..458b92565 100644
--- a/newlib/libc/include/langinfo.h
+++ b/newlib/libc/include/langinfo.h
@@ -36,7 +36,10 @@
 #include <xlocale.h>
 #endif
 
+#ifndef _NL_ITEM_DECLARED
 typedef int nl_item;
+#define _NL_ITEM_DECLARED
+#endif
 
 enum __nl_item
 {
-- 
2.15.1

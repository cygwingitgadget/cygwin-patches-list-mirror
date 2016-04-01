Return-Path: <cygwin-patches-return-8544-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77807 invoked by alias); 1 Apr 2016 23:40:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77714 invoked by uid 89); 1 Apr 2016 23:40:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=man3, Hx-languages-length:819, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 01 Apr 2016 23:39:56 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 746B41E26	for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2016 23:39:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u31NdqUw030275	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 1 Apr 2016 19:39:54 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/4] cygwin/math: make isinf functions signed
Date: Fri, 01 Apr 2016 23:40:00 -0000
Message-Id: <1459553988-14384-2-git-send-email-yselkowi@redhat.com>
In-Reply-To: <1459553988-14384-1-git-send-email-yselkowi@redhat.com>
References: <1459551179-9404-1-git-send-email-yselkowi@redhat.com> <1459553988-14384-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q2/txt/msg00019.txt.bz2

glibc returns -1 for negative infinity:

http://man7.org/linux/man-pages/man3/isinfl.3.html
https://sourceware.org/bugzilla/show_bug.cgi?id=15367

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/math/isinf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/math/isinf.c b/winsup/cygwin/math/isinf.c
index e7d3e26..fd9e299 100644
--- a/winsup/cygwin/math/isinf.c
+++ b/winsup/cygwin/math/isinf.c
@@ -1,18 +1,18 @@
 int
 isinf (double x)
 {
-  return __builtin_isinf (x);
+  return __builtin_isinf_sign (x);
 }
 
 int
 isinff (float x)
 {
-  return __builtin_isinf (x);
+  return __builtin_isinf_sign (x);
 }
 
 int
 isinfl (long double x)
 {
-  return __builtin_isinf (x);
+  return __builtin_isinf_sign (x);
 }
 
-- 
2.7.4

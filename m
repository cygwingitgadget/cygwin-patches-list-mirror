Return-Path: <cygwin-patches-return-9047-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95821 invoked by alias); 17 Apr 2018 15:55:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95807 invoked by uid 89); 17 Apr 2018 15:55:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-22.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT autolearn=ham version=3.3.2 spammy=junk, sk:yselkow, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx3-rdu2.redhat.com (HELO mx1.redhat.com) (66.187.233.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 17 Apr 2018 15:55:11 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 9C17411D26F	for <cygwin-patches@cygwin.com>; Tue, 17 Apr 2018 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-26.rdu2.redhat.com [10.10.122.26])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 503701102E28	for <cygwin-patches@cygwin.com>; Tue, 17 Apr 2018 15:55:09 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fix build with GCC 7
Date: Tue, 17 Apr 2018 15:55:00 -0000
Message-Id: <20180417155458.18332-1-yselkowi@redhat.com>
X-SW-Source: 2018-q2/txt/msg00004.txt.bz2

GCC 7 is able to see straight through this trick, so use a more formal
method to avoid the warning.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/random.cc | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/random.cc b/winsup/cygwin/random.cc
index 802c33b8a..163fc040c 100644
--- a/winsup/cygwin/random.cc
+++ b/winsup/cygwin/random.cc
@@ -279,14 +279,6 @@ srandom(unsigned x)
 		(void)random();
 }
 
-/* Avoid a compiler warning when we really want to get at the junk in
-   an uninitialized variable. */
-static unsigned long
-dummy (unsigned volatile long *x)
-{
-  return *x;
-}
-
 /*
  * srandomdev:
  *
@@ -313,7 +305,11 @@ srandomdev()
 		unsigned long junk;
 
 		gettimeofday(&tv, NULL);
-		srandom((getpid() << 16) ^ tv.tv_sec ^ tv.tv_usec ^ dummy(&junk));
+		/* Avoid a compiler warning when we really want to get at the
+		   junk in an uninitialized variable. */
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
+		srandom((getpid() << 16) ^ tv.tv_sec ^ tv.tv_usec ^ junk);
+#pragma GCC diagnostic pop
 		return;
 	}
 
-- 
2.17.0

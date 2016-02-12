Return-Path: <cygwin-patches-return-8299-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6096 invoked by alias); 12 Feb 2016 02:39:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6063 invoked by uid 89); 12 Feb 2016 02:39:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 12 Feb 2016 02:38:59 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])	by mx1.redhat.com (Postfix) with ESMTPS id C41BAC0C2373	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 02:38:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1C2cvfl006111	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Thu, 11 Feb 2016 21:38:58 -0500
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: update child info magic
Date: Fri, 12 Feb 2016 02:39:00 -0000
Message-Id: <1455244717-12688-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q1/txt/msg00005.txt.bz2

	winsup/cygwin/
	* child_info.h (CURR_CHILD_INFO_MAGIC): Update.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/child_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/child_info.h b/winsup/cygwin/child_info.h
index ddd5b8b..c11040c 100644
--- a/winsup/cygwin/child_info.h
+++ b/winsup/cygwin/child_info.h
@@ -39,7 +39,7 @@ enum child_status
 #define EXEC_MAGIC_SIZE sizeof(child_info)
 
 /* Change this value if you get a message indicating that it is out-of-sync. */
-#define CURR_CHILD_INFO_MAGIC 0x30ea98f6U
+#define CURR_CHILD_INFO_MAGIC 0xf67f938cU
 
 #define NPROCS	256
 
-- 
2.7.0

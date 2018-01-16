Return-Path: <cygwin-patches-return-8993-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124866 invoked by alias); 16 Jan 2018 03:25:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124855 invoked by uid 89); 16 Jan 2018 03:25:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jan 2018 03:25:01 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 8128581DED	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 03:25:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 13205608E0	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 03:24:59 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: make sys/socket.h completely visible from netinet/in.h
Date: Tue, 16 Jan 2018 03:25:00 -0000
Message-Id: <20180116032447.14572-1-yselkowi@redhat.com>
X-SW-Source: 2018-q1/txt/msg00001.txt.bz2

While POSIX mandates that certain socket types shall be defined by the
inclusing of <netinet/in.h>, it also says that this header may also make
visible all <sys/socket.h> symbols.  Glibc does this, and without out it,
some packages end up requiring an additional #include <sys/socket.h>.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/cygwin/in.h  | 2 +-
 winsup/cygwin/include/sys/socket.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/include/cygwin/in.h b/winsup/cygwin/include/cygwin/in.h
index 9d7331d30..42b776653 100644
--- a/winsup/cygwin/include/cygwin/in.h
+++ b/winsup/cygwin/include/cygwin/in.h
@@ -18,7 +18,7 @@
 #ifndef _CYGWIN_IN_H
 #define _CYGWIN_IN_H
 
-#include <cygwin/socket.h>
+#include <sys/socket.h>
 
 #ifndef _IN_ADDR_T_DECLARED
 typedef	__uint32_t	in_addr_t;
diff --git a/winsup/cygwin/include/sys/socket.h b/winsup/cygwin/include/sys/socket.h
index 9e897a9ff..e6b92eef8 100644
--- a/winsup/cygwin/include/sys/socket.h
+++ b/winsup/cygwin/include/sys/socket.h
@@ -11,7 +11,6 @@ details. */
 
 #include <features.h>
 #include <cygwin/socket.h>
-#include <sys/time.h>
 
 #ifdef __cplusplus
 extern "C"
-- 
2.15.1

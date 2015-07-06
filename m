Return-Path: <cygwin-patches-return-8224-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91275 invoked by alias); 6 Jul 2015 19:41:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91261 invoked by uid 89); 6 Jul 2015 19:41:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=no version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 06 Jul 2015 19:41:37 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])	by mx1.redhat.com (Postfix) with ESMTPS id 1C8DABE26A	for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2015 19:41:36 +0000 (UTC)
Received: from localhost.localdomain ([10.10.116.32])	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t66JfYwk011728	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Mon, 6 Jul 2015 15:41:35 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/cygwin: fix compile of path.cc after basename changes
Date: Mon, 06 Jul 2015 19:41:00 -0000
Message-Id: <1436211686-9256-1-git-send-email-yselkowi@redhat.com>
In-Reply-To: <1436206232-9776-1-git-send-email-yselkowi@redhat.com>
References: <1436206232-9776-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2015-q3/txt/msg00006.txt.bz2

---
 winsup/cygwin/path.cc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 446d746..5eb076f 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -48,7 +48,7 @@
      c: means c:\.
   */
 
-#define _BASENAME_DEFINED
+#define basename basename
 #include "winsup.h"
 #include "miscfuncs.h"
 #include <ctype.h>
@@ -70,6 +70,7 @@
 #include <ntdll.h>
 #include <wchar.h>
 #include <wctype.h>
+#undef basename
 
 suffix_info stat_suffixes[] =
 {
@@ -4739,8 +4740,6 @@ out:
   return buf;
 }
 
-#undef basename
-
 /* No need to be reentrant or thread-safe according to SUSv3.
    / and \\ are treated equally.  Leading drive specifiers are
    kept intact as far as it makes sense.  Everything else is
-- 
2.4.4

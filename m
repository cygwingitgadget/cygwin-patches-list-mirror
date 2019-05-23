Return-Path: <cygwin-patches-return-9408-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73758 invoked by alias); 23 May 2019 17:05:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73749 invoked by uid 89); 23 May 2019 17:05:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1148, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 May 2019 17:05:44 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 38001916C0	for <cygwin-patches@cygwin.com>; Thu, 23 May 2019 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-139.rdu2.redhat.com [10.10.125.139])	by smtp.corp.redhat.com (Postfix) with ESMTPS id CEF5760BF3	for <cygwin-patches@cygwin.com>; Thu, 23 May 2019 17:05:42 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygcheck: expand common_apps list
Date: Thu, 23 May 2019 17:05:00 -0000
Message-Id: <20190523170532.64113-1-yselkowi@redhat.com>
X-SW-Source: 2019-q2/txt/msg00115.txt.bz2

An increasing number of tools are being included in Windows which have the
same names as those included in Cygwin packages.  Indicating which one is
first in PATH can be helpful in diagnosing behavioural discrepencies
between them.

Also, fix the alphabetization of ssh.
---
 winsup/utils/cygcheck.cc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/winsup/utils/cygcheck.cc b/winsup/utils/cygcheck.cc
index d5972c0cf..0432f4a4d 100644
--- a/winsup/utils/cygcheck.cc
+++ b/winsup/utils/cygcheck.cc
@@ -99,28 +99,39 @@ static common_apps[] = {
   {"awk", 0},
   {"bash", 0},
   {"cat", 0},
+  {"clinfo", 0},
+  {"convert", 0},
   {"cp", 0},
   {"cpp", 1},
   {"crontab", 0},
+  {"curl", 0},
+  {"expand", 0},
   {"find", 0},
   {"gcc", 0},
   {"gdb", 0},
   {"grep", 0},
+  {"hostname", 0},
   {"kill", 0},
+  {"klist", 0},
   {"ld", 0},
   {"ls", 0},
   {"make", 0},
   {"mv", 0},
+  {"nslookup", 0},
   {"patch", 0},
   {"perl", 0},
+  {"replace", 0},
   {"rm", 0},
   {"sed", 0},
-  {"ssh", 0},
   {"sh", 0},
+  {"sort", 0},
+  {"ssh", 0},
   {"tar", 0},
   {"test", 0},
+  {"timeout", 0},
   {"vi", 0},
   {"vim", 0},
+  {"whoami", 0},
   {0, 0}
 };
 
-- 
2.17.0

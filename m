Return-Path: <cygwin-patches-return-10131-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109019 invoked by alias); 26 Feb 2020 20:08:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109009 invoked by uid 89); 26 Feb 2020 20:08:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.9 required=5.0 tests=AWL,BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KHOP_HELO_FCRDNS,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=gcc-9.2.0, gcc920, HContent-Transfer-Encoding:8bit
X-HELO: re-prd-fep-048.btinternet.com
Received: from mailomta2-re.btinternet.com (HELO re-prd-fep-048.btinternet.com) (213.120.69.95) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 20:08:49 +0000
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])          by re-prd-fep-048.btinternet.com with ESMTP          id <20200226200847.HJJU27551.re-prd-fep-048.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;          Wed, 26 Feb 2020 20:08:47 +0000
Authentication-Results: btinternet.com;    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-OWM-Source-IP: 31.51.207.12 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from localhost.localdomain (31.51.207.12) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as jonturney@btinternet.com)        id 5E3A15B6035F33DA; Wed, 26 Feb 2020 20:08:47 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Fix size of a buffer in the ps utility
Date: Wed, 26 Feb 2020 20:08:00 -0000
Message-Id: <20200226200835.34501-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2020-q1/txt/msg00237.txt

Fix the size of a temporary buffer used in the ps utility, reported as a
new warning by gcc-9.2.0

../../../../src/winsup/utils/ps.cc: In function 'const char* ttynam(int)':
../../../../src/winsup/utils/ps.cc:101:23: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
../../../../src/winsup/utils/ps.cc:101:11: note: 'sprintf' output between 9 and 10 bytes into a destination of size 9
---
 winsup/utils/ps.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/utils/ps.cc b/winsup/utils/ps.cc
index 2307f7955..63b92319e 100644
--- a/winsup/utils/ps.cc
+++ b/winsup/utils/ps.cc
@@ -90,7 +90,7 @@ to_time_t (FILETIME *ptr)
 static const char *
 ttynam (int ntty)
 {
-  static char buf[9];
+  static char buf[10];
   char buf0[9];
   if (ntty < 0)
     strcpy (buf0, "?");
-- 
2.21.0

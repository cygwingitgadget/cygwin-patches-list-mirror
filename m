Return-Path: <cygwin-patches-return-9089-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92667 invoked by alias); 6 Jun 2018 15:46:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92315 invoked by uid 89); 6 Jun 2018 15:46:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:759, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock03.mail.cornell.edu
Received: from limerock03.mail.cornell.edu (HELO limerock03.mail.cornell.edu) (128.84.13.243) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Jun 2018 15:46:14 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w56FkBWn000709;	Wed, 6 Jun 2018 11:46:11 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w56Fjxgh006086	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Wed, 6 Jun 2018 11:46:11 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 6/6] Bump Cygwin DLL version to 2.11.0
Date: Wed, 06 Jun 2018 15:46:00 -0000
Message-Id: <20180606154559.6828-7-kbrown@cornell.edu>
In-Reply-To: <20180606154559.6828-1-kbrown@cornell.edu>
References: <20180606154559.6828-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00046.txt.bz2

---
 winsup/cygwin/include/cygwin/version.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 2991ab858..958acca3a 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -10,8 +10,8 @@ details. */
    the Cygwin shared library".  This version is used to track important
    changes to the DLL and is mainly informative in nature. */
 
-#define CYGWIN_VERSION_DLL_MAJOR 2010
-#define CYGWIN_VERSION_DLL_MINOR 1
+#define CYGWIN_VERSION_DLL_MAJOR 2011
+#define CYGWIN_VERSION_DLL_MINOR 0
 
 /* Major numbers before CYGWIN_VERSION_DLL_EPOCH are incompatible. */
 
-- 
2.17.0

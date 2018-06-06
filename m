Return-Path: <cygwin-patches-return-9085-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92327 invoked by alias); 6 Jun 2018 15:46:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92250 invoked by uid 89); 6 Jun 2018 15:46:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock03.mail.cornell.edu
Received: from limerock03.mail.cornell.edu (HELO limerock03.mail.cornell.edu) (128.84.13.243) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Jun 2018 15:46:12 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w56FkAjY000701;	Wed, 6 Jun 2018 11:46:10 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w56Fjxgf006086	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Wed, 6 Jun 2018 11:46:09 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 4/6] Cygwin: Remove workaround in environ.cc
Date: Wed, 06 Jun 2018 15:46:00 -0000
Message-Id: <20180606154559.6828-5-kbrown@cornell.edu>
In-Reply-To: <20180606154559.6828-1-kbrown@cornell.edu>
References: <20180606154559.6828-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00042.txt.bz2

Commit ebd645e on 2001-10-03 made environ.cc:_addenv() add unneeded
space at the end of the environment block to "work around problems
with some buggy applications."  This clutters the code and is
presumably no longer needed.
---
 winsup/cygwin/environ.cc | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index bbe539816..67ead1dde 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -592,13 +592,11 @@ _addenv (const char *name, const char *value, int overwrite)
     {				/* Create new slot. */
       int sz = envsize (cur_environ ());
 
-      /* If sz == 0, we need two new slots, one for the terminating NULL.
-	 But we add two slots in all cases, as has been done since
-	 2001-10-03 (commit ebd645e) to "work around problems with
-	 some buggy applications." */
-      int allocsz = (sz + 2) * sizeof (char *);
+      /* If sz == 0, we need two new slots, one for the terminating NULL. */
+      int newsz = sz == 0 ? 2 : sz + 1;
+      int allocsz = newsz * sizeof (char *);
 
-      offset = sz == 0 ? 0 : sz - 1;
+      offset = newsz - 2;
 
       /* Allocate space for additional element. */
       if (cur_environ () == lastenviron)
-- 
2.17.0

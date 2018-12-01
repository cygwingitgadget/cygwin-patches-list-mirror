Return-Path: <cygwin-patches-return-9187-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63008 invoked by alias); 1 Dec 2018 06:14:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62993 invoked by uid 89); 1 Dec 2018 06:14:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-25.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 01 Dec 2018 06:14:16 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id wB16EETg049179;	Fri, 30 Nov 2018 22:14:14 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdgI0vme; Fri Nov 30 22:14:09 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] fix version typo
Date: Sat, 01 Dec 2018 06:14:00 -0000
Message-Id: <20181201061400.4244-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q4/txt/msg00003.txt.bz2

---
 winsup/doc/new-features.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index e3786e545..7cc449764 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -4,7 +4,7 @@
 
 <sect1 id="ov-new"><title>What's new and what changed in Cygwin</title>
 
-<sect2 id="ov-new2.11"><title>What's new and what changed in 2.12</title>
+<sect2 id="ov-new2.12"><title>What's new and what changed in 2.12</title>
 
 <itemizedlist mark="bullet">
 
-- 
2.17.0

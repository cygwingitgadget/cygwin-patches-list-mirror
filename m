Return-Path: <cygwin-patches-return-9456-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102736 invoked by alias); 25 Jun 2019 05:25:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102720 invoked by uid 89); 25 Jun 2019 05:25:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 05:25:43 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5P5Pgc7005989;	Mon, 24 Jun 2019 22:25:42 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdrhPbiL; Mon Jun 24 22:25:35 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Fix return value of sched_getaffinity
Date: Tue, 25 Jun 2019 05:25:00 -0000
Message-Id: <20190625052523.1927-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00163.txt.bz2

Return what the documentation says, instead of a misreading of it.
---
 winsup/cygwin/sched.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
index e7b44d319..8f24bf80d 100644
--- a/winsup/cygwin/sched.cc
+++ b/winsup/cygwin/sched.cc
@@ -608,7 +608,7 @@ done:
   else
     {
       /* Emulate documented Linux kernel behavior on successful return */
-      status = wincap.cpu_count ();
+      status = sizeof (cpu_set_t);
     }
   return status;
 }
-- 
2.21.0

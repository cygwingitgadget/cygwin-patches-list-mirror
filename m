Return-Path: <cygwin-patches-return-9472-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 41618 invoked by alias); 27 Jun 2019 05:32:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 41609 invoked by uid 89); 27 Jun 2019 05:32:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 27 Jun 2019 05:32:12 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5R5WApE061947;	Wed, 26 Jun 2019 22:32:10 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdvDxT7Z; Wed Jun 26 22:32:06 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Use correct string conversion
Date: Thu, 27 Jun 2019 05:32:00 -0000
Message-Id: <20190627053156.57473-1-mark@maxrnd.com>
In-Reply-To: <20190626092744.GT5738@calimero.vinschen.de>
References: <20190626092744.GT5738@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00179.txt.bz2

Correct the string conversion calls so both argv elements get converted
at full precision.
---
 winsup/utils/cygwin-console-helper.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/utils/cygwin-console-helper.cc b/winsup/utils/cygwin-console-helper.cc
index 8f62ed7e6..0e04f4d18 100644
--- a/winsup/utils/cygwin-console-helper.cc
+++ b/winsup/utils/cygwin-console-helper.cc
@@ -5,9 +5,9 @@ main (int argc, char **argv)
   char *end;
   if (argc != 3)
     exit (1);
-  HANDLE h = (HANDLE) strtoul (argv[1], &end, 0);
+  HANDLE h = (HANDLE) strtoull (argv[1], &end, 0);
   SetEvent (h);
-  h = (HANDLE) strtoul (argv[2], &end, 0);
+  h = (HANDLE) strtoull (argv[2], &end, 0);
   WaitForSingleObject (h, INFINITE);
   exit (0);
 }
-- 
2.21.0

Return-Path: <cygwin-patches-return-9813-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40315 invoked by alias); 8 Nov 2019 00:14:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40305 invoked by uid 89); 8 Nov 2019 00:14:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=HX-Languages-Length:549, HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Nov 2019 00:14:19 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id xA80EHqm083735;	Thu, 7 Nov 2019 16:14:17 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdQ4oIRv; Thu Nov  7 16:14:13 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Doc change to note stackdump limit patch
Date: Fri, 08 Nov 2019 00:14:00 -0000
Message-Id: <20191108001405.2923-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00084.txt.bz2

---
 winsup/cygwin/release/3.1.0 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.1.0 b/winsup/cygwin/release/3.1.0
index 1b9d23615..345dd62a5 100644
--- a/winsup/cygwin/release/3.1.0
+++ b/winsup/cygwin/release/3.1.0
@@ -35,6 +35,9 @@ What changed:
 
 - Improve /proc/cpuinfo output and align more closely with Linux.
 
+- Raise stackdump frame limit from 16 to 32.
+  Addresses: https://cygwin.com/ml/cygwin/2019-11/msg00038.html
+
 
 Bug Fixes
 ---------
-- 
2.21.0

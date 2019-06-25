Return-Path: <cygwin-patches-return-9459-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10340 invoked by alias); 25 Jun 2019 07:55:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10329 invoked by uid 89); 25 Jun 2019 07:55:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=HX-Languages-Length:823, HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 07:55:03 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5P7t187026632;	Tue, 25 Jun 2019 00:55:01 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdmGqRDm; Tue Jun 25 00:54:55 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Build cygwin-console-helper with correct compiler
Date: Tue, 25 Jun 2019 07:55:00 -0000
Message-Id: <20190625075441.1209-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00166.txt.bz2

---
 winsup/utils/Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index b64f457e7..cebf39572 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -64,7 +64,7 @@ MINGW_BINS := ${addsuffix .exe,cygcheck cygwin-console-helper ldh strace}
 # List all objects to be compiled in MinGW mode.  Any object not on this
 # list will will be compiled in Cygwin mode implicitly, so there is no
 # need for a CYGWIN_OBJS.
-MINGW_OBJS := bloda.o cygcheck.o dump_setup.o ldh.o path.o strace.o
+MINGW_OBJS := bloda.o cygcheck.o cygwin-console-helper.o dump_setup.o ldh.o path.o strace.o
 MINGW_LDFLAGS:=-static
 
 CYGCHECK_OBJS:=cygcheck.o bloda.o path.o dump_setup.o
-- 
2.21.0

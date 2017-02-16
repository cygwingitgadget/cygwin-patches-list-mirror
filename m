Return-Path: <cygwin-patches-return-8695-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75105 invoked by alias); 16 Feb 2017 15:58:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75026 invoked by uid 89); 16 Feb 2017 15:58:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*r:smtp, 2.10.2, 2102, I
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Feb 2017 15:57:57 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1ceORO-0006mg-KF; Thu, 16 Feb 2017 16:57:55 +0100
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1ceORN-0000sQ-Gz; Thu, 16 Feb 2017 16:57:54 +0100
Received: by s01en24 (sSMTP sendmail emulation); Thu, 16 Feb 2017 16:57:53 +0100
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] fix parallel build for version.cc and winver.o
Date: Thu, 16 Feb 2017 15:58:00 -0000
Message-Id: <20170216155740.6817-1-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2017-q1/txt/msg00036.txt.bz2

Creating both version.cc and winver.o at once really should run once only.
---
 winsup/cygwin/Makefile.in | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index bffb24a..c8652b0 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -747,10 +747,12 @@ libacl.a: ${LIB_NAME} sec_posixacl.o
 ${EXTRALIBS}: lib%.a: %.o
 	$(AR) cru $@ $?
 
-version.cc winver.o: mkvers.sh include/cygwin/version.h winver.rc $(DLL_OFILES)
+winver.o: mkvers.sh include/cygwin/version.h winver.rc $(DLL_OFILES)
 	@echo "Making version.cc and winver.o";\
 	/bin/sh ${word 1,$^} ${word 2,$^} ${word 3,$^} $(WINDRES) ${CFLAGS} $(addprefix -I,${CCWRAP_SYSTEM_HEADERS} ${CCWRAP_DIRAFTER_HEADERS})
 
+version.cc: winver.o
+
 Makefile: ${srcdir}/Makefile.in
 	/bin/sh ./config.status
 
-- 
2.10.2

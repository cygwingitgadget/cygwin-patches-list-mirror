Return-Path: <cygwin-patches-return-9070-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119576 invoked by alias); 4 Jun 2018 19:36:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118379 invoked by uid 89); 4 Jun 2018 19:36:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1547, para, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Jun 2018 19:36:19 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w54JaGFE030240;	Mon, 4 Jun 2018 15:36:17 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w54Ja679027599	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Mon, 4 Jun 2018 15:36:16 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 5/5] Cygwin: Document clearenv
Date: Mon, 04 Jun 2018 19:36:00 -0000
Message-Id: <20180604193607.17088-6-kbrown@cornell.edu>
In-Reply-To: <20180604193607.17088-1-kbrown@cornell.edu>
References: <20180604193607.17088-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00027.txt.bz2

---
 winsup/cygwin/include/cygwin/version.h | 3 ++-
 winsup/cygwin/release/2.10.1           | 1 +
 winsup/doc/posix.xml                   | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index f08707eea..2991ab858 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -494,12 +494,13 @@ details. */
   323: scanf %l[ conversion.
   324: Export sigtimedwait.
   325: Export catclose, catgets, catopen.
+  326: Export clearenv
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 325
+#define CYGWIN_VERSION_API_MINOR 326
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/release/2.10.1 b/winsup/cygwin/release/2.10.1
index 42d9d1110..ef7d08256 100644
--- a/winsup/cygwin/release/2.10.1
+++ b/winsup/cygwin/release/2.10.1
@@ -1,6 +1,7 @@
 What's new:
 -----------
 
+- New API: clearenv.
 
 What changed:
 -------------
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 8b4bab1b0..0c95091ea 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1284,6 +1284,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     asprintf_r
     basename			(see chapter "Implementation Notes")
     canonicalize_file_name
+    clearenv
     clog10
     clog10f
     clog10l
-- 
2.17.0

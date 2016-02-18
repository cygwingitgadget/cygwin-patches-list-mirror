Return-Path: <cygwin-patches-return-8335-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72470 invoked by alias); 18 Feb 2016 16:53:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72456 invoked by uid 89); 18 Feb 2016 16:53:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=294, closedir, 293, Hx-languages-length:1827
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 18 Feb 2016 16:53:43 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	by mx1.redhat.com (Postfix) with ESMTPS id 3D4FF70D74	for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2016 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1IGreKa030643	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2016 11:53:41 -0500
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: Export clog10, clog10f
Date: Thu, 18 Feb 2016 16:53:00 -0000
Message-Id: <1455814413-6864-1-git-send-email-yselkowi@redhat.com>
In-Reply-To: <1455814389-12684-1-git-send-email-yselkowi@redhat.com>
References: <1455814389-12684-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q1/txt/msg00041.txt.bz2

	winsup/cygwin/
	* common.din: Add clog10, clog10f.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

	winsup/doc/
	* posix.xml (std-gnu): Add clog10, clog10f.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/common.din               | 2 ++
 winsup/cygwin/include/cygwin/version.h | 3 ++-
 winsup/doc/posix.xml                   | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 9584d09..c39d265 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -232,6 +232,8 @@ clock_nanosleep SIGFE
 clock_setres SIGFE
 clock_settime SIGFE
 clog NOSIGFE
+clog10 NOSIGFE
+clog10f NOSIGFE
 clogf NOSIGFE
 close SIGFE
 closedir SIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 067a5f1..be85ce1 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -475,13 +475,14 @@ details. */
       291: Export aligned_alloc, at_quick_exit, quick_exit.
       292: Export rpmatch.
       293: Convert utmpname/utmpxname to int.
+      294: Export clog10, clog10f.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull,
 	sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 293
+#define CYGWIN_VERSION_API_MINOR 294
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 51a1df7..f065714 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1151,6 +1151,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     asprintf_r
     basename			(see chapter "Implementation Notes")
     canonicalize_file_name
+    clog10
+    clog10f
     dremf
     dup3
     envz_add
-- 
2.7.0

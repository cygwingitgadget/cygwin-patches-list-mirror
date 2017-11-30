Return-Path: <cygwin-patches-return-8949-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79737 invoked by alias); 30 Nov 2017 01:49:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79667 invoked by uid 89); 30 Nov 2017 01:49:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KB_WAM_FROM_NAME_SINGLEWORD,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=para, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 30 Nov 2017 01:49:08 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 95605C05679B	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-45.phx2.redhat.com [10.3.116.45])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 55677600D5	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 01:49:07 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: export wmempcpy
Date: Thu, 30 Nov 2017 01:49:00 -0000
Message-Id: <20171130014857.4668-1-yselkowi@redhat.com>
In-Reply-To: <20171130014829.19408-1-yselkowi@redhat.com>
References: <20171130014829.19408-1-yselkowi@redhat.com>
X-SW-Source: 2017-q4/txt/msg00079.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
Obviously this depends on the newlib implementation patch.

 winsup/cygwin/common.din               | 1 +
 winsup/cygwin/include/cygwin/version.h | 3 ++-
 winsup/doc/posix.xml                   | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index a482cf2b7..14b9c2c18 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1609,6 +1609,7 @@ wmemchr NOSIGFE
 wmemcmp NOSIGFE
 wmemcpy NOSIGFE
 wmemmove NOSIGFE
+wmempcpy NOSIGFE
 wmemset NOSIGFE
 wordexp NOSIGFE
 wordfree NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index d8bb3ee44..7510f42b0 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -489,12 +489,13 @@ details. */
        __stack_chk_fail, __stack_chk_guard, __stpcpy_chk, __stpncpy_chk,
        __strcat_chk, __strcpy_chk, __strncat_chk, __strncpy_chk,
        __vsnprintf_chk, __vsprintf_chk.
+  321: Export wmempcpy.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 320
+#define CYGWIN_VERSION_API_MINOR 321
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index c99e003ba..ab574300f 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1396,6 +1396,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     wcstoll_l
     wcstoul_l
     wcstoull_l
+    wmempcpy
 </screen>
 
 </sect1>
-- 
2.15.0

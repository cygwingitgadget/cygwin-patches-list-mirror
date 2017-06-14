Return-Path: <cygwin-patches-return-8786-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36567 invoked by alias); 14 Jun 2017 20:28:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36550 invoked by uid 89); 14 Jun 2017 20:28:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=What's, verr
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 14 Jun 2017 20:28:46 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id A00738553C	for <cygwin-patches@cygwin.com>; Wed, 14 Jun 2017 20:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com A00738553C
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=yselkowi@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com A00738553C
Received: from localhost.localdomain (ovpn-120-133.rdu2.redhat.com [10.10.120.133])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9A779C55	for <cygwin-patches@cygwin.com>; Wed, 14 Jun 2017 20:28:49 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: export strverscmp, add versionsort
Date: Wed, 14 Jun 2017 20:28:00 -0000
Message-Id: <20170614202840.7756-1-yselkowi@redhat.com>
X-SW-Source: 2017-q2/txt/msg00057.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
This depends on the newlib strverscmp patch.

 winsup/cygwin/common.din               | 2 ++
 winsup/cygwin/include/cygwin/version.h | 3 ++-
 winsup/cygwin/include/sys/dirent.h     | 1 +
 winsup/cygwin/release/2.8.1            | 2 ++
 winsup/cygwin/scandir.cc               | 6 ++++++
 winsup/doc/posix.xml                   | 2 ++
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 75fe05c1f..93316532c 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1396,6 +1396,7 @@ strtoull NOSIGFE
 strtoull_l NOSIGFE
 strtoumax = strtoull NOSIGFE
 strupr NOSIGFE
+strverscmp NOSIGFE
 strxfrm NOSIGFE
 strxfrm_l NOSIGFE
 swab NOSIGFE
@@ -1492,6 +1493,7 @@ vasprintf SIGFE
 vdprintf SIGFE
 verr SIGFE
 verrx SIGFE
+versionsort NOSIGFE
 vfiprintf SIGFE
 vfork SIGFE
 vfprintf SIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index c0254a8e0..bde358f72 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -476,12 +476,13 @@ details. */
   309: Export getloadavg.
   310: Export reallocarray.
   311: Export __xpg_sigpause.
+  312: Export strverscmp, versionsort.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 311
+#define CYGWIN_VERSION_API_MINOR 312
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/include/sys/dirent.h b/winsup/cygwin/include/sys/dirent.h
index 771f71620..049e87ad0 100644
--- a/winsup/cygwin/include/sys/dirent.h
+++ b/winsup/cygwin/include/sys/dirent.h
@@ -89,6 +89,7 @@ int alphasort (const struct dirent **__a, const struct dirent **__b);
 int scandirat (int __dirfd, const char *__dir, struct dirent ***__namelist,
 	       int (*select) (const struct dirent *),
 	       int (*compar) (const struct dirent **, const struct dirent **));
+int versionsort (const struct dirent **__a, const struct dirent **__b);
 #endif
 
 #if __BSD_VISIBLE
diff --git a/winsup/cygwin/release/2.8.1 b/winsup/cygwin/release/2.8.1
index 1ebe7d839..d03f29647 100644
--- a/winsup/cygwin/release/2.8.1
+++ b/winsup/cygwin/release/2.8.1
@@ -5,6 +5,8 @@ What's new:
 
 - New API: reallocarray
 
+- New API: strverscmp, versionsort.
+
 
 What changed:
 -------------
diff --git a/winsup/cygwin/scandir.cc b/winsup/cygwin/scandir.cc
index 1c324c196..d6ac64907 100644
--- a/winsup/cygwin/scandir.cc
+++ b/winsup/cygwin/scandir.cc
@@ -20,6 +20,12 @@ alphasort (const struct dirent **a, const struct dirent **b)
 }
 
 extern "C" int
+versionsort (const struct dirent **a, const struct dirent **b)
+{
+  return strverscmp ((*a)->d_name, (*b)->d_name);
+}
+
+extern "C" int
 scandir (const char *dir,
 	 struct dirent ***namelist,
 	 int (*select) (const struct dirent *),
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index ced7e383d..7e28427b4 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1367,6 +1367,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     strtoll_l
     strtoul_l
     strtoull_l
+    strverscmp
     sysinfo
     tdestroy
     timegm
@@ -1377,6 +1378,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     vasnprintf
     vasprintf
     vasprintf_r
+    versionsort
     wcsftime_l
     wcstod_l
     wcstof_l
-- 
2.12.3

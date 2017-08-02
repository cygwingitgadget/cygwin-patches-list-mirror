Return-Path: <cygwin-patches-return-8810-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32729 invoked by alias); 2 Aug 2017 06:11:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30710 invoked by uid 89); 2 Aug 2017 06:11:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1686, 4336, para, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 02 Aug 2017 06:11:38 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 4BF9EC24EE81	for <cygwin-patches@cygwin.com>; Wed,  2 Aug 2017 06:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 4BF9EC24EE81
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=yselkowi@redhat.com
Received: from localhost.localdomain (ovpn-120-53.rdu2.redhat.com [10.10.120.53])	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE31C6D2B5	for <cygwin-patches@cygwin.com>; Wed,  2 Aug 2017 06:11:36 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: Export explicit_bzero
Date: Wed, 02 Aug 2017 08:12:00 -0000
Message-Id: <20170802061128.5208-1-yselkowi@redhat.com>
X-SW-Source: 2017-q3/txt/msg00012.txt.bz2

This was added to newlib together with timingsafe_*cmp but never exported.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/common.din               | 1 +
 winsup/cygwin/include/cygwin/version.h | 3 ++-
 winsup/doc/posix.xml                   | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 08baa9e07..73e676841 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -433,6 +433,7 @@ exp2f NOSIGFE
 exp2l NOSIGFE
 expf NOSIGFE
 expl NOSIGFE
+explicit_bzero NOSIGFE
 expm1 NOSIGFE
 expm1f NOSIGFE
 expm1l NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index bbb632626..ce548b13a 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -478,12 +478,13 @@ details. */
   311: Export __xpg_sigpause.
   312: Export strverscmp, versionsort.
   313: Export fls, flsl, flsll.
+  314: Export explicit_bzero.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 313
+#define CYGWIN_VERSION_API_MINOR 314
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index bc506434f..5ce5988bc 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1139,6 +1139,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     endusershell
     err
     errx
+    explicit_bzero
     feof_unlocked
     ferror_unlocked
     fflush_unlocked
-- 
2.13.2

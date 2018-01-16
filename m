Return-Path: <cygwin-patches-return-8992-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111843 invoked by alias); 16 Jan 2018 03:19:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111404 invoked by uid 89); 16 Jan 2018 03:19:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=sk:yselkow, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jan 2018 03:19:17 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 10AF7356C6	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 03:19:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F2DA6B281	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 03:19:15 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: add LFS_CFLAGS etc. to confstr/getconf
Date: Tue, 16 Jan 2018 03:19:00 -0000
Message-Id: <20180116031900.18732-1-yselkowi@redhat.com>
X-SW-Source: 2018-q1/txt/msg00000.txt.bz2

These are used, for instance, when cross-compiling the Linux kernel.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 newlib/libc/include/sys/unistd.h | 4 ++++
 winsup/cygwin/sysconf.cc         | 6 +++++-
 winsup/utils/getconf.c           | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sys/unistd.h
index f216fb95c..5386bd49d 100644
--- a/newlib/libc/include/sys/unistd.h
+++ b/newlib/libc/include/sys/unistd.h
@@ -582,6 +582,10 @@ int	unlinkat (int, const char *, int);
 #define _CS_POSIX_V7_THREADS_LDFLAGS          19
 #define _CS_V7_ENV                            20
 #define _CS_V6_ENV                            _CS_V7_ENV
+#define _CS_LFS_CFLAGS                        21
+#define _CS_LFS_LDFLAGS                       22
+#define _CS_LFS_LIBS                          23
+#define _CS_LFS_LINTFLAGS                     24
 #endif
 
 #ifdef __cplusplus
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index ecd9aeb93..9563b889a 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -719,10 +719,14 @@ static struct
   {ls ("")},				/* _CS_POSIX_V7_THREADS_CFLAGS */
   {ls ("")},				/* _CS_POSIX_V7_THREADS_LDFLAGS */
   {ls ("POSIXLY_CORRECT=1")},		/* _CS_V7_ENV */
+  {ls ("")},				/* _CS_LFS_CFLAGS */
+  {ls ("")},				/* _CS_LFS_LDFLAGS */
+  {ls ("")},				/* _CS_LFS_LIBS */
+  {ls ("")},				/* _CS_LFS_LINTFLAGS */
 };
 
 #define CS_MIN _CS_PATH
-#define CS_MAX _CS_V7_ENV
+#define CS_MAX _CS_LFS_LINTFLAGS
 
 extern "C" size_t
 confstr (int in, char *buf, size_t len)
diff --git a/winsup/utils/getconf.c b/winsup/utils/getconf.c
index 256bddb1a..5ac84abd2 100644
--- a/winsup/utils/getconf.c
+++ b/winsup/utils/getconf.c
@@ -97,6 +97,10 @@ static const struct conf_variable conf_table[] =
   { "XBS5_WIDTH_RESTRICTED_ENVS",	CONFSTR,	_CS_XBS5_WIDTH_RESTRICTED_ENVS	},
   { "V7_ENV",				CONFSTR,	_CS_V7_ENV	},
   { "V6_ENV",				CONFSTR,	_CS_V6_ENV	},
+  { "LFS_CFLAGS",			CONFSTR,	_CS_LFS_CFLAGS	},
+  { "LFS_LDFLAGS",			CONFSTR,	_CS_LFS_LDFLAGS	},
+  { "LFS_LIBS",				CONFSTR,	_CS_LFS_LIBS	},
+  { "LFS_LINTFLAGS",			CONFSTR,	_CS_LFS_LINTFLAGS	},
 
   /* Symbolic constants from <limits.h> */
   { "_POSIX_AIO_LISTIO_MAX",		CONSTANT,	_POSIX_AIO_LISTIO_MAX	},
-- 
2.15.1

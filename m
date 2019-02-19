Return-Path: <cygwin-patches-return-9196-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77539 invoked by alias); 19 Feb 2019 05:09:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77514 invoked by uid 89); 19 Feb 2019 05:09:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, para
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 19 Feb 2019 05:09:57 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 27B62578	for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 05:09:56 +0000 (UTC)
Received: from yselkowitz.redhat.com (ovpn-116-11.phx2.redhat.com [10.3.116.11])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A20607CB	for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 05:09:55 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: add secure_getenv
Date: Tue, 19 Feb 2019 05:09:00 -0000
Message-Id: <20190219050950.19116-1-yselkowi@redhat.com>
X-SW-Source: 2019-q1/txt/msg00006.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
This is being used more frequently.  Since we don't have Linux capabilities,
setuid/setgid is the only condition we have to check.

 newlib/libc/include/stdlib.h           |  3 +++
 winsup/cygwin/common.din               |  1 +
 winsup/cygwin/environ.cc               | 10 ++++++++++
 winsup/cygwin/include/cygwin/version.h |  3 ++-
 winsup/doc/posix.xml                   |  1 +
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/newlib/libc/include/stdlib.h b/newlib/libc/include/stdlib.h
index 9773d3672..933d181e1 100644
--- a/newlib/libc/include/stdlib.h
+++ b/newlib/libc/include/stdlib.h
@@ -94,6 +94,9 @@ void	exit (int __status) _ATTRIBUTE ((__noreturn__));
 void	free (void *) _NOTHROW;
 char *  getenv (const char *__string);
 char *	_getenv_r (struct _reent *, const char *__string);
+#if __GNU_VISIBLE
+char *  secure_getenv (const char *__string);
+#endif
 char *	_findenv (const char *, int *);
 char *	_findenv_r (struct _reent *, const char *, int *);
 #if __POSIX_VISIBLE >= 200809
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index f620d8183..68b95d470 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1255,6 +1255,7 @@ sched_rr_get_interval SIGFE
 sched_setparam SIGFE
 sched_setscheduler SIGFE
 sched_yield SIGFE
+secure_getenv NOSIGFE
 seed48 NOSIGFE
 seekdir SIGFE
 select = cygwin_select SIGFE
diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 495c340a4..21f13734c 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -549,6 +549,16 @@ _getenv_r (struct _reent *, const char *name)
   return findenv_func (name, &offset);
 }
 
+/* Like getenv, but returns NULL if effective and real UID/GIDs do not match */
+extern "C" char *
+secure_getenv (const char *name)
+{
+  int offset;
+  if (cygheap->user.issetuid ())
+    return NULL;
+  return findenv_func (name, &offset);
+}
+
 /* Return number of environment entries, including terminating NULL. */
 static int __stdcall
 envsize (const char * const *in_envp)
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 2c55f4b79..d865f299d 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -508,12 +508,13 @@ details. */
   335: Change size of utsname, change uname output.
   336: New Cygwin PID algorithm (yeah, not really an API change)
   337: MOUNT_BINARY -> MOUNT_TEXT
+  338: Export secure_getenv.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 337
+#define CYGWIN_VERSION_API_MINOR 338
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 8e9b1a511..0755beda0 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1377,6 +1377,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     removexattr
     scandirat
     sched_getcpu
+    secure_getenv
     setxattr
     signalfd
     sincos
-- 
2.17.2

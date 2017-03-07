Return-Path: <cygwin-patches-return-8707-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53230 invoked by alias); 7 Mar 2017 12:38:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53037 invoked by uid 89); 7 Mar 2017 12:38:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=HX-Junkmail-Premium-Raw:NO_URI_HTTPS, HX-Junkmail-Premium-Raw:50,refid, HX-Junkmail-Premium-Raw:rules, HX-Junkmail-Premium-Raw:score
X-HELO: rgout05.bt.lon5.cpcloud.co.uk
Received: from rgout0501.bt.lon5.cpcloud.co.uk (HELO rgout05.bt.lon5.cpcloud.co.uk) (65.20.0.222) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Mar 2017 12:38:53 +0000
X-OWM-Source-IP: 86.184.210.90 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=8/50,refid=2.7.2:2016.12.19.183017:17:8.707,ip=,rules=NO_URI_FOUND, NO_CTA_URI_FOUND, NO_MESSAGE_ID, TO_MALFORMED, NO_URI_HTTPS
Received: from localhost.localdomain (86.184.210.90) by rgout05.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58482E5908E1342C; Tue, 7 Mar 2017 12:38:52 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Export timingsafe_bcmp and timingsafe_memcmp
Date: Tue, 07 Mar 2017 12:38:00 -0000
Message-Id: <20170307123841.16476-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q1/txt/msg00048.txt.bz2

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/common.din               |  2 ++
 winsup/cygwin/include/cygwin/version.h |  3 ++-
 winsup/cygwin/release/2.7.2            | 12 ++++++++++++
 winsup/doc/posix.xml                   |  2 ++
 4 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 winsup/cygwin/release/2.7.2

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 8c9af21..6cbb012 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1437,6 +1437,8 @@ timer_gettime SIGFE
 timer_settime SIGFE
 times SIGFE
 timezone SIGFE
+timingsafe_bcmp NOSIGFE
+timingsafe_memcmp NOSIGFE
 tmpfile SIGFE
 tmpnam SIGFE
 toascii NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index b647ae9..308bc8b 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -471,12 +471,13 @@ details. */
   304: Export strerror_l, strptime_l, wcsftime_l.
   305: [f]pathconf flag _PC_CASE_INSENSITIVE added.
   306: Export getentropy, getrandom.
+  307: Export timingsafe_bcmp, timingsafe_memcmp.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 306
+#define CYGWIN_VERSION_API_MINOR 307
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/release/2.7.2 b/winsup/cygwin/release/2.7.2
new file mode 100644
index 0000000..e7c7ee5
--- /dev/null
+++ b/winsup/cygwin/release/2.7.2
@@ -0,0 +1,12 @@
+What's new:
+-----------
+
+- New API: timingsafe_bcmp, timingsafe_memcmp
+
+What changed:
+-------------
+
+
+Bug Fixes
+
+---------
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index e80da4d..fac32b7 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1232,6 +1232,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     strlcat
     strlcpy
     strsep
+    timingsafe_bcmp
+    timingsafe_memcmp
     updwtmp
     valloc
     verr
-- 
2.8.3

Return-Path: <cygwin-patches-return-8494-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80417 invoked by alias); 28 Mar 2016 17:48:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80323 invoked by uid 89); 28 Mar 2016 17:48:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HX-Envelope-From:sk:yselkow, states, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 28 Mar 2016 17:48:37 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (Postfix) with ESMTPS id 2B6C63B71B	for <cygwin-patches@cygwin.com>; Mon, 28 Mar 2016 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2SHmSwN007734	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Mon, 28 Mar 2016 13:48:29 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: export __getpagesize
Date: Mon, 28 Mar 2016 17:48:00 -0000
Message-Id: <1459187300-8800-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q1/txt/msg00200.txt.bz2

The inclusion of <sys/cygwin.h> by <sys/shm.h>, besides causing namespace
pollution, also makes it very difficult to get the WINVER-dependent parts
of the former.  This affects code (such as x11vnc -unixpw_nis) which use
both SysV shared memory (e.g. the X11 MIT-SHM extension) and user password
authentication.

getpagesize is the simplest function to retreive this information, but it
is a legacy function and would also pollute the global namespace. The LSB
lists another form which is in the implementation-reserved namespace:

http://refspecs.linuxfoundation.org/LSB_3.1.0/LSB-Core-generic/LSB-Core-generic/baselib---getpagesize.html

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/common.din               | 1 +
 winsup/cygwin/include/cygwin/shm.h     | 5 +++--
 winsup/cygwin/include/cygwin/version.h | 3 ++-
 winsup/cygwin/shm.cc                   | 4 ++++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index fe714d8..7e72abe 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -60,6 +60,7 @@ __freading NOSIGFE
 __fsetlocking SIGFE
 __fwritable NOSIGFE
 __fwriting NOSIGFE
+__getpagesize = getpagesize SIGFE
 __getreent NOSIGFE
 __gnu_basename NOSIGFE
 __infinity NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/shm.h b/winsup/cygwin/include/cygwin/shm.h
index c585993..5fbfb11 100644
--- a/winsup/cygwin/include/cygwin/shm.h
+++ b/winsup/cygwin/include/cygwin/shm.h
@@ -13,7 +13,6 @@ details. */
 #define _CYGWIN_SHM_H
 
 #include <cygwin/ipc.h>
-#include <sys/cygwin.h>
 
 #ifdef __cplusplus
 extern "C"
@@ -24,7 +23,9 @@ extern "C"
  *
  * 64 Kb was hardcoded for x86. MS states this may change so the constant
  * expression is replaced by a function call returning the correct value. */
-#define SHMLBA	(cygwin_internal (CW_GET_SHMLBA))
+#define SHMLBA	(__getpagesize ())
+/* internal alias of legacy getpagesize to avoid polluting global namespace */
+int __getpagesize (void);
 
 /* Shared memory operation flags:
  */
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 4edb8db..ee7c4ff 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -477,13 +477,14 @@ details. */
       293: Convert utmpname/utmpxname to int.
       294: Export clog10, clog10f.
       295: Export POSIX ACL functions.
+      296: Export __getpagesize.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull,
 	sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 295
+#define CYGWIN_VERSION_API_MINOR 296
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
diff --git a/winsup/cygwin/shm.cc b/winsup/cygwin/shm.cc
index e209346..1d3200c 100644
--- a/winsup/cygwin/shm.cc
+++ b/winsup/cygwin/shm.cc
@@ -21,6 +21,10 @@ details. */
 #include "sync.h"
 #include "ntdll.h"
 
+/* __getpagesize is only available from libcygwin.a */
+#undef SHMLBA
+#define SHMLBA (wincap.allocation_granularity ())
+
 /*
  * client_request_shm Constructors
  */
-- 
2.7.4

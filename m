Return-Path: <cygwin-patches-return-8706-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40677 invoked by alias); 2 Mar 2017 16:27:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40651 invoked by uid 89); 2 Mar 2017 16:27:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*r:smtp, H*r:sk:mailhos, H*r:4.77
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Mar 2017 16:27:14 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1cjTZP-0001qX-KE; Thu, 02 Mar 2017 17:27:12 +0100
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1cjTZO-0001iU-5a; Thu, 02 Mar 2017 17:27:11 +0100
Received: by s01en24 (sSMTP sendmail emulation); Thu, 02 Mar 2017 17:27:10 +0100
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] forkables: inline dll_list::forkables_supported
Date: Thu, 02 Mar 2017 16:27:00 -0000
Message-Id: <20170302162653.8108-1-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2017-q1/txt/msg00047.txt.bz2

And LONG fits better for shared_info member forkable_hardlink_support.
---
 winsup/cygwin/dll_init.cc   | 1 +
 winsup/cygwin/dll_init.h    | 6 ++++--
 winsup/cygwin/fork.cc       | 1 +
 winsup/cygwin/forkable.cc   | 8 +-------
 winsup/cygwin/shared_info.h | 4 ++--
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 1779843..ffc6a0b 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -8,6 +8,7 @@ details. */
 #include "cygerrno.h"
 #include "perprocess.h"
 #include "sync.h"
+#include "shared_info.h"
 #include "dll_init.h"
 #include "environ.h"
 #include "security.h"
diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index 7129cee..eede54b 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -86,8 +86,10 @@ struct dll
 
 class dll_list
 {
-  /* forkables */
-  bool forkables_supported ();
+  bool forkables_supported ()
+  {
+    return cygwin_shared->forkable_hardlink_support >= 0;
+  }
   DWORD forkables_dirx_size;
   bool forkables_created;
   PWCHAR forkables_dirx_ntname;
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 6e38a5a..4dda2a2 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -20,6 +20,7 @@ details. */
 #include "child_info.h"
 #include "cygtls.h"
 #include "tls_pbuf.h"
+#include "shared_info.h"
 #include "dll_init.h"
 #include "cygmalloc.h"
 #include "ntdll.h"
diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index b668d03..2cb5e73 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -10,7 +10,6 @@ details. */
 #include "cygerrno.h"
 #include "perprocess.h"
 #include "sync.h"
-#include "dll_init.h"
 #include "environ.h"
 #include "security.h"
 #include "path.h"
@@ -19,6 +18,7 @@ details. */
 #include "cygheap.h"
 #include "pinfo.h"
 #include "shared_info.h"
+#include "dll_init.h"
 #include "child_info.h"
 #include "cygtls.h"
 #include "exception.h"
@@ -501,12 +501,6 @@ dll::create_forkable ()
   return false;
 }
 
-bool
-dll_list::forkables_supported ()
-{
-  return cygwin_shared->forkable_hardlink_support >= 0;
-}
-
 /* return the number of characters necessary to store one forkable name */
 size_t
 dll_list::forkable_ntnamesize (dll_type type, PCWCHAR fullntname, PCWCHAR modname)
diff --git a/winsup/cygwin/shared_info.h b/winsup/cygwin/shared_info.h
index fcc53d7..154f98e 100644
--- a/winsup/cygwin/shared_info.h
+++ b/winsup/cygwin/shared_info.h
@@ -32,7 +32,7 @@ public:
 /* Data accessible to all tasks */
 
 
-#define CURR_SHARED_MAGIC 0x72c39e6fU
+#define CURR_SHARED_MAGIC 0xed846fc3U
 
 #define USER_VERSION   1
 
@@ -48,7 +48,7 @@ class shared_info
   LONG last_used_bindresvport;
   DWORD obcaseinsensitive;
   mtinfo mt;
-  char forkable_hardlink_support; /* single byte access always is atomic */
+  LONG forkable_hardlink_support;
 
   void initialize ();
   void init_obcaseinsensitive ();
-- 
2.10.2

Return-Path: <cygwin-patches-return-8708-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115160 invoked by alias); 8 Mar 2017 14:25:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114965 invoked by uid 89); 8 Mar 2017 14:24:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=D*org.uk, para
X-HELO: rgout03.bt.lon5.cpcloud.co.uk
Received: from rgout0304.bt.lon5.cpcloud.co.uk (HELO rgout03.bt.lon5.cpcloud.co.uk) (65.20.0.210) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Mar 2017 14:24:57 +0000
X-OWM-Source-IP: 86.184.210.90 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=8/50,refid=2.7.2:2016.12.21.193617:17:8.707,ip=,rules=NO_URI_FOUND, NO_CTA_URI_FOUND, NO_MESSAGE_ID, TO_MALFORMED, NO_URI_HTTPS
Received: from localhost.localdomain (86.184.210.90) by rgout03.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58A82A5C021E2967; Wed, 8 Mar 2017 14:24:55 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Implement dladdr() (partially)
Date: Wed, 08 Mar 2017 14:25:00 -0000
Message-Id: <20170308142442.44824-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q1/txt/msg00049.txt.bz2

Note that this always returns with dli_sname and dli_saddr set to NULL,
indicating no symbol matching addr could be found.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---

Notes:
    Mesa 17.1 will want to use dladdr() in order to use the mtime of a loadable
    module to control the validity of a cache, and this implementation suffices
    for that purpose (not that this caching is implemented for llvmpipe at the
    moment)

 winsup/cygwin/common.din      |  1 +
 winsup/cygwin/dlfcn.cc        | 34 ++++++++++++++++++++++++++++++++++
 winsup/cygwin/include/dlfcn.h | 18 ++++++++++++++++++
 winsup/doc/posix.xml          |  4 ++++
 4 files changed, 57 insertions(+)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 6cbb012..f236813 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -364,6 +364,7 @@ difftime NOSIGFE
 dirfd SIGFE
 dirname NOSIGFE
 div NOSIGFE
+dladdr SIGFE
 dlclose SIGFE
 dlerror NOSIGFE
 dlfork NOSIGFE
diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index 159d4fe..87c1ab1 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -386,3 +386,37 @@ dlerror ()
     }
   return res;
 }
+
+extern "C" int
+dladdr (const void *addr, Dl_info *info)
+{
+  HMODULE hModule;
+  BOOL ret = GetModuleHandleEx (GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
+			   (LPCSTR) addr,
+			   &hModule);
+  if (!ret)
+    return 0;
+
+  /* Module handle happens to be equal to it's base load address. */
+  info->dli_fbase = hModule;
+
+  /* Get the module filename.  This pathname may be in short-, long- or //?/
+     format, depending on how it was specified when loaded, but We assume this
+     is always an absolute pathname. */
+  WCHAR fname[MAX_PATH];
+  DWORD length = GetModuleFileNameW (hModule, fname, MAX_PATH);
+  if ((length == 0) || (length == MAX_PATH))
+    return 0;
+
+  /* Convert to a cygwin pathname */
+  ssize_t conv = cygwin_conv_path (CCP_WIN_W_TO_POSIX | CCP_ABSOLUTE, fname,
+				   info->dli_fname, MAX_PATH);
+  if (conv)
+    return 0;
+
+  /* Always indicate no symbol matching addr could be found. */
+  info->dli_sname = NULL;
+  info->dli_saddr = NULL;
+
+  return 1;
+}
diff --git a/winsup/cygwin/include/dlfcn.h b/winsup/cygwin/include/dlfcn.h
index 8522ec5..d9435d0 100644
--- a/winsup/cygwin/include/dlfcn.h
+++ b/winsup/cygwin/include/dlfcn.h
@@ -9,6 +9,9 @@ details. */
 #ifndef _DLFCN_H
 #define _DLFCN_H
 
+#include <sys/cdefs.h>
+#include <limits.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -42,6 +45,21 @@ extern void dlfork (int);
 #define RTLD_DEEPBIND  32	/* Place lookup scope so that this lib is    */
 				/* preferred over global scope.  */
 
+
+#if __GNU_VISIBLE
+typedef struct Dl_info Dl_info;
+
+struct Dl_info
+{
+   char        dli_fname[PATH_MAX];  /* Filename of defining object */
+   void       *dli_fbase;            /* Load address of that object */
+   const char *dli_sname;            /* Name of nearest lower symbol */
+   void       *dli_saddr;            /* Exact value of nearest symbol */
+};
+
+extern int dladdr (const void *addr, Dl_info *info);
+#endif
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index fac32b7..03d168d 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1277,6 +1277,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     clog10
     clog10f
     clog10l
+    dladdr			(see chapter "Implementation Notes")
     dremf
     dup3
     envz_add
@@ -1665,6 +1666,9 @@ depending on whether _BSD_SOURCE or _GNU_SOURCE is defined when compiling.</para
 <para><function>basename</function> is available in both POSIX and GNU flavors,
 depending on whether libgen.h is included or not.</para>
 
+<para><function>dladdr</function> always sets the Dl_info members dli_sname and
+dli_saddr to NULL, indicating no symbol matching addr could be found.</para>
+
 </sect1>
 
 </chapter>
-- 
2.8.3

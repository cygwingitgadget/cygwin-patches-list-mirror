Return-Path: <SRS0=KgIy=2N=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id AA2003858D20
	for <cygwin-patches@cygwin.com>; Fri,  1 Aug 2025 19:18:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA2003858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA2003858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1754075912; cv=none;
	b=rlaMNKQY+1ONDfC/YKUFa2Ef5ReyWIuiPczgppZ/scAlJQzhmbwbNt3oNbIlWN5a3QEyLIGRu5JNHc/tNthZVU0crzHXDZY20quJCG05wmNq1e2HUa0dzwtbWO0d46D8QV5suqDQ38Wr4t7XnezpJqcpxMSqQauOeRMV7solaT0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1754075912; c=relaxed/simple;
	bh=0dJ3kIi/7DBQ8Gr3/LPnurAxjY0aCYnTlLDUCRf3SLo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=qNM+Fa8CtLb75BhRRdokBGvgPnBgOp91+xrUOxzG2NWGf/nZxK0lb6eUsUj5aG9vtIZu+522EnG4DR2HJxgElJ23+MsoPBdcb6QAIleKn4/WXVM6CXplwBsIWtjwjaCAcFrGYZQATDGKxCRUUUZ3lVv+aH+J3wnzGqvyW+AbZx4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA2003858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Z1XTJ+yN
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1E91E45CEB
	for <cygwin-patches@cygwin.com>; Fri, 01 Aug 2025 15:18:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=SEmvC
	F/LyvjXjL8ZOQeFLeBYvsg=; b=Z1XTJ+yNkXU0RQ5N246Zt85WoTqEzKGjtjpJM
	1iophzKkLMupDpE71jLUWTmpN7ekfKf2VvRpWVtJb3Pd3C316SpQNDB51Zs7rUV1
	uBdDnF5i3+KpUuoKmICKOUs5WxdBPoR6TzfWvPEW/SEXEsBcsiT3DmIBUtem/pev
	WNDqjA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 07BBB45CE7
	for <cygwin-patches@cygwin.com>; Fri, 01 Aug 2025 15:18:32 -0400 (EDT)
Date: Fri, 1 Aug 2025 12:18:31 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: add api version check to c++ malloc struct
 override.
Message-ID: <ff5e8cb0-205b-4d08-7eba-51f112e9619c@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This prevents memory corruption if a newer app or dll is used with an
older cygwin dll.  This is an unsupported scenario, but it's still a
good idea to avoid corrupting memory if possible.

Fixes: 7d5c55faa1 ("Cygwin: add wrappers for newer new/delete overloads")
Co-authored-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

I left out initializing dll_major/dll_minor in dcrt0.cc as these fields
are initialized in globals.cc already.  I also continue to update the
__cygwin_cxx_malloc struct even though I don't think anything should be
using it (rather the default_cygwin_cxx_malloc via the user_data pointer).
It's not static for some reason, so something *could* be accessing it I
guess.

 winsup/cygwin/dcrt0.cc                   |  6 ++++
 winsup/cygwin/include/cygwin/version.h   |  3 ++
 winsup/cygwin/lib/_cygwin_crt0_common.cc | 37 ++++++++++++++----------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 69c233c247..1a4ffc8925 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -724,6 +724,12 @@ dll_crt0_0 ()
   lock_process::init ();
   user_data->impure_ptr = _impure_ptr;
   user_data->impure_ptr_ptr = &_impure_ptr;
+  /* API version info is used by newer _cygwin_crt0_common to handle
+     certain issues in a forward compatible way.  _cygwin_crt0_common
+     overwrites these values with the application's version info at the
+     time of building the app, as usual. */
+  user_data->api_major = cygwin_version.api_major;
+  user_data->api_minor = cygwin_version.api_minor;

   DuplicateHandle (GetCurrentProcess (), GetCurrentThread (),
 		   GetCurrentProcess (), &hMainThread,
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index f3321020f7..00eedeb27a 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -36,6 +36,9 @@ details. */
 #define CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS \
   (CYGWIN_VERSION_USER_API_VERSION_COMBINED >= 272)

+#define CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS(u) \
+  (CYGWIN_VERSION_PER_PROCESS_API_VERSION_COMBINED (u) >= 359)
+
 /* API_MAJOR 0.0: Initial version.  API_MINOR changes:
     1: Export cygwin32_ calls as cygwin_ as well.
     2: Export j1, jn, y1, yn.
diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
index 5900e6315d..87f3e8042b 100644
--- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
+++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
@@ -124,6 +124,9 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
 {
   per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
   bool uwasnull;
+  bool new_dll_with_additional_operators =
+       newu ? CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS (newu)
+            : false;

   /* u is non-NULL if we are in a DLL, and NULL in the main exe.
      newu is the Cygwin DLL's internal per_process and never NULL.  */
@@ -180,8 +183,11 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
     {
       /* Inherit what we don't override.  */
 #define CONDITIONALLY_OVERRIDE(MEMBER) \
-      if (!__cygwin_cxx_malloc.MEMBER) \
+      if (__cygwin_cxx_malloc.MEMBER) \
+	newu->cxx_malloc->MEMBER = __cygwin_cxx_malloc.MEMBER; \
+      else \
 	__cygwin_cxx_malloc.MEMBER = newu->cxx_malloc->MEMBER;
+
       CONDITIONALLY_OVERRIDE(oper_new);
       CONDITIONALLY_OVERRIDE(oper_new__);
       CONDITIONALLY_OVERRIDE(oper_delete);
@@ -190,20 +196,21 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
       CONDITIONALLY_OVERRIDE(oper_new___nt);
       CONDITIONALLY_OVERRIDE(oper_delete_nt);
       CONDITIONALLY_OVERRIDE(oper_delete___nt);
-      CONDITIONALLY_OVERRIDE(oper_delete_sz);
-      CONDITIONALLY_OVERRIDE(oper_delete___sz);
-      CONDITIONALLY_OVERRIDE(oper_new_al);
-      CONDITIONALLY_OVERRIDE(oper_new___al);
-      CONDITIONALLY_OVERRIDE(oper_delete_al);
-      CONDITIONALLY_OVERRIDE(oper_delete___al);
-      CONDITIONALLY_OVERRIDE(oper_delete_sz_al);
-      CONDITIONALLY_OVERRIDE(oper_delete___sz_al);
-      CONDITIONALLY_OVERRIDE(oper_new_al_nt);
-      CONDITIONALLY_OVERRIDE(oper_new___al_nt);
-      CONDITIONALLY_OVERRIDE(oper_delete_al_nt);
-      CONDITIONALLY_OVERRIDE(oper_delete___al_nt);
-      /* Now update the resulting set into the global redirectors.  */
-      *newu->cxx_malloc = __cygwin_cxx_malloc;
+      if (new_dll_with_additional_operators)
+	{
+	  CONDITIONALLY_OVERRIDE(oper_delete_sz);
+	  CONDITIONALLY_OVERRIDE(oper_delete___sz);
+	  CONDITIONALLY_OVERRIDE(oper_new_al);
+	  CONDITIONALLY_OVERRIDE(oper_new___al);
+	  CONDITIONALLY_OVERRIDE(oper_delete_al);
+	  CONDITIONALLY_OVERRIDE(oper_delete___al);
+	  CONDITIONALLY_OVERRIDE(oper_delete_sz_al);
+	  CONDITIONALLY_OVERRIDE(oper_delete___sz_al);
+	  CONDITIONALLY_OVERRIDE(oper_new_al_nt);
+	  CONDITIONALLY_OVERRIDE(oper_new___al_nt);
+	  CONDITIONALLY_OVERRIDE(oper_delete_al_nt);
+	  CONDITIONALLY_OVERRIDE(oper_delete___al_nt);
+	}
     }

   /* Setup the module handle so fork can get the path name.  */
-- 
2.50.1.windows.1


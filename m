Return-Path: <SRS0=Iaxo=2O=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id A9C043858C78
	for <cygwin-patches@cygwin.com>; Sat,  2 Aug 2025 18:18:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A9C043858C78
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A9C043858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1754158681; cv=none;
	b=APQ6DpkS3swL4BGuvU1pgBXHOaptvO7Ke5wXAqWmggeVTVDznITVGCVQUVmJ6RpWyeuiF93PLlbmfHYotFkaNUfj8IiObx2FRL1WxgrWLf/4vD8LS5i/hbKp2EYXC+Z40HJ/HSI/i5930c8CF7c1/RKNfHNu021ku73WKpChFmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1754158681; c=relaxed/simple;
	bh=1hFpyb3uUlNmboaB+OHdb8w8Zd5x+HKkATJqEyjrU0I=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PSVj99RkgWnK1mloRrvnB4Lpe1uYWSpYGHtlXsbSVt0D5a75kdLRd9UdciwrHBjkbYb0JJmdHUCph/NsQ+nSLseJWh/zicSI7a69fYfMCfjb/SHVx+h6FeV+zAjbVlxMAHSwhOzblLoBh37kGTzro4vjF2DxRX++SM6Vcvce+Dw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A9C043858C78
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=xZcvzcf6
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 76CD845CE1
	for <cygwin-patches@cygwin.com>; Sat, 02 Aug 2025 14:18:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=cnE5EoiqeWJ/EV6wfbD+h7uSUKs=; b=xZcvz
	cf6BTHEdUoEMEzI3OJVZaioaYbahn64nuiznFb9kCZm7mV3EBxv+DpS8goZ/Szj0
	BQlTfPMCf/Q6tjyV2fB6YzSSLbqlBMQq7fAEpbC4wj3PE0y+ar5s7atukNTykJF0
	rqmAIh9ChXWQ6kAwd3m/+yGCCKJz0p2Ygbg2F8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 5FF1A45CDA
	for <cygwin-patches@cygwin.com>; Sat, 02 Aug 2025 14:18:01 -0400 (EDT)
Date: Sat, 2 Aug 2025 11:18:01 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: add api version check to c++ malloc struct
 override.
In-Reply-To: <aI5Va0_O8rg0VCbh@calimero.vinschen.de>
Message-ID: <72ca7654-451c-b8a0-dfd9-f2f82a63fc6c@jdrake.com>
References: <ff5e8cb0-205b-4d08-7eba-51f112e9619c@jdrake.com> <aI42aRxXOsYFOzpq@calimero.vinschen.de> <4f3bd8e1-b32c-9e9e-bc94-5dc0d0bd52a9@jdrake.com> <aI5Va0_O8rg0VCbh@calimero.vinschen.de>
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
 winsup/cygwin/globals.cc                 |  4 +--
 winsup/cygwin/include/cygwin/version.h   |  3 ++
 winsup/cygwin/lib/_cygwin_crt0_common.cc | 38 +++++++++++++-----------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index d8e058f191..86b0c2718a 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -173,8 +173,8 @@ extern "C" {
    /* unused */ {},
    /* cxx_malloc */ &default_cygwin_cxx_malloc,
    /* hmodule */ NULL,
-   /* api_major */ 0,
-   /* api_minor */ 0,
+   /* api_major */ CYGWIN_VERSION_API_MAJOR,
+   /* api_minor */ CYGWIN_VERSION_API_MINOR,
    /* unused2 */ {},
    /* posix_memalign */ posix_memalign,
    /* pseudo_reloc_start */ NULL,
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
index 5900e6315d..a22528ab48 100644
--- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
+++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
@@ -124,6 +124,8 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
 {
   per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
   bool uwasnull;
+  bool new_dll_with_additional_operators =
+       CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS (newu);

   /* u is non-NULL if we are in a DLL, and NULL in the main exe.
      newu is the Cygwin DLL's internal per_process and never NULL.  */
@@ -176,12 +178,13 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
   /* Likewise for the C++ memory operators, if any, but not if we
      were dlopen()'d, as we might get dlclose()'d and that would
      leave stale function pointers behind.    */
-  if (newu && newu->cxx_malloc && !__dynamically_loaded)
+  if (!__dynamically_loaded)
     {
       /* Inherit what we don't override.  */
 #define CONDITIONALLY_OVERRIDE(MEMBER) \
-      if (!__cygwin_cxx_malloc.MEMBER) \
-	__cygwin_cxx_malloc.MEMBER = newu->cxx_malloc->MEMBER;
+      if (__cygwin_cxx_malloc.MEMBER) \
+	newu->cxx_malloc->MEMBER = __cygwin_cxx_malloc.MEMBER;
+
       CONDITIONALLY_OVERRIDE(oper_new);
       CONDITIONALLY_OVERRIDE(oper_new__);
       CONDITIONALLY_OVERRIDE(oper_delete);
@@ -190,20 +193,21 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
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


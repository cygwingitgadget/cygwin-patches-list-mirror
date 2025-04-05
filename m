Return-Path: <SRS0=YXhK=WX=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 2924B385AC3F
	for <cygwin-patches@cygwin.com>; Sat,  5 Apr 2025 17:22:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2924B385AC3F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2924B385AC3F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743873740; cv=none;
	b=rvAP8eJrV5SE/D8VNEQyccA1J96Jc7O8cYp6mgvZA/9mfj3A8+L9o6ARv77pta+GtMR80RvFCBILplQa25yu7+H2Z5bIVj+FPxcP1jvnUsPckaWJe56Me+anCL4JA2PKQ9Pvr+0yGbOcrFUH8DPUepxYgYHO0FiB0CqXyFq8NAk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743873740; c=relaxed/simple;
	bh=sYzJIBAC4KK2nzstIaA8sPuuGlk2uhGDL3xyZUDn3S8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=F1vFWQ+ld1nQHEh0GtFmToTEjwGd3WAen0qNPOjPT0cKxxe7OdAGdMms1Vd0kczzJuv7cxCUmjjUvbIF3I+5Qxp8+RAXkPK2Ftar75YOanNfK7s9VTl2DiyCA1iWhmuNukhoRlk7LTsDe450/Xt2PwWI/kpaFJ7dIb4S+EJwCfo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2924B385AC3F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=hS+YPvqI
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9884945C68
	for <cygwin-patches@cygwin.com>; Sat, 05 Apr 2025 13:22:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=83pYy
	tLoJWXvlXAmZDu5SbvgXjc=; b=hS+YPvqIxxa8cTGWIROe7UdFRYA7MDfihl+OW
	PP8qpRInd+iJtQTLP+AyKWhBqKtXVssWbHBgr/H7gpR3V0YR9yTLCk+xkyPnFst5
	wPE7ya6UC0eaV3M9/si4FVuJs73zonzywpEaN3/jB3c8qcEqyxkPp7zFVUp51tpK
	Lr+mQ4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9310245C63
	for <cygwin-patches@cygwin.com>; Sat, 05 Apr 2025 13:22:19 -0400 (EDT)
Date: Sat, 5 Apr 2025 10:22:19 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Don't increment DLL reference count in dladdr.
Message-ID: <e1ea4725-bac4-d351-5bfd-d7e2d9a85acf@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Unlike GetModuleHandle, GetModuleHandleEx increments the reference count
by default unless the GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT flag
is passed.

Fixes: c8432a01c840 ("Implement dladdr() (partially)")
Addresses: https://cygwin.com/pipermail/cygwin/2025-April/257864.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/dlfcn.cc      | 3 ++-
 winsup/cygwin/release/3.6.1 | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index f029ebbf2c..10bd0ac1f4 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -408,7 +408,8 @@ extern "C" int
 dladdr (const void *addr, Dl_info *info)
 {
   HMODULE hModule;
-  BOOL ret = GetModuleHandleEx (GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
+  BOOL ret = GetModuleHandleEx (GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT|
+				GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
 				(LPCSTR) addr,
 				&hModule);
   if (!ret)
diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
index c09a23376e..280952c91a 100644
--- a/winsup/cygwin/release/3.6.1
+++ b/winsup/cygwin/release/3.6.1
@@ -36,3 +36,6 @@ Fixes:
   subprocess failure in cmake (>= 3.29.x).
   Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257800.html
   Addresses: https://github.com/msys2/msys2-runtime/issues/272
+
+- Don't increment DLL reference count in dladdr.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-April/257862.html
-- 
2.48.1.windows.1


Return-Path: <SRS0=d5ak=YG=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 083533858023
	for <cygwin-patches@cygwin.com>; Thu, 22 May 2025 17:11:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 083533858023
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 083533858023
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747933919; cv=none;
	b=t+ofue/2sPwoCsbd79zcad94vnZzv8ihBk8JbS7qVARHp+MDuukGbZI0g2CMPhzOzXaJfpsgw5oo2Kp3MoHNhDBF6Pqi/9TrKVOm5n6A6FYJFPsko/9Ayq+6YvGjiQC75MRqOwrEPBHQgCCakdAV4oHJ2fS+yPud4ecnf5BBT3w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747933919; c=relaxed/simple;
	bh=Uv5Zp1mUT2z8NPd5uxtC2IpGgvMt39RBchT7Dz9fFag=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=d2KmwxgCgn8I5YP7UJSrHphOOoJERnNmvoLqenaub+AZEzO0oPTlqildI3Tkrb4f16A57fXfQyEr8JMtiYUEnij140DXOoVNbaWu6eRjemURacFVrnruJSrHG5yKcaVE/iMuJHDvPZ2oXPoQblmAZanI0gXyFsZNIZ2vQ9dAOkM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 083533858023
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=tR7/HpSU
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A136445CBB
	for <cygwin-patches@cygwin.com>; Thu, 22 May 2025 13:11:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=fXOeQ
	VgKO1fu5iJphOjR0gqFUDU=; b=tR7/HpSU6jA5/uO3qXVTvhP8iOaML2kN3mzBt
	+XNBoWUFGtxrR6cNlXJ6hO707e7dOhv/c+twSiPzncs++ArZ5z5ZRfn0FaCFPUUl
	b9cQdFAoFXv1+ieSPRLmvTj20um1jq2aMu2isjK5kM2vmsQWukthcNIax/Znrvf0
	1jxQo4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 8712245CBA
	for <cygwin-patches@cygwin.com>; Thu, 22 May 2025 13:11:58 -0400 (EDT)
Date: Thu, 22 May 2025 10:11:58 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: dll_init: use size_t instead of DWORD for size
Message-ID: <61ee55a2-9aed-187b-a748-a3c653255177@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The RegionSize member of the MEMORY_BASIC_INFORMATION struct is of type
SIZE_T, and it may be larger than will fit in a DWORD (I observed
0x200000000).  This resulted in an error due to trying to reserve 0
bytes from VirtualAlloc.

Fixes: 8d777a13fcf4 ("* dll_init.cc (reserve_at, release_at): New functions.")
Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258154.html
Reported-by: Yuyi Wang <Strawberry_Str@hotmail.com>
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/dll_init.cc   | 2 +-
 winsup/cygwin/release/3.6.2 | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index b8f38b56de..e5953ca9f6 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -633,7 +633,7 @@ dll_list::track_self ()
 static PVOID
 reserve_at (PCWCHAR name, PVOID here, PVOID dll_base, DWORD dll_size)
 {
-  DWORD size;
+  size_t size;
   MEMORY_BASIC_INFORMATION mb;

   if (!VirtualQuery (here, &mb, sizeof (mb)))
diff --git a/winsup/cygwin/release/3.6.2 b/winsup/cygwin/release/3.6.2
index 3b1944d99f..16a4fee156 100644
--- a/winsup/cygwin/release/3.6.2
+++ b/winsup/cygwin/release/3.6.2
@@ -28,3 +28,6 @@ Fixes:

 - Fix infinite exception loop on segmentation fault when strace-ing
   Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258144.html
+
+- Fix size truncation in dll_init reserve_at function.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258154.html
-- 
2.49.0.windows.1


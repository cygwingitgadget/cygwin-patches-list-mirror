Return-Path: <SRS0=rgYs=WQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E92FD3858D29
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 22:55:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E92FD3858D29
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E92FD3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743288957; cv=none;
	b=tc8CbFdshxq4AZTkf7lTSKrjUhbzeweaERiohnp83/HuLsTQA2kqpHsY/yAxo8ZAXeZLkcXVmGKU+vCheIzMxNuO4CxcuSnHQ5UmHWJ7bmf4mIDiineevRdkivRAA0EQnpvdR2fWSgL/fifeo7NAM7YdyyXh987l5uqubCkkoS0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743288957; c=relaxed/simple;
	bh=iDk2WlSyhdjRVQQfux2lLiZGxqubdCPDNAOMJbgzJmA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=svtmQu2mDtH77SocwZfJlUy1rDr3QyNwKAxS3TDmAlPpJCcn+UVGjVHqR5DEfOc6g0PPfUOgnNzezOgnzhCwW1e2yiQWQk5pSUpMa6v0n7QaFWDVvr36JT5wTi3Hiay8LKiDCw/xRZ6Gbdhy1X4TbMJfzZXHSqFdZ5dOS7LTnYI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E92FD3858D29
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=UHd8ZEIs
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 6B16845CB3
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 18:55:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=5Cs8N8Mxr9r/v+VNONsyJkvLGEE=; b=UHd8Z
	EIsRT4Sm+IOCSNAJFspK8QX2ceLhexcPCVg+VpHuh8coUVIsntm9LCaRCp4tWkEr
	ncb+ujoPCWkUbZVy4zf9610muy6Pl6dYgGEaP4lMBYScC1vu53zGv2VqodcSl64U
	R0+bBBZqNHlacIAbzTw+fw/E9OcTA9EvyNSCXc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 52AC845CB2
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 18:55:56 -0400 (EDT)
Date: Sat, 29 Mar 2025 15:55:56 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <20da32b5-3d5d-b5ef-1b6a-9ef181285b1a@jdrake.com>
Message-ID: <6e18afd8-3952-8a85-c235-45fbd01db70b@jdrake.com>
References: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com> <3e7c52d1-01ef-4843-23a4-18f69da1ecea@jdrake.com> <20da32b5-3d5d-b5ef-1b6a-9ef181285b1a@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 29 Mar 2025, Jeremy Drake via Cygwin-patches wrote:

> I tested x86_64 code on every released Windows version from 9600 to 26100.
> Interestingly, the machine code of the "use_cwd" function
> (RtlpReferenceCurrentDirectory) didn't seem to change until 26100.
>
> (I previously tested the prototype aarch64 code on 16299, 19045, 22631,
> and 26100, but only 22000+ supports x86_64 emulation).

I updated the prototype code with latest updates and tested on arm64 in
16299, 19045, 22631, 26100, and finally 22000.  It seems the "thunk"/"fast
forward sequence" differs on 22000, but luckily it's the same size.  Do I
need to resend the whole series or just a v4 of the last patch?

diff --git a/winsup/cygwin/aarch64/fastcwd.cc b/winsup/cygwin/aarch64/fastcwd.cc
index a0f169b61a..f075b8cd59 100644
--- a/winsup/cygwin/aarch64/fastcwd.cc
+++ b/winsup/cygwin/aarch64/fastcwd.cc
@@ -23,16 +23,20 @@ GetArm64ProcAddress (HMODULE hModule, LPCSTR procname)
 #if defined (__aarch64__)
   return proc;
 #else
-#if defined(__i386__)
+#if defined (__i386__)
   static const BYTE thunk[] = "\x8b\xff\x55\x8b\xec\x5d\x90\xe9";
-#elif defined(__x86_64__)
+  static const BYTE thunk2[0];
+#elif defined (__x86_64__)
   /* see
      https://learn.microsoft.com/en-us/windows/arm/arm64ec-abi#fast-forward-sequences */
   static const BYTE thunk[] = "\x48\x8b\xc4\x48\x89\x58\x20\x55\x5d\xe9";
+  /* on windows 11 22000 the thunk is different than documented on that page */
+  static const BYTE thunk2[] = "\x48\x8b\xff\x55\x48\x8b\xec\x5d\x90\xe9";
 #else
 #error "Unhandled architecture for thunk detection"
 #endif
-  if (memcmp (proc, thunk, sizeof (thunk) - 1) == 0)
+  if (memcmp (proc, thunk, sizeof (thunk) - 1) == 0 ||
+      sizeof(thunk2) && memcmp (proc, thunk2, sizeof (thunk2) - 1) == 0)
     {
       proc += sizeof (thunk) - 1;
       proc += 4 + *(const int32_t *) proc;


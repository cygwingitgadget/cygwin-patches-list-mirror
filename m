Return-Path: <SRS0=/OvC=XO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 6E9F83858D1E
	for <cygwin-patches@cygwin.com>; Mon, 28 Apr 2025 05:28:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6E9F83858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6E9F83858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745818123; cv=none;
	b=xYP1bIvDYCgJra1iJlhU1dz+wTmrRiaCB2ZH1OYZKL3ptdx2+4CVqj0V8Q/2nexeTokTM6fURk9kTj8vYK+trx+yACgIuTkwqjhLQYTMjK2DSjSjcpqTgCGuzVB1GCXxYAEBjoExueUYgvu09K6gPgBK/2f9zZJZfj7Z/3q0A7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745818123; c=relaxed/simple;
	bh=g1Dqk0DgLXZVi8fIJd0MKsSDpucvBXPREswK+ds37FY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jPXqARfFLfqzSUjJQHLpIIVuhHp07QUZBXJ/2dEStB0m+s3C+LvS+5DEwUJEs+tIac1W0cgIM2Ks6dQPnEHNb8jJEfkvLleLa6xKdLtNLZyHv3DUl7Am03oR4430Yo3BiGCfC81UOU/E+WgRBxdqyOMUniZISBdNR37JUC6TEfc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6E9F83858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=c4VwuSkT
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 125C645C32
	for <cygwin-patches@cygwin.com>; Mon, 28 Apr 2025 01:28:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=nv+Ag
	UQLGnRHAeAlKwjuLothsoM=; b=c4VwuSkTzvTV3X7jIUbAyoT1zRu1R4JNqXb+4
	JxDZD/p0iZgaoLNCfJ0NZmNKNfJy1mFS9wYie9Q/UcjT1JDSQvtjKHl912bC0rgk
	ivBVRMl2RGhVT26Vp4Kjk7G/4G36KGchJc8lfa12zBvMtTTErb+eTYSQyBj8b09Z
	8bMg1A=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id EF5A245C29
	for <cygwin-patches@cygwin.com>; Mon, 28 Apr 2025 01:28:42 -0400 (EDT)
Date: Sun, 27 Apr 2025 22:28:42 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: dladdr: use proper max size of dli_fname.
Message-ID: <3c6343b3-2bee-46bd-7446-879ad3110062@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Due to being converted to a mbcs, the output of converting a wide string
of MAX_PATH characters is potentially larger than MAX_PATH bytes.  The
DL_info::dli_fname member is actually PATH_MAX bytes, so specify that
(larger) size to cygwin_conv_path rather than PATH_MAX.

Fixes: c8432a01c840 ("Implement dladdr() (partially)")
Addresses: https://github.com/rust-lang/backtrace-rs/pull/704#issuecomment-2833782574
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
Would it be better to use tmp_pathbuf in place of the fname WCHAR array,
to allow longer paths to come out of GetModuleFileNameW?


 winsup/cygwin/dlfcn.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index 10bd0ac1f4..a3523b6153 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -428,7 +428,7 @@ dladdr (const void *addr, Dl_info *info)

   /* Convert to a cygwin pathname */
   ssize_t conv = cygwin_conv_path (CCP_WIN_W_TO_POSIX | CCP_ABSOLUTE, fname,
-				   info->dli_fname, MAX_PATH);
+				   info->dli_fname, PATH_MAX);
   if (conv)
     return 0;

-- 
2.49.0.windows.1


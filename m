Return-Path: <SRS0=rU34=XQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id AF7DF3858CD9
	for <cygwin-patches@cygwin.com>; Wed, 30 Apr 2025 19:45:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AF7DF3858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AF7DF3858CD9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746042356; cv=none;
	b=UUlvcCpLEbGpTbUKj2drmQkE6CY1kHWVbdrlggGgGZGXUXFrTy45sJGHcEdVGx7AtaK4Yz6XN4lVJ8KekFcy5IqRbocUjCt3pkPnOpTMXE1e3Bl+ath8TvzTR7u2UpF2FcAnQdqK6OEhdBgGqptcI6LxInAJod9hTIHdeTwG5jE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746042356; c=relaxed/simple;
	bh=HYBf4NQ8FU8ljIlExJyez6NffG6PSdXJAu4JVu8WSVo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WHuQeOfaYPpcR8OFkNuu1UAZkUBJD0n/hbiFxq8I/nE0HwWhEvQEWPfza6utGWW1AySEK1/ybWkgC44omgTCbLITxkhsZWe79/FRB3PILTA9XVQ6N5ZOG5tuwIpoYb+1uCrh7IubAye4jA9xHRYvKgPdTwShUt6J0UHKvDtck5Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AF7DF3858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=GjzcfoT7
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2EC1E45C56
	for <cygwin-patches@cygwin.com>; Wed, 30 Apr 2025 15:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=jH1tB
	10s04Xh/9tg1W+k3XEBffk=; b=GjzcfoT7C8lJ+n2fcDLpNP1STOXspZrHOTZ1E
	ukRG9Ad/IVSdHnyqzzx7/lQyR2r7AOshiRr3Jz0VqOXTwrY6ZbIz5THu1k1kl2dw
	wr/lo5cgTY014oMp6yRzN9w900OWtpYxQxUIeDA8dxeI/yFEU4NCxeILObCBZ4df
	VpkJr0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 2A95745C51
	for <cygwin-patches@cygwin.com>; Wed, 30 Apr 2025 15:45:56 -0400 (EDT)
Date: Wed, 30 Apr 2025 12:45:56 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: dladdr: use proper max size of dli_fname.
Message-ID: <b4ed3ebb-2fb3-4d95-1069-017bb381ad81@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The DL_info::dli_fname member is actually PATH_MAX bytes, so specify
that (larger) size to cygwin_conv_path rather than MAX_PATH.

Also, use a tmp_pathbuf for the GetModuleFileNameW buffer, so that any
buffer size limitation will definitely be due to the size of dli_fname,
and add a static_assert of the size of dli_fname so we can be sure we're
using the right size constant here.

Fixes: c8432a01c840 ("Implement dladdr() (partially)")
Addresses: https://github.com/rust-lang/backtrace-rs/pull/704#issuecomment-2833782574
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/dlfcn.cc | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index 10bd0ac1f4..9b6bb55b34 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -421,14 +421,16 @@ dladdr (const void *addr, Dl_info *info)
   /* Get the module filename.  This pathname may be in short-, long- or //?/
      format, depending on how it was specified when loaded, but we assume this
      is always an absolute pathname. */
-  WCHAR fname[MAX_PATH];
-  DWORD length = GetModuleFileNameW (hModule, fname, MAX_PATH);
-  if ((length == 0) || (length == MAX_PATH))
+  tmp_pathbuf tp;
+  PWCHAR fname = tp.w_get ();
+  DWORD length = GetModuleFileNameW (hModule, fname, NT_MAX_PATH);
+  if ((length == 0) || (length == NT_MAX_PATH))
     return 0;

   /* Convert to a cygwin pathname */
+  static_assert (sizeof (info->dli_fname) == PATH_MAX);
   ssize_t conv = cygwin_conv_path (CCP_WIN_W_TO_POSIX | CCP_ABSOLUTE, fname,
-				   info->dli_fname, MAX_PATH);
+				   info->dli_fname, PATH_MAX);
   if (conv)
     return 0;

-- 
2.49.0.windows.1


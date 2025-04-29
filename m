Return-Path: <SRS0=bvCe=XP=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 0D3AF3858D26
	for <cygwin-patches@cygwin.com>; Tue, 29 Apr 2025 17:42:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0D3AF3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0D3AF3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745948579; cv=none;
	b=g6OrUXnCUh0/uXxLJShJyvAJNtJrAx6ygpaHbB9yA2Qad7Tt8DTtr+B67swrOztO7q1OYg6T7yP/dKN9YVQy7x5jNjA7k+W1dpYHI04q4yxMmiuSa0gaFhVn3D3X3m8/dgHw8pt7ymeZBeT2P//ZEdybEy5SCIfIKaSQhEx8nVg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745948579; c=relaxed/simple;
	bh=BIUliMyNj32jU1gxjgPe7rBgfXcifpAB1tj4q83LbgI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=oPlvBkqr6r07Vv0O9tDFu8tDsIoAKv3hPlot+GNWJNRqr3SSoSzYduQm2tDj3vrUCo8JQU/RFa8fFUU1ifKZhXO9lmmGZrRH1S1h4kl4jjuIBOgIISmhzeAuf7F2CtEo5NKcqzfP7NX1NY0GJ95eR2WX3Iz9nixCksbBkm3+0Vk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0D3AF3858D26
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=s6RcCqrL
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B3E4F45C42
	for <cygwin-patches@cygwin.com>; Tue, 29 Apr 2025 13:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=UcP39
	ZRfSPsCvTkcVqUdloYDJK0=; b=s6RcCqrLSmQFArxHxkPJH/i+fLeITp0bnOK8v
	TRyc7wZ6DiczL+hqsWjz7RA21A0LvPqhkMW7Hz5ATkh5WbqxE2qshj4zlke1nnv2
	22iFSNQEYlLt/Ii8AcX03Fv7WHBesv33vQ1QYEewWA7r+p5BzDTvNIDG61V/Umlx
	LYB0ig=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id AD91145C1D
	for <cygwin-patches@cygwin.com>; Tue, 29 Apr 2025 13:42:58 -0400 (EDT)
Date: Tue, 29 Apr 2025 10:42:58 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: cygwin_conv_path: don't write to `to` before size
 is validated.
Message-ID: <bd0e9cdd-ba1f-423b-089c-7f84e5e8bb3f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In the CCP_POSIX_TO_WIN_W path, when `from` is a device,
cygwin_conv_path would attempt to write to the `to` buffer before the
validation of the `size`.  This resulted in an EFAULT error in the
common use-case of passing `to` as NULL and `size` as 0 to get the
required size of `to` for the conversion (as used in
cygwin_create_path).  Instead, set a boolean and write to `to`
after validation.

Fixes: 43f65cdd7dae ("* Makefile.in (DLL_OFILES): Add fhandler_procsys.o.")
Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258068.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/path.cc       | 5 ++++-
 winsup/cygwin/release/3.6.2 | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 7a08e978ad..d26f99ee7f 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3911,6 +3911,7 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
   int how = what & CCP_CONVFLAGS_MASK;
   what &= CCP_CONVTYPE_MASK;
   int ret = -1;
+  bool prependglobalroot = false;

   __try
     {
@@ -4019,7 +4020,7 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
 	    {
 	      /* Device name points to somewhere else in the NT namespace.
 		 Use GLOBALROOT prefix to convert to Win32 path. */
-	      to = (void *) wcpcpy ((wchar_t *) to, ro_u_globalroot.Buffer);
+	      prependglobalroot = true;
 	      lsiz += ro_u_globalroot.Length / sizeof (WCHAR);
 	    }
 	  /* TODO: Same ".\\" band-aid as in CCP_POSIX_TO_WIN_A case. */
@@ -4075,6 +4076,8 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
 	  stpcpy ((char *) to, buf);
 	  break;
 	case CCP_POSIX_TO_WIN_W:
+	  if (prependglobalroot)
+	    to = (void *) wcpcpy ((PWCHAR) to, ro_u_globalroot.Buffer);
 	  wcpcpy ((PWCHAR) to, path);
 	  break;
 	}
diff --git a/winsup/cygwin/release/3.6.2 b/winsup/cygwin/release/3.6.2
index bceabcab34..de6eae13fc 100644
--- a/winsup/cygwin/release/3.6.2
+++ b/winsup/cygwin/release/3.6.2
@@ -13,3 +13,6 @@ Fixes:

 - Fix setting DOS attributes on devices.
   Addresse: https://cygwin.com/pipermail/cygwin/2025-April/257940.html
+
+- Fix cygwin_conv_path writing to 'to' pointer before size is checked.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258068.html
-- 
2.49.0.windows.1


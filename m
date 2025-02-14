Return-Path: <SRS0=cBQE=VF=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E44D33858D38
	for <cygwin-patches@cygwin.com>; Fri, 14 Feb 2025 00:23:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E44D33858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E44D33858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739492618; cv=none;
	b=QvBT7qKHySg3SKXJBy6fvyAcW7XtxikRcKlo5umHi16G3KABTmz5GBsCfA+Ol7T5LYz8ChGJLrvajp7oVLF1p1KZMHYOMjkXK2LBcH9kD0J9r4oXfccu2uvlx6FyjdJylR+3KL1YKXH7YD+3uUtq4QEPxwsoBotfQ6AMmEjnaGo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739492618; c=relaxed/simple;
	bh=DfJqjA5qNNZJ6AuhHtq7qTiWuE6TvD6/diLJZ41l3uo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=MMljfIZbleZ8ZC64m36rQx7RIOioXJiHlpLfoXYtaJHEim5+Y18MtpkRP1Ixc+2LWqrGaDW6HQgBqBBrPwT23WqIYbxky5wHIBGvS9BStR6i0q0cK6pOJBGD3mGww91uf3xZjLF36wVhkMjvMBbaRaMWXdiEejvZqr88cxkQaF0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E44D33858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=H+1xrTO+
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 8725345B2C
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 19:23:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=vLglr
	PALRwkxwjE2WluQKBSV7Fw=; b=H+1xrTO+aWCPULf2G0C5k4O0eEUnoD0amel/N
	h5mKnNtFFAhb5rpHCDVfi/7Xqa+zWsgD7LgCXQDjjYZ9S039Lvgfl//LUwQ1azGf
	PwFZ1oqoEN1arVUTzaDnJW7ReGwcZDL+46/QEniKYkpGGdn+BYYBEw0umzgnjB/U
	ym/2bw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 2CA8645AFB
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 19:23:37 -0500 (EST)
Date: Thu, 13 Feb 2025 16:23:36 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: 3.6.0: add release entries for my patches.
Message-ID: <88cff69f-e6df-2aa7-cb00-e86ddb10796d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

These are:
  04a5b07294 Cygwin: expose all windows volume mount points.
  0d113da235 Cygwin: /proc/<PID>/mount*: escape strings.
  7923059bff Cygwin: uname: add host machine tag to sysname.
  b091b47b9e cygthread: suspend thread before terminating.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/release/3.6.0 | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/winsup/cygwin/release/3.6.0 b/winsup/cygwin/release/3.6.0
index e193a20c03..5869d7ffc8 100644
--- a/winsup/cygwin/release/3.6.0
+++ b/winsup/cygwin/release/3.6.0
@@ -91,3 +91,24 @@ What changed:
   MAP_SHARED/MAP_PRIVATE flags agree and MAP_NORESERVE is not set for
   either mapping.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256901.html
+
+- Fix a long-standing hang issue when running on ARM64 under emulation.
+  This was due to a thread being terminated while the emulation was
+  holding an internal lock.
+  Addresses: https://cygwin.com/pipermail/cygwin-developers/2024-May/012694.html
+
+- Add a host machine tag to uname(2)'s sysname field.  This echoes what
+  used to be done with -WOW64 (when that was supported), but now with
+  -ARM64 when running on an ARM64 host under emulation.  The Cygwin DLL's
+  own architecture continues to be reported in the machine field.
+
+- Escape special characters in /proc/<PID>/mount*.  This allows the
+  contents to be parsed consistently, and matches what is done on Linux.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-June/256082.html
+
+- Expose all Windows volume mount points via getmntent(3).  This also
+  exposes them via /proc/<PID>/mount*.  A change in behavior from
+  previous Cygwin versions is that volumes whose root is mounted
+  explicitly in Cygwin will now also show up as mounted under the
+  cygdrive prefix, whereas before that entry would have been suppressed.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-June/256081.html
-- 
2.48.1.windows.1


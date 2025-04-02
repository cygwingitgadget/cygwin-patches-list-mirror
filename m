Return-Path: <SRS0=7VsH=WU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 67CF33858420
	for <cygwin-patches@cygwin.com>; Wed,  2 Apr 2025 20:01:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 67CF33858420
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 67CF33858420
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743624119; cv=none;
	b=DAQETTSekG9ikqvBMKKZGDQMo0gi8kpOT9qhONeSqhft3OHo33QTohq9cnelGLCiecQRLhdDXguum6rze5sKYgstkxPKHwh9W9rIOppEJlD6mwVYtTdGHdMSbJaV54ijYV7z0fMGH5BjsQB39oClqtLvollnHV8WxBvm9qSHscc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743624119; c=relaxed/simple;
	bh=uX+S8PyvR6LBUiPvyiFapWb3qAJZrolh+IBKClGJsNI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=TUBYzWG59s8bRfGt3S+C1d59YbURIIOHnmvEDjSBkXk9qjzaqotv+ZqknQmv4E2wU6D5gpZTyzzy4EF/ruiG0EF8FVBgX0eD7lrjb4+T3Tuu72hbxk1zZV7NXv717eE8jKV681HWMCGNFelbcAtjmX1iXoNa5aeZ1JTVFT6WHwI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 67CF33858420
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=mLmeM/rU
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CBEBA45C7B
	for <cygwin-patches@cygwin.com>; Wed, 02 Apr 2025 16:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=OTCHm
	Obcfc/wMFraLQU/26wkhLc=; b=mLmeM/rUTqcC2iEXam4YQQoDGQUdGXwIBir78
	iR7PgZDt4HkRojU1LheWdjG8Q1jovet+gTwEZIdHRoVYsCl6WCEN4uxERIyRc1Ra
	JiUs1ly6CM3XyGyand6zsfYPxygrryMCZjW4rvd+N+GRj+e+qtnigLJ2BByos/k1
	3ocmBg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C584245C68
	for <cygwin-patches@cygwin.com>; Wed, 02 Apr 2025 16:01:58 -0400 (EDT)
Date: Wed, 2 Apr 2025 13:01:58 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: handle GetProcAddress returning NULL in
 GetArm64ProcAddress.
Message-ID: <110f5fb0-8161-09d9-df71-6ee96f8ec383@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This was an oversight, the caller of GetArm64ProcAddress does check for
a NULL return, but it would have crashed in the memcmp before getting
there.

Fixes: 2c5f25035d9f ("Cygwin: add find_fast_cwd_pointer_aarch64.")
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/aarch64/fastcwd.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/aarch64/fastcwd.cc b/winsup/cygwin/aarch64/fastcwd.cc
index a85c539817..e53afc0046 100644
--- a/winsup/cygwin/aarch64/fastcwd.cc
+++ b/winsup/cygwin/aarch64/fastcwd.cc
@@ -35,8 +35,8 @@ GetArm64ProcAddress (HMODULE hModule, LPCSTR procname)
 #else
 #error "Unhandled architecture for thunk detection"
 #endif
-  if (memcmp (proc, thunk, sizeof (thunk) - 1) == 0 ||
-     (sizeof(thunk2) && memcmp (proc, thunk2, sizeof (thunk2) - 1) == 0))
+  if (proc && (memcmp (proc, thunk, sizeof (thunk) - 1) == 0 ||
+	(sizeof(thunk2) && memcmp (proc, thunk2, sizeof (thunk2) - 1) == 0)))
     {
       proc += sizeof (thunk) - 1;
       proc += 4 + *(const int32_t *) proc;
-- 
2.48.1.windows.1


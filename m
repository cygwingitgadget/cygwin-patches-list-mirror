Return-Path: <SRS0=KdRA=YY=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 03CE03858D38
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 20:28:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 03CE03858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 03CE03858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749500919; cv=none;
	b=xRo+e55bNWjPTzbuKTq40e1+5Dw1S804DyLSnb3hXwKO1HClK6GJ3ibdNrwJV/SmVSNEdQozHsRYqgQitTuncNGCMO7OctWEbCzQc9o0NZ10aDNqFngDv39LQ23wmY/vCmc4AUA1LvANLGHd1md5eZSF0v1JKrJRdJqdxksa5+o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749500919; c=relaxed/simple;
	bh=7nDMDUs2H+G/oX0qVLabZkMNYM0eH2hX7pR7+1rH0sI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=J9lUxbc2h+s8slyCz2Eu6RZcQ+vcXIj6Inuxp7autb9f7RcG1bNN+VW/mwq2aSagBetGTtvzHS8UuiQA4izBGsQTuaOzslYdFUDNiw2es1pmS1dPoWLVpmyPQl5YSRgeDY8kJzoiKwWpa6/xHw+Hxk/xhGSQ1qOkhVVxRWCaDCY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03CE03858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=JLXUQkIz
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9D34945CBD
	for <cygwin-patches@cygwin.com>; Mon, 09 Jun 2025 16:28:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=z0GUs
	6NRSJErva1MDmL14i+4ZDE=; b=JLXUQkIzd+Z3Y4r67pOkTwtZb7Jo1g8sgQ5b/
	TniDMjQUWomF6d7Q6J0YHZRmgH5mwuhl5h62WNfyQIHiwZB+RztDODnLJCUhmfYR
	vdt26qGh9y9FICsCuaAwRSgKOeS3Iq/BT1OLnIiwTKkpSZuLqceWgGh5f8W5EKTl
	NaJpxM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7FED845CA8
	for <cygwin-patches@cygwin.com>; Mon, 09 Jun 2025 16:28:38 -0400 (EDT)
Date: Mon, 9 Jun 2025 13:28:38 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: CI: grant full control to Administrators on github
 workspace
Message-ID: <733a91af-f510-f2f8-4577-5354eed64941@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

After inherited permissons were removed, apparently there were no
permissions left allowing access, and GHA recently started failing on
actions/checkout with EPERM.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 .github/workflows/cygwin.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 087a68a999..3c3cd93219 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -107,7 +107,10 @@ jobs:
     - run: git config --global core.autocrlf input
     # remove inheritable permissions since they break assumptions testsuite
     # makes about file modes
-    - run: icacls . /inheritance:r
+    - name: adjust permissions
+      run: |
+        icacls . /inheritance:r
+        icacls . /grant Administrators:F
     - uses: actions/checkout@v3

     # install cygwin and build tools
-- 
2.49.0.windows.1


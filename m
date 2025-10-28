Return-Path: <SRS0=Ftjg=5F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 0EFDE3858CD1
	for <cygwin-patches@cygwin.com>; Tue, 28 Oct 2025 11:49:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0EFDE3858CD1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0EFDE3858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761652178; cv=none;
	b=KWaNbXHrxFhez+ZHkHSi4eTEouXf7CN+JL4i8sOlPhunMRId1DqcnhxV9da7iOBjUTARqJPFTx/sYGi8uq/H4xZwvLgahkAO2sHb5hchP/HaiZ5ca+jQrJr4m25V8O0LsaQyGvWK13RUiHioUXgG4pinSLKtr5Sr6nlrt60ZMRg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761652178; c=relaxed/simple;
	bh=Sn2ZBFX1tNzKjYLbPFDogugARH2JPYbcFWH6RJH/6/E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=IBn/4ELwE2fLSM9hbOBY0a4ZeCWu8nzwP07jbp4+FVBLks5/S+MNt4K9Iu7FVa3FbsNBevXCS5W4pTBEuUpLPefSkSYJES7vJ6S06yL/9YIytsdiFuItiXqzsNh4lFlHysWd4dHE1dOJ24biBfktiAkUhdbBdjmtc3RL3NX9Nkw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0EFDE3858CD1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=M/zL77n9
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20251028114936355.WYSH.17135.HP-Z230@nifty.com>;
          Tue, 28 Oct 2025 20:49:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/2] Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.
Date: Tue, 28 Oct 2025 20:48:42 +0900
Message-ID: <20251028114853.11052-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
References: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1761652176;
 bh=U3yYkB6uf3zH3pZy8srmJ5B8mXwjGyHOfh1XxzG6Dto=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M/zL77n9hN5mmw3HvKYQ/iYBIDTEw2x144vhKPPJBQRZL9eNPozHDeq09lsB7MGWNpKQVK0z
 nIfCH5IbcoRC+8dUHuiG862vJqi4o+GkgS11MTbhAcxqpMnEyU47dvw0wJ0VtzYzj24X7uHS3b
 gnFetQEBT9O8aLX5rnmFQt/H6/u60z/nIThnpuz8GnWrcDutzmDJsL/Wmn3DXsAHjMAF0EvhV8
 icgnBWZwrnm5iYxFJh6MWDWyoFSjj9GjvaESlbxRIsWDiC3wXemNvW84d+VKQxehxG7Y6e7xF9
 z2YPTcRP/TLMH6aktDOCD5sKyhBpw5eCMcx52sKKj3oTlt2A==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If dlopen() for the first DLL is called in the constructor of another
(second) DLL, the constructor for the first DLL is called twice, once
called via cygwin_attach_dll() called from LoadLibrary(), and again
from dll_list::init(). That is, the DLL with DLL_LOAD does not need
dll::init() in dll_list::init(). This issue was found when debugging
the issue: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
This patch remove dll::init() call in dll_list::init() for DLL_LOAD.

Fixes: 2eb392bd77de ("dll_init.cc: Revamp.  Use new classes.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dll_init.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index b6ab4ed11..996f00a44 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -610,9 +610,10 @@ dll_list::init ()
   /* Walk the dll chain, initializing each dll */
   dll *d = &start;
   dll_global_dtors_recorded = d->next != NULL;
-  /* Init linked and early loaded Cygwin DLLs. */
+  /* Init linked Cygwin DLLs. As for loaded DLLs, dll::init() is already
+     called via _cygwin_dll_entry called from LoadLibrary(). */
   while ((d = d->next))
-    if (d->type == DLL_LINK || d->type == DLL_LOAD)
+    if (d->type == DLL_LINK)
       d->init ();
 }
 
-- 
2.51.0


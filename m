Return-Path: <SRS0=vCDf=52=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 7091D385B534
	for <cygwin-patches@cygwin.com>; Tue, 18 Nov 2025 23:46:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7091D385B534
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7091D385B534
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763509589; cv=none;
	b=NG055TCctuYTFWZPuKkdlxuSlebmAYf64m6KHznrNnIUZf+7BrsJZiicWwurY6R55jOszDU2NxyXQhv22vnBJ8geZ09RJd8NYHxcmXMTGzGTYFln4CnAAubm7Lu8tqm55aJ8IBmElOIOksG2Pe9hto0crP1q8ncXvQkvg36spu4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763509589; c=relaxed/simple;
	bh=hvJCFm2WQ11K7ZQTGCJ4WaV5uYwJCwIC9nODa6Z30yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TWC/sqxfBaxs8pNs2LhHyMNxIWmrc3qRLfLSnC+sRdPwW2c+x2GOaCBLfYACOE6/6l/f5SqhGeHyxRbK1VWM/LUi6FZeaV/yIcx6Evp1fy5wNUVqSHh+W42V0tYjkUsWaf94puSETYLJqvXEduNh8iEgGJK53w8siSihYKAxxN4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7091D385B534
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tB+lLVPa
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251118234626796.MGOT.50988.HP-Z230@nifty.com>;
          Wed, 19 Nov 2025 08:46:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v3 2/2] Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.
Date: Wed, 19 Nov 2025 08:45:18 +0900
Message-ID: <20251118234535.194356-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118234535.194356-1-takashi.yano@nifty.ne.jp>
References: <20251118234535.194356-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763509586;
 bh=gxlzu822v404FfcLqDMcyBJDGZTB4CsFW/Bsq9DLkXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tB+lLVPaHbrjUnowM2A5iitoXqrHqsaU8NvFHB16fQ+kjr0LrnMpmEZ+/3bFVUTstwpRbu9O
 T8mIHARwg5QBT43IngkbTK/eHiaitvnCgqDW9fwXddR5B5I1G5WPTAK5kvNwqmaM7zW4vQSlsR
 inZyaYbcb5CVCIzbCRTxrNTWxWds+mpd/UfsI6S3AYnYS7C7MAcyvn4SiPU4UNTtRAXZP4Zm+K
 j2W/2N9FZcRrTFSVufHT2j0N1JsTFMILPC6IxQK7OOXYjncAoSkWVnbd0njkwBOYtMu3B8i5Xd
 feATzSCbymnEZpZh7+Hc9ulCAsnY6su7cEX4GVGdUYgnIoBg==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If dlopen() for DLL A is called in constructor DLL B, the constructor
for DLL A is called twice, once called via cygwin_attach_dll() called
from LoadLibrary(), and again from dll_list::init(). That is, the DLL
with DLL_LOAD does not need dll::init() in dll_list::init(). This issue
was found when debugging the issue:
https://cygwin.com/pipermail/cygwin/2025-October/258877.html
This patch remove dll::init() call in dll_list::init() for DLL_LOAD.

Fixes: 2eb392bd77de ("dll_init.cc: Revamp.  Use new classes.")
Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>, Corinna Vinschen <corinna-cygwin@cygwin.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dll_init.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index d2ed74bed..6fae8f145 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -618,9 +618,10 @@ dll_list::init ()
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


Return-Path: <SRS0=vCDf=52=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id D21533857359
	for <cygwin-patches@cygwin.com>; Tue, 18 Nov 2025 14:10:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D21533857359
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D21533857359
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763475027; cv=none;
	b=Kib/qAxreTocBrCXcEpBqsUn5mmP4t6OjqWqosGBP6LO7LNXXl2NVDiSESMj5trkSVBmedP+fvwIJxzAYmeUjLspARXXu1jKxkXVE1NmUi+wek2eX4ePNMWY0yjQclztDW6c3gMmFXp7730alLofMX2yTMlJxmzRLHvCt52sQAk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763475027; c=relaxed/simple;
	bh=6OVACKT70lnEsj51hxCCmjqkx79J9EvLlVDr9mku7Ho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=H6oAOFPP6skR7QJWWQJMG/V8raXBZessS4+aNw8fCTROdWrF0YeDflO0XcTYnoEARhg1MBwJHGiuX5PIFZ/6PcUPg1HfyYA6IwRHwqkUxiP+IgSnm1AFGLwU3/sJ3H4bIzEKZmvVAOeEH3zdauynvTn/2gnd+hy7nOAxeXc1j+M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D21533857359
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iiiS14oH
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20251118141025192.WNZB.47226.HP-Z230@nifty.com>;
          Tue, 18 Nov 2025 23:10:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2 2/2] Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.
Date: Tue, 18 Nov 2025 23:09:35 +0900
Message-ID: <20251118140943.7357-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118140943.7357-1-takashi.yano@nifty.ne.jp>
References: <20251118140943.7357-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763475025;
 bh=vbximSR2ONOAD381M76/59SdV6GqZ6HFCPCr4p8MLWA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iiiS14oH5VXCJ7/3TFNiNbZljE8oqUZMaNs3WsZDP48jV6QicokIjecIqYsYjcpELQ7rmhlZ
 PScF1F39aFlODu640QF1EIE65n5q+VVcnivqKtxVoJoq7jVPcbhzfUfvsX+RYGgRfvs32YOEhq
 plQjhUpQb1TAI2VXUK1n9qYJHwVLBqyFXCA5VkyQbte3G+Lc5vjNsXe3vLgDeW05pNBP6xqDaM
 L1j5rfGhwgBIeLcvhKaGPwN5Kj0hebw7BB9etnRoDgMC/Twrfg1lXtlaS+JablzqPL49s3MOcO
 AbMFo8KCU/0X2GLTEVT8vAWmYpVr0fheGg07Ct/kr8KMrrQA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dll_init.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 5ef0fa875..e26457a69 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -612,9 +612,10 @@ dll_list::init ()
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


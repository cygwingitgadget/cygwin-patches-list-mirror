Return-Path: <SRS0=Vzu2=CG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 062F54BA5439
	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2026 10:30:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 062F54BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 062F54BA5439
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775557833; cv=none;
	b=df5fCLu4XP+x/S9120cI/wNknrbJVjTEeRZLda9tYwtYINL9XPQuf+c5CwzCPy6xmYXKp8f6FeK1QGc48L0chIB1cD9O/hpMUFqEGvm6qoT7E90+GRB/c23ixbQ8VR8+gSc0chNzIUbQJnxBhout0mEg50EKtYUsnWauvjH0iwU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775557833; c=relaxed/simple;
	bh=YuDo/2OS8NbPxtI3aq/kkgS92Mn94GQnkMqehGT9iWs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=RZA45FiQL+8FPBNPRFyNeg+tbkkd1gpkqkT/v7zup9ezI175TKT2n1nEc1ghmYXoICcWNCuryeBaAlwq47wG2PO1L/+kDU4Qhct87W2UN34Pil2p3XXTea0a88OUdr7GWWXfdLwXbUH0ZIVf/ZRsn2olev75pe4HbF5iaVNG0lA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 062F54BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YDODZ68p
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260407103029490.DNQX.58584.HP-Z230@nifty.com>;
          Tue, 7 Apr 2026 19:30:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Cygwin: pty: Add missing DeleteProcThreadAttributeList() call
Date: Tue,  7 Apr 2026 19:30:13 +0900
Message-ID: <20260407103022.1380-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1775557829;
 bh=8vGLerTkz+3sYVH1LivgqkSDXV0jAh+5BEoV6LLi2hc=;
 h=From:To:Cc:Subject:Date;
 b=YDODZ68pbKE4TlJYqc2pd8Qn6oJkKPSio92mK3KIvng/+DT2zxQAgQutHACgPX4gD32cBzax
 NhMog7lXbsVeEj9K/yJ0XW5gydsOpU/9cDRow/Tb4BGIvUbNunIRgEjnusrVSTMjTjBfZUJWxF
 ChwS+GhtTRXIV0YdKM5RY8ciU2tS2rOmuRutiZ48rnYar+Av+eVrxprnlPeNyutO6jTdvSc+5i
 yTUGdHvqxKlredeK0uFHr5qUu3NxMYMInsj4Tyh8sATihmIJpHdcje4smZYDmMV+hTjVMuC5I2
 isTGR9s3/x7e/MGT+MXnrO28oT+JslrmvMBgCZxGyhTpDt+A==
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENA_SUBJ_ODD_CASE,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, the cleanup path of setup_pseudoconsole() is missing
DeleteProcThreadAttributeList() call, while microsoft's document
requires that and the normal path has it.
https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-initializeprocthreadattributelist

This patch adds DeleteProcThreadAttributeList() call to the cleanup
path.

Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index e9191aaad..cdfb363c9 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3730,7 +3730,7 @@ fhandler_pty_slave::setup_pseudoconsole ()
 				      PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
 				      hpcon, sizeof (hpcon), NULL, NULL))
 
-	goto cleanup_heap;
+	goto cleanup_proc_thread_attr;
 
       hello = CreateEvent (&sec_none, true, false, NULL);
       goodbye = CreateEvent (&sec_none, true, false, NULL);
@@ -3899,6 +3899,8 @@ skip_close_hello:
   CloseHandle (goodbye);
   CloseHandle (hr);
   CloseHandle (hw);
+cleanup_proc_thread_attr:
+  DeleteProcThreadAttributeList (si.lpAttributeList);
 cleanup_heap:
   HeapFree (GetProcessHeap (), 0, si.lpAttributeList);
 cleanup_pseudo_console:
-- 
2.51.0


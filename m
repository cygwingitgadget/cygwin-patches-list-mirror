Return-Path: <SRS0=ItNv=G4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 03F8D4BA2E24
	for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2026 01:24:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 03F8D4BA2E24
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 03F8D4BA2E24
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788485071; cv=none;
	b=sqwHKLM9II1kLP0YyFSHMgjyvDb52+9vSc4yJrhC6XWDW3xfc+cbwoQ3HH+7QQxCYhZ2dlFtfVWLKEYsXMsPd50qIl3SxieKEPC2VbZjmzwaS6BBuj6sN8nOYq4pJbqtFDIOPXORbDy28TKj8c4ognjC6SuV8A7Znk9Tx/eKYqw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788485071; c=relaxed/simple;
	bh=Fz26JyXZHnzZO4L81sO74P6ugTmpY3G/KXvSjF/yPWc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=L4suhdtc4FolsP61jXF5RZI5WCDU8lTLFpInPm2/G+OShBaIq195JaYn1zUMoPGqYNdljYmB6ZQXKlqExuB7El+l03SvSQduTd4SpnGpWxQibLMLMb5+UIHguCbWn0SUAVIysB9VqUobmaO7ZyC25oyfcUoAk5ICZmYcQqYGJHk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kVMI97qj
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03F8D4BA2E24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kVMI97qj
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260904012427294.DILT.102121.HP-Z230@nifty.com>;
          Fri, 4 Sep 2026 10:24:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: proc: Fix loadavg calculation
Date: Fri,  4 Sep 2026 10:24:12 +0900
Message-ID: <20260904012420.456-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788485067;
 bh=Jdld6JZxm/cDUKt3WfxvjY7Sm6Gaj4w139jXJQ7NMGM=;
 h=From:To:Cc:Subject:Date;
 b=kVMI97qjTth76+zUG7Oc6hjuS0Mgg4vqGCZLvamngXWWuSUuA6Y0CpLS5OIqNEk6hwJlFDZe
 VNZ8qsHLHczE1VQpsnYGB9GTyKBLSo+7FLGE6ScMkzv88SGh/gH8rcz9T4GOoWXZKmx0EJpqq2
 Qb78FGIWPDH0ZoGaYSsNQKu/XgcffQtO3PqkpRMpNvzKrjg8ae7YAUcA/kRj7chAFXFRsKFPbZ
 7/ds/GT3QkCeUhvpMVj/HQlz5BLtmNaklpRwgNvYbWb/+MHvIlqmny58H7dhHDAryVJhHo05jc
 NCZmVjX7c/xBoOYUrxWToxp6N4QMSXZlluGZtbnDUUULLUpA==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, format_proc_loadavg() wrongly passed an argument `i` to
get_process_state(). This should be windows process ID (pids[i]->
dwProcessId). This patch fix that.

Fixes: 9ca65531e0ed ("* fhandler_proc.cc (format_proc_loadavg): Add running/total processes as fourth component of output.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/proc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index f1cd468fc..af3cfdb16 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -442,7 +442,7 @@ format_proc_loadavg (void *, char *&destbuf)
   winpids pids ((DWORD) 0);
 
   for (unsigned i = 0; i < pids.npids; i++)
-    switch (get_process_state (i)) {
+    switch (get_process_state (pids[i]->dwProcessId)) {
       case 'O':
       case 'R':
 	running++;
-- 
2.51.0


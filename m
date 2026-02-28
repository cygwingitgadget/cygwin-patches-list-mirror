Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 1E0214BA23C2
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:02:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1E0214BA23C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1E0214BA23C2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269349; cv=none;
	b=v8AO1y2p1GBqJG90mUUMsIY7Ob3K/82X/SwpbnWIcxdpHlaGSQP++MbvYeqkEQdg9GBSncqtBhAASel3YclUHxdwEmNzIsrujLpIP66qfybTjEWsGt4hewxYtlNWBKSj8EqWFJDLOXhaxkBM4PdubEp5Cgpzt5Gqc7JNuviXiYw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269349; c=relaxed/simple;
	bh=ZulNbI+qVsXBjSBXJHzLz7iuCTAqRmpmuEzvFXggXFI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=UsE0MDW0WzTl+QhDpSqeCdbykl9B3vjPUOWqmI66Q1YDJwxLobD9n4D2ZG6U8/LqAykFHrf9H+oE5iK+3kPe9bfiJNquz1RHVuoAAHV6DSSHQYnd+flEDAvQ/qseiZnOLHgVX5zZgYbtFNB2kZA3ww33FwKMfu0JaR8RQs5+WDQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1E0214BA23C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tfgjONQc
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260228090227155.QBIZ.58584.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:02:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Use consistently first pty slave found in cygheap_fdenum
Date: Sat, 28 Feb 2026 18:02:10 +0900
Message-ID: <20260228090219.2551-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269347;
 bh=aykLj4HXqUdb9qUmRWSpweZ6g4mjv7LrHUqND/myxmk=;
 h=From:To:Cc:Subject:Date;
 b=tfgjONQc8L9ti1sKHPrlOtGNUj4ipQuBKGWu7M3gMYqj/D3gbVlKAk/IZHq0eDCMYkBTs0mI
 pLvGKG5FhVZasUWN0sssvyyufWgKQArIhAv/OrvoNpcVmowVcByGIgegvO/wf8fZPBMDfc7IzA
 11CyR/pPq1JlafnH+Mc7DxUrHZGl/SKvtYRLhpMqmjFSK0ROjh7BT4m+V64QZ1OJG1JoaYjD7K
 RUNG3zr0jn2gEQPV01LSXS/hIhsWIw6xw+Msd8Tk+QY152xgyQQbiBoS6JLktSdFcmad3mSVhc
 TgNAxR1Wpa1lcon3P4KRUluMJ8Z1A5JfW2aS4BomslhEnNLA==
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If non-cygwin app is started in GDB and terminating it normally,
re-running the non-cygwin app might fail in setup_pseudoconsole().
This is because set_switch_to_nat_pipe() uses the last pty slave
instance found in cygheap_fdenum while the clearnup uses the first
pty salve.

With this patch, the first pty slave instance in cygheap_fdenum is
used for setup and cleanup consistently.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 663b0068a..d4b2896e1 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -105,7 +105,7 @@ set_switch_to_nat_pipe (HANDLE *in, HANDLE *out, HANDLE *err)
       if (*err == cfd->get_output_handle () ||
 	  (fd == 2 && *err == GetStdHandle (STD_ERROR_HANDLE)))
 	replace_err = (fhandler_base *) cfd;
-      if (cfd->get_device () == (dev_t) myself->ctty)
+      if (ptys == NULL && cfd->get_device () == (dev_t) myself->ctty)
 	{
 	  fhandler_base *fh = cfd;
 	  if (*in == fh->get_handle ()
-- 
2.51.0


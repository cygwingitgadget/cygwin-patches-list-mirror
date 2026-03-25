Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 1F0DC4BBC082
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:09:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1F0DC4BBC082
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1F0DC4BBC082
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774444174; cv=none;
	b=vQsO8ss3mAPatY8d0Rl8WZKGwNgz+gbKFgCfFdym5moXJ/Z2r2ycm0+X+/H+puv/cSQ7PUg/Wr3XR1hOI7Uo8Mhn7LnvQcAIHPrcO3Q6PR3TVelfJPYXPrsxpeGLpw6uiCim6Z+eB0Fsx/rvA1DzJUCzvbWDrv15ogeenIjxMLo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774444174; c=relaxed/simple;
	bh=Jm7m+Uv0Wv072lLiq7ahzKCD62kNYTOHjD9GP2J0Vao=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=q6Gbsol5J/cvgjXvLGqFgmqVhQYxoAIJdUaHLttf+5xqNVvAeJoQeWhe6E7Nxjd/KAn76PxS5EKTX1tqsN1oFZ/hj8CiVVDcrbcTVBhP3s0WUGUF3WUXj+hqW4iH6VyjqXjOV3J3KVr0Nkmssr0r/ih8NxEirjSRoTU/6Oilr6k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F0DC4BBC082
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ID+/lxQG
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325130932079.TVEJ.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:09:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Make pcon_start handling more multi thread durable
Date: Wed, 25 Mar 2026 22:09:05 +0900
Message-ID: <20260325130917.68025-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774444172;
 bh=xY7Q1l/eYeErCwDK3HQzgP0Xadfh2KE1L76bfmMIXU0=;
 h=From:To:Cc:Subject:Date;
 b=ID+/lxQGnCv1qFwS0esez8L0EBiFRzctZjm7pjJUVNM9n0QeKpw6ZlJ7sGBfu6pNJxPpGhRO
 GQ070/1nCnYtjsWGh3O51b/HOitDgZKSZTpyI5wvYpTOUx0jOInMa530XNfI0F5XiuwmrBI++G
 UN8p/unQzjaar/8WiVGZO0cCr4EVNhifavfCwSOHMzd6kmWaL9hQXeZ0uf5WOjo8mzTmYxIasD
 PDSMxKyCaMaz/PN/N+lsv86kdcc7MPndVAxdy9OG4jXexedNBEwgt35mRyktNdGNfOlcwQwsFU
 t4voDmQzF3pSb/WvosUhB1D/9VdldE7x1YdO/TbH5eLSLTUw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, if the CSI6n response is devided into "CSI10;2" and "R",
and another thread call master write() with "c", the data written to
nat pipe will be interleaved like "CSI10;2cR". The first "CSI10;2"
make the 'state' 1, and in state == 1, all the data written goes
to 'wpbuf[]'. This may break statup of pseudo console.

With this patch, the thread ID of the thread that write the first ESC
char to 'wpbuf[]' is stored in 'wp_tid', and only if the thread ID
matches 'wp_tid' will be written to 'wpbuf[]'.

Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 8e6fb9c23..dda892269 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2230,6 +2230,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       static char wpbuf[wpbuf_len];
       static int ixput = 0;
       static int state = 0;
+      static DWORD wp_tid = 0;
 
       DWORD n;
       WaitForSingleObject (input_mutex, mutex_timeout);
@@ -2242,8 +2243,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 		line_edit (wpbuf, ixput, ti, &ret);
 	      ixput = 0;
 	      state = 1;
+	      wp_tid = _my_tls.thread_id;
 	    }
-	  if (state == 1)
+	  if (state == 1 && wp_tid == _my_tls.thread_id)
 	    {
 	      if (ixput < wpbuf_len)
 		wpbuf[ixput++] = p[i];
@@ -2259,7 +2261,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    line_edit (p + i, 1, ti, &ret);
 	  len = orig_len - i - 1;
 	  ptr = p + i + 1;
-	  if (state == 1 && p[i] == 'R')
+	  if (state == 1 && wp_tid == _my_tls.thread_id && p[i] == 'R')
 	    state = 2;
 	  if (state == 2)
 	    {
-- 
2.51.0


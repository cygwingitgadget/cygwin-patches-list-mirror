Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 34A624BB5939
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:08:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 34A624BB5939
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 34A624BB5939
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774444134; cv=none;
	b=moe30p90sMD76Zy4TqiRxFTJIvi7ZBQKpsL8bg9/L/RC1/QsoUrxYrsgmT9NeppQKdOvrFHTDxdVw0vZOBexpZG2FVqBE1qSfxpv0dRCbx335USyU9hAP8pT8d9vUqDMsU4caRrvuRsMY3v93Fn9FzoVnseRh9qfL0GcewL0bOc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774444134; c=relaxed/simple;
	bh=wvWw2BxXicaL3etVIlnBkUmtwcEYTKxaWmvd0Kh6jY8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=lX7HA/hNLaGKrkrHtrB4TFATUuQxxIScD3GaW6eHyChKD2g/+Y+c9/RUa+bVnw2++b9fjmrDm4jO8XqiyWkR+/98OnjKegQllaN/9wfvDGnP8gRT15TvcoZ7dnUcPXvUWdA2z4WE+oWdaj35WheRJhzCfVSYGetHiU5A6XHTG9g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 34A624BB5939
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S7PcvRNt
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260325130852201.XFRA.19957.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:08:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix write data handling in pcon_start phase
Date: Wed, 25 Mar 2026 22:08:32 +0900
Message-ID: <20260325130842.67319-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774444132;
 bh=a/o9UIBVB8Js/AQ4hXbxiUaJdaRTSoDBHyIpPID7W6Y=;
 h=From:To:Cc:Subject:Date;
 b=S7PcvRNtEJOBCB/fKSLi3eKZebQYihQBkrpMF4ZO2gPHL9nrV7UJZKN35Od83KBRJ/tSLn2M
 5c0bDyUZFxeheqjJJGgN+U7DxblksBJ8nhRrwSFeaHSHJ3F9mk9oFoLU/LpCE8vQUd0dOXC4Ml
 y1VTLQ0MnmIjZY3ESXAKK0kzvevx//NI25wwFkSR7VtJYJ5sissivGoNkEMuDksJJDy9tUQsIT
 SNRQfQZGhFJoERal4P9djutk711upR9syBIlFk5fMxaWYExQwWMy6xMmLFt14mPQQJs6zS3MPF
 MBw3/DdsnDL8jOh82LH+KT3AWkYPYCYWIZZNgIzqYn/WT6+w==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the 'for' loop in pcon_start handling in master write() does not
break, 'ptr' and 'len' loose the chance to fixup the value. In this
case, all data in 'ptr' are processed, so the 'len' should be 0.
1 byte is consistently consumed in each iteration in the 'for' loop,
so this patch fixups 'ptr' and 'len' in every iterations instead of
fixing-up at break.

Fixes: 9d7440036580 ("Cygwin: pty: Fix handling of data after CSI6n response")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 098c72f72..8e6fb9c23 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2257,6 +2257,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	  else
 	    line_edit (p + i, 1, ti, &ret);
+	  len = orig_len - i - 1;
+	  ptr = p + i + 1;
 	  if (state == 1 && p[i] == 'R')
 	    state = 2;
 	  if (state == 2)
@@ -2266,8 +2268,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 		 the response sequence should not be written. */
 	      if (!get_ttyp ()->req_xfer_input)
 		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
-	      len = orig_len - i - 1;
-	      ptr = p + i + 1;
 	      ixput = 0;
 	      state = 0;
 	      get_ttyp ()->req_xfer_input = false;
-- 
2.51.0


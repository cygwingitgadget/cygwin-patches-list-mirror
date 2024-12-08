Return-Path: <SRS0=4MnB=TB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 989633858D34
	for <cygwin-patches@cygwin.com>; Sun,  8 Dec 2024 13:35:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 989633858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 989633858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733664956; cv=none;
	b=AmzpjogL+vSVnIgP1/rfMo6gR+Mk1s/VD95iFDMxh7xGbihTSBeo/ChKkVlAn390yNORIAS2WEB2A/ccXyNNy3olkrLdH+2AJ1XZStj5XMgJH7ecfIIvpHR/vJgCsJzfjn8d0TPBBWXHdHTSeCBpmFgrhGUVzvQGOdOd90YGPvY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733664956; c=relaxed/simple;
	bh=WsdqOtQIptjR//5UcpURn5BZtlPGW3pB4jurUhcGbDs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=gl9Q9lJ4WDV6DiUHdH8lxNB0VywARi9RZ0bTJK8fpMZSbVWYFtpd43NoL2av7oa0uD15c5YsXH/jziyZ8vngUoyJtL4N6C/MI0NA78cdvUtIoZ6pXJG8Cqms3+wO6bnEYuLZThDAVbFnfsmfA1P0CgV10JhGE/X2OZ5kWUYbHlQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 989633858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dXifBgdn
Received: from localhost.localdomain by mta-snd-e10.mail.nifty.com
          with ESMTP
          id <20241208133552250.ICNW.33191.localhost.localdomain@nifty.com>;
          Sun, 8 Dec 2024 22:35:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Ignore intermediate byte in CSI sequence
Date: Sun,  8 Dec 2024 22:35:19 +0900
Message-ID: <20241208133531.1450-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733664952;
 bh=O16mxvSoSgBGONojOBKg67AHqBCWFr6FTTlbX8KTV+Q=;
 h=From:To:Cc:Subject:Date;
 b=dXifBgdncLQydb/srVIcoCntS33KsYqw0fEtc6A/Dhd7LZcEpmGEfQ5bqBMCgVVvXhn0qMkk
 pg6H6KfoDesIb61p3xnSARW31RBD5KI6HiGirm1pcBpCN+fipJUFg9WTq7crOnN38zezVtp39E
 u3zqCtDO00v7wpJCHvSWEYurI5zTaF+r/p90Js7ZRfKDzznUx2LexHQvrtRVAtT2Puxv0pw+E9
 TBV5CQaPCGQYtITjXv6yNwcLIxxqyBOh0Ngk1OxVLDe0OYdv+OG0Rh0aO+MJ+d+tYUC4BQRovW
 IQLJSPLVs5Sl4TjRqZLKRYsle1PZB39YcObK5NZK0ySdwvoA==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Recent vim throughs the sequence CSI '0%m' that cannot be handled
appropriately by psuedo console for a test purpose. This patch
removes the intermediate byte ('%') from the sequence.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 0660ee305..c6c261420 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -4024,6 +4024,11 @@ fhandler_console::write (const void *vsrc, size_t len)
 	case gotcommand:
 	  if (con.nargs < MAXARGS)
 	    con.nargs++;
+	  if (*src == '%' && con.nargs == 1 && con.args[0] == 0)
+	    { /* Ignore intermediate byte in CSI sequence used by vim. */
+	      src++;
+	      break;
+	    }
 	  char_command (*src++);
 	  con.state = normal;
 	  wpbuf.empty();
-- 
2.45.1


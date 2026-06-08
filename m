Return-Path: <SRS0=N3FD=EE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2a])
	by sourceware.org (Postfix) with ESMTPS id 97E594B196AD
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 13:34:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 97E594B196AD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 97E594B196AD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780925668; cv=none;
	b=frT0qN1kvkEra88ZK8MTTbkHWk5biFSeCFTDoTeKBBdyKmYJ7dHFVnquiit60u88xuL3LdJ4jQDf3sKTRnC+mHJyZJxeZuLvdG8Hox6+f+YO3u4xmotjZcjOCWSBlUOG+lD4Yl3obW5DOgEHxa/vAUNeCgW7RyjfshMzk+FFtf0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780925668; c=relaxed/simple;
	bh=pV90GYUyWFsCWxOTkQyPly5qd49Q4kbMrhYUXz1Z8cg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=RiNQLOU07KWeOGtUlS5xaQhdXo3qMmcYu1D4hwzFC/rLmoOWxu2qZMR7L8vPfl8TElQ0noLgl0rL/7wl5y+LFYY5aZdgJyDIOSnDqyCs5oDYhYdCnuFLwaFVkUqOHfmvotsHBCkBRhBjGDj5bFUTfgr0xzJDiD3SJxCWsGrc2hQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=BIB+tcYc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 97E594B196AD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=BIB+tcYc
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260608133422378.OOEK.3198.HP-Z230@nifty.com>;
          Mon, 8 Jun 2026 22:34:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Koichi Murase <myoga.murase@gmail.com>
Subject: [PATCH] Cygwin: pty: Do not set input_available_event when applying line_edit()
Date: Mon,  8 Jun 2026 22:34:06 +0900
Message-ID: <20260608133414.1979-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780925662;
 bh=JBdxzu6E2DzqMJeC4672yp2R8mYMihKQG8/XK96Wwu0=;
 h=From:To:Cc:Subject:Date;
 b=BIB+tcYcVkWyf0eI30/lYzc639loGtvDL64QgL+w43KJSvT9BOtw4/2Z0p2BV/trU+vBNMNz
 cjVoxio0E0qVW3v4YohsMPwLA/FtTyVeHkKXkZfB+koROgqjqvw8zrPnfJCGNy0Ife1f2DEYpg
 iqcglHJHhMLTJBbIFudsAfLPIk8rRAQq3YEFpUYjrQDLnpeh6+dZj2TgY3CbZ0y+96P8r2douA
 bR9k1GGIpyMBLVB6KZEL6wUbvKWrAUh5XaVADekrMxHkCCY7e1BeaMuTJ46dRXyAAvoTbi9Coj
 WLXx0RGXe//zkB9ok+FjkSBJ8P468mG5Q7eG+OtfK6katU2Q==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit a0b38a81b9be sets input_available_event even if the
transferred input is still in the readahead buffer and is not ready
to read. The SetEvent() is called in accept_input() via line_edit(),
so setting this event here is not correct. This causes the issue
that read() returns 0 instead of blocking until accept_input() is
called. This patch removes this SetEvent() call.

Fixes: a0b38a81b9be ("Cygwin: pty: Apply line_edit() for transferred input to to_cyg")
Addresses: https://cygwin.com/pipermail/cygwin/2026-June/259776.html
Reported-by: Koichi Murase <myoga.murase@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 80331c36d..2558fa799 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2946,7 +2946,6 @@ fhandler_pty_master::apply_line_edit_to_transferred_input ()
       n -= ret;
       p += ret;
     }
-  SetEvent (input_available_event);
 }
 
 static DWORD
-- 
2.51.0


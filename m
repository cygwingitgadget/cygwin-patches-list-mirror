Return-Path: <SRS0=Wk1n=CQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id F11AD4CCCA07
	for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2026 19:45:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F11AD4CCCA07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F11AD4CCCA07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776455141; cv=none;
	b=IdftKZU5+B+eELbipQX+pJtKNac75M6hMF7TXkw5dOdTEmiH3xqMwX5jaTM39in23IPRnIL87Re+L0FQYGuHdzjUBBmcGNmCuIf/k2dOSAqAL/8WxNcLspfwUoIMG/i/5zIdMLMHIK2vrpPRXjXG/nGxF33aTHzQ+amzP4WpEZA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776455141; c=relaxed/simple;
	bh=u3umhfL1Dm+mQvm38u++u3zRkYSOisBXgQKiv4BjKEc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=H25jRAQAE9Au/vlX80dNvaMDTVSK2FROONbAq38xBNta0gbM3l8U7hT6PDtnMOJiLAuA/fazoh65/iAyCUQtfGpvgRN+Xs7idQn1F10reJaQ9y5qqPfbEGUDvCmKt8Uun50Hlofif4EVqvM0ogYZmlSQI4IRlzOI1SmWVNkhBNU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F11AD4CCCA07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RKAbH8zI
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260417194537084.CRSV.36235.HP-Z230@nifty.com>;
          Sat, 18 Apr 2026 04:45:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Nahor <nahor.j+cygwin@gmail.com>
Subject: [PATCH] Cygwin: select: Set errno when peek() returns -1
Date: Sat, 18 Apr 2026 04:45:22 +0900
Message-ID: <20260417194531.993-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776455137;
 bh=rBKDcpl197O5eMIt97gnMZHw9qPeeIsvfVrrN6PHabo=;
 h=From:To:Cc:Subject:Date;
 b=RKAbH8zI5S2xaJAPyiTDFreAHHIq25yr6nPKVHyck/hZqEzb0x+MKdrKtQIcI2wUf2nTKYy5
 5wjwQa7glZHYS67wATb/wfkE8RAsJNLLnAZessNVFuGQgy6IGBl7eEeTbtcQnEyDG/625b+pJM
 5vpa6rU4k0K43QEsCLYPwWB62kNxuuzYltKv2Yu0ZoheMrR0UpMznyMu0stxWyXU1p8NJ+wVDo
 V5TxN8as8s9OlTUFsgWvJINlwagRP3j+E3Q6KBNgl/e3o50VMG0u8FLo1KqnQOta9wd3ti4iyk
 pzTIdxPSJSjVblFp/EESe4zL+jcOyg971L7u85GBjVWutLXw==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, poll() sometimes returns -1 with errno == 0 if the fd is
not opened. This is due to lack of setting errno when peek() fails.
This patch ensure to set errno to thread_errno if peek() returns
NULL.

Addresses: https://cygwin.com/pipermail/cygwin/2026-April/259602.html
Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
Reported-by: Nahor <nahor.j+cygwin@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/select.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 8a94ac076..523c46ee6 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -561,7 +561,10 @@ select_stuff::poll (fd_set *readfds, fd_set *writefds, fd_set *exceptfds)
     {
       int ret = s->peek ? s->peek (s, true) : 1;
       if (ret < 0)
-	return -1;
+	{
+	  set_errno (s->thread_errno);
+	  return -1;
+	}
       n += (ret > 0) ?  set_bits (s, readfds, writefds, exceptfds) : 0;
     }
   return n;
-- 
2.51.0


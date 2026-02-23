Return-Path: <SRS0=vXQ3=A3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:21])
	by sourceware.org (Postfix) with ESMTPS id 62FA34BA2E16
	for <cygwin-patches@cygwin.com>; Mon, 23 Feb 2026 08:01:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 62FA34BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 62FA34BA2E16
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771833712; cv=none;
	b=qAAPBwB34fwrRNoGVrjBzm/vp/R+4LEA8BEaPDQXcEN2Jrlv1Evft2dAZzyIgCAqubURNLYWjoHytPMigCXDtQ14zdUQBLNHe2DniX6Ja092RiwAaC83QzvqpXSYSK3uDjULPtlxPkIJuissiCEM926Iz1ADl2Rtb0TBP0fwXdY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771833712; c=relaxed/simple;
	bh=sK+n3DCiNQzoI513expGr4fchLx0FVAsXhEW3c2to2s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=rhDjm7tDS9OaffhV99/Q99k399EFr5DcpGl+PeOm0WoEV756r6Txr1IYcYSgfe590vVPhQXJ6vvcL4u995tfYh34i9+xT8bUO2bOM1HAVmBh14i6v8OjI7OeX74fzRWKujRh7ptBwIQa364BibPc+ZtA9+XjeFcHyOcxwAbFPtQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 62FA34BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nkxRI5mB
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20260223080149567.UFTL.48098.HP-Z230@nifty.com>;
          Mon, 23 Feb 2026 17:01:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/4] Add support for OpenConsole.exe
Date: Mon, 23 Feb 2026 17:01:26 +0900
Message-ID: <20260223080141.340-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771833709;
 bh=Xd5Ip3CbCz/9PbDioohtxkNtauSzK6xZwYImfJM6hZA=;
 h=From:To:Cc:Subject:Date;
 b=nkxRI5mBFeL3BevPDzVSLbxl6DmrRFav4AWkeD0/W5HAwlF4jd0/ES4JLqSzdH2UWzHXEEFn
 gjx16xxebGYe5lrhtEpGO1wvMaApv2RHYsQn7UIb3u0rp29gpLWVS40LfbtYUu+uMWMEd5I64h
 2gFSnMQJcfwaDdDbVsc/qq87riPXpVzedknTP7194q//cOWXbDVoebTRORkDYrafzuHJeyf1ki
 Tl/+hQl2fHwjX3A8tJn5aWv/ZXEXIfPSS8MasmnaFuLl7EOSAAvwefq4xqruo7lA7RimsM/pYI
 fKUaGgslxLJ3FHCnJdESGZgQBFCAGNHyHCISxCm5syEYsTrg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v3: Split the bug-fix part of "Cygwin: pty: Use OpenConsole.exe if available"
    into a separate patch.

Takashi Yano (4):
  Cygwin: pty: Use OpenConsole.exe if available
  Cygwin: pty: Update workaround for rlwrap for pseudo console
  Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
  Cygwin: pty: Fix the terminal state after leaving pcon

 winsup/cygwin/fhandler/pty.cc | 322 +++++++++++++++++++++++++++++++---
 1 file changed, 302 insertions(+), 20 deletions(-)

-- 
2.51.0


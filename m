Return-Path: <SRS0=/go4=AY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 343FA4B9DB40
	for <cygwin-patches@cygwin.com>; Fri, 20 Feb 2026 17:19:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 343FA4B9DB40
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 343FA4B9DB40
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771607985; cv=none;
	b=MYsz3wyl3ZA3B8IjoOvy1p8GdLtAu8wsqtly93LXmV9VJdeWGPrV5DQ2F4W0sr9WxrgWzO+Q/VPkC8aqUudrqHaeC2QCNwcAU003eQBQyB7kdGieQWOPT/1VWFnMt4R4TaxJmJVCr06BxZ03DTCV2zfxNipQb+rirm1E4E76KRc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771607985; c=relaxed/simple;
	bh=/wVcdSzZ0N4qWBv9cu3KNYd1NGg/5IH3yGUd2sJXeW8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=wPksj68y8YC38FLyyEfAHapYULT2kYSoAuvyO/QX6TNP7e1oQtl3lCoWXR7tnTb0buNN7EYWQpd1xsTES6uv1rpkVTef5qlJYNXKqdS+ZqvnK6jP+dHppJ/zOmiQ19moHJ3ToYO8fAUNLvgqT5b93YEBCAHuIK9cPRBKWsKdOhk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 343FA4B9DB40
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WQS+61Vt
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260220171943287.HPMW.50988.HP-Z230@nifty.com>;
          Sat, 21 Feb 2026 02:19:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/4] Add support for OpenCOnsole.exe
Date: Sat, 21 Feb 2026 02:19:11 +0900
Message-ID: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771607983;
 bh=6wgEWsD85Xn1ae8OFTo0x//gaf4LNDLEj1sKJg67cKM=;
 h=From:To:Cc:Subject:Date;
 b=WQS+61VtNX3jATtEXvk/rySdp3BxBZeQ4OZkn8DenEYMBR+WStDoBlyK8RwAHW/w//TGLy2w
 8fT+cpQf+Z/3Ks1ZS5oVc+zSv1LtVLo4sM2NNlNwWgnP0sQfXFZTsZHoDmx63xCcRE9EazACe3
 kYvkoCwDSxhHaf6nQyAx0DSKbA75iwFuwjpXiAKd0/NhOtaViVbnarmFS9Blv4NNTRY/kcvdxG
 A5lWFK6Cp8W50EIKtjCLASFhjz1rnsah0nejZPgAEBAbIpEPN8pZPdNOb5090MJ8B1bAwGLx/W
 /rRwK2Z1t4UJ1CPaPmQSINTc1P2jTQfgAM0bAumfDNoB9jMA==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2: Revise "Cygwin: pty: Fix the terminal state after leaving pcon"

Takashi Yano (4):
  Cygwin: pty: Use OpenConsole.exe if available
  Cygwin: pty: Update workaround for rlwrap for pseudo console
  Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
  Cygwin: pty: Fix the terminal state after leaving pcon

 winsup/cygwin/fhandler/pty.cc | 372 ++++++++++++++++++++++++++++++----
 1 file changed, 332 insertions(+), 40 deletions(-)

-- 
2.51.0


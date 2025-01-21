Return-Path: <SRS0=jwxA=UN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id 2977B3858D28
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 03:16:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2977B3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2977B3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737429370; cv=none;
	b=dCpMkwBTSGKUf/5baspcYa/rZdBXupt/G28+i1jRPIQz1e7iVaV9UIcrpWLQUCIbCPCEvGUbwF2zCDh6mEF6/JEHNeevYk4FxefThKh3Z/rYAtx8e+rW9UaS4587QVtGYyKK2U6ivtzqYs61y/NVyQkzV7LwAPuOXNBWTcUbDto=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737429370; c=relaxed/simple;
	bh=kmJdWpb9/7ni/oigm9y9hLQ/zgDQtbM9VE/JbK1dIHI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=K7103TnACFazNBC7bfeYhQERiWOPvlX0eGiOhaEUwY5wCyRzrmTX/P2mP5G5WoiSi351GdH88Xc5tYv5oJciFJ7OOfGkd6pIPX6sw8fxuCmiD3ltgv5/8Wyf9U7EVobhgd7cIBMOblGridqz206DBNiHyffTkKrNLvcId9GIvfw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2977B3858D28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NepEWxWz
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20250121031606564.PDUR.44461.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 12:16:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 0/3] Revert __SIGFLUSHFAST v2 patch and apply v6
Date: Tue, 21 Jan 2025 12:15:32 +0900
Message-ID: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737429366;
 bh=fv0weUa6SnHx6H8UoSfw165dlvxa1fpc/U9t1gG988s=;
 h=From:To:Cc:Subject:Date;
 b=NepEWxWzPdJtt08eAGiuoWMD5HZfj/5tgmM4KeTYI1Du/tCDc0UzpOsdFW+5YAarPdc5bHFM
 RiZMr+zXi4O9f9HVx9m6mUU9fGBMIEF3Tn9YJzbjyVIpbTKcIQdwwix51TwxH/sL4XKUHqLJz/
 Jqj9UCep5SbSRFRLI4FUcC34/Ntvv9JO4gW9nf89wOExKMpPEPyT/HzkC6mxQtAHMo0xSupNID
 gVYJwCon7Myc+wz38C3V8DaPK3sgEIw05A/Uhf/1dIJi7bsulQ+NBKwaTOL1iOwuFo+lOTMtRs
 FzZMUfCInRVsuF6lbx6IkmVQQ2V2LRdiiPXvoAZNR0BPhwIA==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v5 -> v6:
  Revise cygwait()/select() a bit

Takashi Yano (3):
  Revert "Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is
    sent"
  Cygwin: cygwait: Make cygwait() reentrant
  Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent

 winsup/cygwin/cygtls.cc               |  2 ++
 winsup/cygwin/cygwait.cc              | 22 +++++++++++++++-------
 winsup/cygwin/local_includes/cygtls.h |  3 ++-
 winsup/cygwin/release/3.5.6           |  3 ---
 winsup/cygwin/select.cc               | 10 +++++++++-
 winsup/cygwin/sigproc.cc              | 24 ++++++++----------------
 6 files changed, 36 insertions(+), 28 deletions(-)

-- 
2.45.1


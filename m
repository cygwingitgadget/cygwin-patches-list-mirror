Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 77E133858429
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 15:46:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 77E133858429
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 77E133858429
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737388007; cv=none;
	b=cqv6DcGRYO59qF7hyqEcvBkiX2HuKoFXPIe2bIpLZE406vsqJgZ2rxn2FKPlfJSGECEGjM3a2u0McvFiiBhvVyD72BAu5dGFWghnuKOQPOqTvPs3t5PFRlyhr0k9Jcfxtl6/M5sGrOp2YFA6ff9dDJa0aYazk/yITfeuDgANLik=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737388007; c=relaxed/simple;
	bh=pUgKlLWZCC7/Uaag7bAJ7T6Ae+vdSdAM6zVeI1OWrvo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=JreYdmWgW1yvLl/LloCWUFRWoHpLl259z5vP+ZixCZfm1NtXdfln3RBuE33shsFHsK9Xfpt3gEibR8zHUuORSPQYRTw3izygWSZ8k0aITpoAHQzAoPOKCj8eC9bf5dlqomGz+utsPNrvYbDhPOeZb3oZW1ickiU/CC4S55tlZjo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 77E133858429
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=SPtv+kOW
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250120154644708.IUGT.9629.localhost.localdomain@nifty.com>;
          Tue, 21 Jan 2025 00:46:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 0/3] Revert __SIGFLUSHFAST v2 patch and apply v4
Date: Tue, 21 Jan 2025 00:44:18 +0900
Message-ID: <20250120154627.107642-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737388004;
 bh=nYLZaVHNThoL/2/NGjvlqSM+Vd9FPjwUU0orYmVQAgI=;
 h=From:To:Cc:Subject:Date;
 b=SPtv+kOW+IigwZ3IOk6AzagJJ8Wghd+WAEp/DcSkWuWfMul3mholtmtQGvSzJyp76ocs8OUO
 IvWoDcrp32igH6/BrBF9jNOLMupiXAftr3Tqz48m0llsSlmxS6gwrU2P/zOWVJkCphLTNvfQjK
 /MNKRW80U/rreP33bHQTBzEaD26zpowxi4EnY4BN7G55f4YNiTgZzfW4nt6u5U1p7sYnwM0Rrx
 TxxdVTqLKeIBqjuA8PuxJUYDQYujClDmc3bE6khGHGo7tsIW6FqBb010XadNStLgkGf4ykq3p0
 hk8a/KtIdQkR4tvv8xq5QxtpWsxboJlNQwQlXD4Ezw89ODnQ==
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Revert "Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is
    sent"
  Cygwin: cygwait: Make cygwait() reentrant
  Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent

 winsup/cygwin/cygtls.cc               |  2 ++
 winsup/cygwin/cygwait.cc              | 22 ++++++++++++++++------
 winsup/cygwin/local_includes/cygtls.h |  3 ++-
 winsup/cygwin/release/3.5.6           |  3 ---
 winsup/cygwin/select.cc               |  9 +++++++++
 winsup/cygwin/sigproc.cc              | 24 ++++++++----------------
 6 files changed, 37 insertions(+), 26 deletions(-)

-- 
2.45.1


Return-Path: <SRS0=Jqgh=2C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 804FE3858D1E
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 16:12:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 804FE3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 804FE3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753114329; cv=none;
	b=v0AUer3LmUNM/DWMnqlRPLmzYXIFtX9B5PBwVY113fzx6bjvbUmcwiTPrlNAzhD7oKSICIS/hvHSERg2+PGFTJr9ZVHMeKVg4oSMx/DoEIDaAFQNuqla+dRHbOS/Hb3xb8Su1ojr46yPCjfIP8MKhGGbrws35Vf81oMd+WqheLw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753114329; c=relaxed/simple;
	bh=Rxs01P/9T9wWy0bKg2Of5zNyfPyotSRnZgT3fACHPFs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=XGASrS6cjNswqokCihKdfg/w8xDH7YD2Hki9q6VrNgtjQ0757Mz17CI/U1Xlmdl3YqImIOfA+N2ZZw4/YQbtHBMQi6U5vM/BgEQ/m1laAJFkawrtRmg84tc1aEZTC5n4Ht96T+32apxC4o5IlfJH+7W0mT8RXoYYFoI4oEgAIpk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 804FE3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Zo1a0BcO
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250721161206291.TESU.91923.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 01:12:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 0/3] Make system() thread-safe
Date: Tue, 22 Jul 2025 01:11:39 +0900
Message-ID: <20250721161151.1053-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753114326;
 bh=c4Be8ITncPmz4LE//ZxLh7bDvJCqZ4zT+C/uEFicwQY=;
 h=From:To:Cc:Subject:Date;
 b=Zo1a0BcOAr0TNudz7wq5k9IHLySPQa68zWp1FhpZe5feziIaRR4WHvo7rI3fG4Bqu0ygu9l5
 eNzTvO7/x9gYCqQm211zlPtn4rEaJ5BqVD5WvHm0r/O8fdRcTesypSxz3E3Vc6tFDrHnEHTDD9
 5tUWYlriCEEqb3KuxMZbRA7S6g47MOTPs6NQWNOK6hjhoUA72tiyKNvP4cJ0fC8TFZT9tO9/wy
 4Imgz6Ss30orQWyHHV8i6dDODIHSxwvTondHCahuwHpmGYmUjCoCOUF/mmWSar8+MUalmLmVfH
 Tvtms6ASMDH1tkn+TD0ADc0pSBDDublf4qwBqneotAoxTUpg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: cygheap: Add lock()/unlock() method
  Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
  Cygwin: spawn: Make system() thread-safe

 winsup/cygwin/local_includes/cygheap.h |  5 +++++
 winsup/cygwin/mm/cygheap.cc            | 12 ++++++------
 winsup/cygwin/spawn.cc                 |  7 +++++--
 winsup/cygwin/syscalls.cc              |  5 +++--
 4 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.45.1


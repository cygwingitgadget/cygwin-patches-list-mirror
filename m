Return-Path: <SRS0=e08y=SK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.185])
	by sourceware.org (Postfix) with ESMTPS id 0144C3858CDB
	for <cygwin-patches@cygwin.com>; Fri, 15 Nov 2024 13:14:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0144C3858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0144C3858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.185
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731676481; cv=none;
	b=XuEM5YjL1V7Nx0EWRevE1GF7TMqj/2e6/v1KiONeAyUyPq7FVRV+SjiKze9rapggW5yUizVON+ZDmW96O5Nr81PGzqjLBYVQQgGjFRgD723+9V2ZEooDHtex3LP+KCCDQKLsuWE6yucYWeCrYT04vlZ1cNAJhobdGbmA7H+gkuI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731676481; c=relaxed/simple;
	bh=ltfTc/n27yLlGiYlRKFkoQv3s8J0h+owxyUWN9Ws71E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Sw7M/xFA/+V/SaY5lEhNWECZYxg9mx177lDtswdEPs+bnsLffSYE/buwsKEtLISQ+0pN3430I9h/2XhnYC7WwgZuIdmJA8bCCJfT6B1GQfSb2GrHPSNTpYSKeMgiFJ4X3k0vk2IP9upYKPXAL+DXeCQG6FLkPWthBwRF36azkfA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0144C3858CDB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=b7MWIT9J
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20241115131437732.NHPN.67063.localhost.localdomain@nifty.com>;
          Fri, 15 Nov 2024 22:14:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Fix stress-ng --lockmix 1 errors
Date: Fri, 15 Nov 2024 22:14:09 +0900
Message-ID: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1731676477;
 bh=paKbh8tJhPDgNbynl3PA24ZSOv2ISPMD5lSoR9GKBKo=;
 h=From:To:Cc:Subject:Date;
 b=b7MWIT9JRG4QvXEsVnM3XaJNnRec36OOOXDUBc91mho51oFi4m3DXcQn21BhUODrTAi3ozmz
 lTIrNhT8eKM3aVBUQVvQCUbUmntsIlRs1rTJ4SFJPnQyrR2Y+8HaJQQDMkNpV9hNycNWZjnFGq
 Xb5zsjdhpwvVpmpUYEpl8hG8NrXrbN448dVqyB7gXC8QH1hqMmMR0CMl0y2/pg1C/Ehoyr1zup
 e3OHklh4tOv0zvQMCoJB/5iuulOBsN71QqENF8mgPrvbz2Slf3HydMAjUhgWCwTyfED7T3FtB3
 dNAfSgWKS8Zce4cSPNd9xY9jNDL4Kyxi0dm7OBTL/HE7rYIQ==
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_PSBL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: lockf: Fix access violation in lf_clearlock().
  Cygwin: flock: Fix overlap handling in lf_setlock() and lf_clearlock()

 winsup/cygwin/flock.cc | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.45.1


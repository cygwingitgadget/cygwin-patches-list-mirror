Return-Path: <SRS0=Ftjg=5F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 374A93858D1E
	for <cygwin-patches@cygwin.com>; Tue, 28 Oct 2025 11:49:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 374A93858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 374A93858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761652145; cv=none;
	b=vvuVto1x3QqG/Oxete2Gi4xfojyvEy2xO5jGDByO2XTdS+rEMbnBfAUyr+pdi7sG+04rNitsfsAvc0d5SdB5SLIX2S8ENGAWFp6WAnrXRVv1JB2hOg6lYtlX8bt3ngJPzjtH37suAEkQjpKEC229CLdH28l9b8ixv9celqKZ3Po=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761652145; c=relaxed/simple;
	bh=8+yoAIEqt9AuoaBNqse0Fhn5pFX4hcPVRYda/C9ymKw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ErbWw2UFUnzY18mFiu51ayCw9Y8cRQRdpjbmMEnGYz+ip13H6jw4WJxXFwcjwSplxoNZRqBJh29+hgPW7JCcThOruTjqbvUD0Cpu8C31PMbajkhAS5EkyBC1EuKdR7TSVN1mN1JrWbj55V9I6aXxsHAAn539GAIjzeypOs4ko7o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 374A93858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=X4Zorgvl
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20251028114901876.WYRP.17135.HP-Z230@nifty.com>;
          Tue, 28 Oct 2025 20:49:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Fixes for dll_init.cc
Date: Tue, 28 Oct 2025 20:48:40 +0900
Message-ID: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1761652141;
 bh=cs9xtb5Qwbcv/W6HiEENt+xFxEUXhC9Y/Wppe0WEKcA=;
 h=From:To:Cc:Subject:Date;
 b=X4ZorgvlN314qgIwGq4SM6LPRKvTjnyvRPNNu5zda5x2YDwy1xNEwJNwXYWNI10SOOUmQH62
 kgMSqtblG6Wa9wIg5qU1zM/I6HM+b/n9CXwLIRJ1zCwLvKPq9AagCs9RKJBl9IyzZW8/PubaPD
 U02+Ua0sh5mxE61CqcifJQSkFahMIvuA60JfEHNhY+u/oAW2zYZO2obk16I6HD8xarTDDDchnU
 ev8EZYUenHBYpgKDPClT3Ctw/ileTbrl6/c2jFSDCAiNfjon0msmImBb0/yZCdf70SKJqOAo8N
 CDsCVuQFrHQaOXsPB3iPipdU1YUDhSRYGPma+FPSUheKVdfQ==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in
    exit_state
  Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.

 winsup/cygwin/dll_init.cc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.51.0


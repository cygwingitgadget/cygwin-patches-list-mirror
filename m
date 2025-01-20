Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 7FAB7385841D
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 08:53:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7FAB7385841D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7FAB7385841D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737363190; cv=none;
	b=pDSsZ3rBXPrNHAVpsW+6+3b998yUY7vEAEdtMiGQygxBe1fUs/YrOebVtGKuuW7e03cW/NBXEIsjnyKDmOLd0K4wxRc+Bb0C/1fsufLGpW+2gAP0Ii/ELa2iZu8Oo/uN7NpfqMe+ehcqwmGx6qxvZTFRKVrfcSbL0UdlF+2GDHE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737363190; c=relaxed/simple;
	bh=UkEzYkh3E4ifdgNvJGmq8QluDVCUV5age6LMqojLiWg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jGtc9nitqYlFCchJjIXxRFmc2JV19QPCXl888xPmooNJC5GLrGkRxJilNqjDrO5DpFXENwKitDzx3GizWhuOTo38XzirUnEFDxOsxq630IWd4iFjWJ/MTJ7znAJHjJWQCu+d+DKr2cdAtfv06dtCBhr6Q6AP8+UwwvwuFo69uLo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7FAB7385841D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OzcgYGV3
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20250120085307215.RKQV.67122.localhost.localdomain@nifty.com>;
          Mon, 20 Jan 2025 17:53:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/2] Revert __SIGFLUSHFAST v2 patch and apply v3
Date: Mon, 20 Jan 2025 17:52:34 +0900
Message-ID: <20250120085249.1242380-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737363187;
 bh=XexkQmXD0j9/SrtElYFL84+ZD5ppTCXKRchKnKs3Cwo=;
 h=From:To:Cc:Subject:Date;
 b=OzcgYGV38oYmx2v1yNhtP/AdsTOUkUTVCGPLTHz92uTMiUIaXt9ksm5CrkVrRlOWnK4TD+wW
 goQWWcNtWXagCaWBwtEgGkhCCh0by7wvpm8jYBhy59wI4kRN4lCzzf1/jBShX9C+heGE9ay1RL
 yCYbd4HY2LwyY/Izn6WLF163q3MQ4hR+ns7h5IX/HsxV0HuScdxMDsvIKljK+24f+6pbAvGYUK
 gQpsixK7nt39OFKVTjuLKWvPoQ7UT+NKbNpuYKGNflsGLeTs9s0coE4a3FEyZ9XzoWKvaqd+kD
 i6jWF67Z9rrqBz0ftH6wuwhjs8TJODKdH9Ze6+vOQlCTDkPg==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Revert "Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is
    sent"
  Cygwin: signal: Do not handle signal when __SIGFLUSHFAST is sent

 winsup/cygwin/release/3.5.6 |  3 ---
 winsup/cygwin/sigproc.cc    | 43 +++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.45.1


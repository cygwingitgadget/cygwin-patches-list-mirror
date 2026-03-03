Return-Path: <SRS0=xgHh=BD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 740774BB3B96
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 12:35:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 740774BB3B96
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 740774BB3B96
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772541344; cv=none;
	b=SOV0FtwQDYVhyYRde7vtOIqkhUwixdpsWaCPuJ0d7gqoec/4QeBYUmFinc2bHb4r4rX2KBJIxqdw+jHN49BzJr7TG1GLSx2SNpK9y97Ml2QKF6fxA0r9H9QalW+oJx1EKTycMRdUfUlLRlA4vOFZCEdlu5/VU8zclQsdls3fTFc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772541344; c=relaxed/simple;
	bh=omTFmzBeSoHhjToFMzQxatiTvB15lgCb70qjjCtCD1M=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EAHxFc19ajlG+b7TpTGd8UtVDJZPrZ0HwS2cZwWTxGOr72oCuzI1GRC3I/76L/LfGgVJoLszE9tEIhzRFesa1//ooAwkv/hOqylNE8PupC1kvYBqpacRpnZGwhGZylfbyvLhkL8keGSo6Pc11dCDBVSRxTQhkWg8fMPsMiqGp1c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 740774BB3B96
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Tqsc2as/
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20260303123541797.DEKE.111119.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Mar 2026 21:35:41 +0900
Date: Tue, 3 Mar 2026 21:35:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pty: Fix handling of data after CSI6n
 response
Message-Id: <20260303213539.207bd54135d84b45478f09e7@nifty.ne.jp>
In-Reply-To: <20260303113918.25905-1-takashi.yano@nifty.ne.jp>
References: <20260303113918.25905-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772541341;
 bh=RTKj/x3UxoK7A4/bJkhbFXM+bxtIoyT2yynIVNma6+0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Tqsc2as/F0kK8v3SMwp83eWnWzaW0j66NaI8Km+ITRFypVsIrKIkZHVzjovvAs1n/cJv2dx/
 4SD53MJkrDhmY1KeW0P6HcEGdP2QSuT8qCEhrxn/SA+3tR99q5MW38kVZOOfDg8rSWRcpogcBK
 RjJFfvHGO3FwMOVc8MEKJf6FB+wqq8nSB0kKMAO6vExQGqZ+ODaIrEbjFNeEGKUiXY2tU/E55m
 Kptb2O0Wh3BLIKM/nSZIBxH1JLAAyctX2swoNbwuFAwwfp7lfpSqTefuwKai3RC7lr0064jgNy
 SYrN1/2H8yZCEooTd+1B6AfAP7F86JJ/SOg50O9ngBSr26ag==
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue,  3 Mar 2026 20:39:08 +0900
Takashi Yano wrote:
> +      len = 0;
>        for (size_t i = 0; i < len; i++)
                                ^^^ orig_len

Sorry!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

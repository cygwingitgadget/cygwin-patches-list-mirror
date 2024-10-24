Return-Path: <SRS0=lOez=RU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.185])
	by sourceware.org (Postfix) with ESMTPS id EC8403858D21
	for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 08:58:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC8403858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EC8403858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.185
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729760290; cv=none;
	b=womi0Is2nQPiHl41AGABu5HDyUQNxH9bMQml+dPBI85RiU43worqaglN1zsOdzEbBuV0cbq4xgSm1qiLXZ/dYdyrDO+2vSFjbydr0U2ic38qr8TZ0x/HmVgg35Owzk8ETeIPoynNAuC748gUNqFup0sBzfNdnSfA+9tzd5Y0G94=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729760290; c=relaxed/simple;
	bh=SJdj6JLOjp2p7p9imGzokIC6t9Z+0Z8KKf6SxLhyKjQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=j6sgUSVWiadPL9545iXfrpm11WdvEJLBk/eYUJfq72aaQ3BGUKioP4XOG0HMN2pD5leQAGLi0uz+t2l4Lu+RS4famcDsdCEHkDEPaQo7sCOo5PpdvX83XQ45jO65i7JxxG/xOPwdFk9wi9zq3cbRuXGU1HYgV6dRVCJQMQB3I+M=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20241024085804387.NFVP.13245.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 17:58:04 +0900
Date: Thu, 24 Oct 2024 17:58:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: sigfe: Fix a bug that signal handler
 destroys fpu states
Message-Id: <20241024175802.a7d18a8e604ff2d18221cfcb@nifty.ne.jp>
In-Reply-To: <ZxfLig9716RXtWLu@calimero.vinschen.de>
References: <20241014063914.6061-1-takashi.yano@nifty.ne.jp>
	<ZxfLig9716RXtWLu@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1729760284;
 bh=ZiDDY/Gqj2KjZi76weEcJ63LWJs9vIyU2q/8lMJpAuo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=B+9BDf6OtxmqWTREkxzb3i+AgQsM3jg6EIQByNrzJmpe5R20Jr0gPD/CrOIHpYyWa+fcnWwM
 HzA5SKEv8/35gfD7rv3z8bpLtxjY5liKzmZpcAaK7bP0MoaIoWsCx+41lUIPcgGq24UdX2dpvT
 yoJe34L6umBP9jJU6rCnnLVTGckyBZgey3zldex0tJYIkidFNw2f3KZsv1hpbsMZIu2r0W9RPW
 3gKWAdEkTfbxgAYRPb/Ja8YMrzrWpRA9v0clXCx6o7CHh2rx4OxHpttQpZStyaqH0RKaCmv3iA
 vvvq5HFmJ3K//ikycZpDC7x7ei519FLjqZ+EBs3vnPODbMrg==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_PSBL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 22 Oct 2024 17:58:02 +0200
Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> Hi Takashi,
> 
> big change, so, honest question: Do you think this is safe for 3.5.5?
> 
> This certainly also requires an entry in the release text and there
> are just a few minor typos in comments, see below.

What about adopting my first idea to 3.5.5
https://cygwin.com/pipermail/cygwin/2024-October/256506.html
and applying this patch to 3.6.0 branch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

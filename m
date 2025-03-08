Return-Path: <SRS0=ttel=V3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id EEECE3858D1E
	for <cygwin-patches@cygwin.com>; Sat,  8 Mar 2025 23:10:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EEECE3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EEECE3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741475433; cv=none;
	b=SQZfiBjjiLKkNSltDrP4h94t65EqV7M2s0IThGO7llRgDnUNXKe+QTLu4ofK3anDcSOftYU6891BGWSokQkGuWYS0FFpqc09X++xzi3gN2+e5zR7zanR25M7uqEye3ygamp0pcHGrh7+dVoGz0aQzckj6Hl018udonGtjYV+qDE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741475433; c=relaxed/simple;
	bh=/Qmf7auJ6oJNX+KcRJYdufmFzP0B9d7HrUiigsl5nuM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=IYBb7Qzl5En5Yc+4uebLQ1L2MLCiAwWF4nlrQa/wR66LRiHDDY27NJHUWQk/S7dH5ljlrg8U5D3XT4YyVcdZog7+dtBbxN6CxAm1DS/MmnMv+o8l1O78devC5LODLHT1aSK/nHw//+LYzUZ69WXL7kc+wrDr/tdmzUAtcI3rU9k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EEECE3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kGTxNp+S
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20250308231029670.PEBB.111119.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 9 Mar 2025 08:10:29 +0900
Date: Sun, 9 Mar 2025 08:10:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [GOLDSTAR][PLUSHHIPPO] Re: [PATCH v3 2/3] Cygwin: signal: Fix a
 race issue on modifying _pinfo::process_state
Message-Id: <20250309081028.bbcca7d43c1209fd514e0c55@nifty.ne.jp>
In-Reply-To: <mu8psj16ga7p81dvnk6kfhmg6fhvqvvddi@4ax.com>
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
	<20250228233406.950-3-takashi.yano@nifty.ne.jp>
	<Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
	<20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
	<Z8WoFOXWxwC8AJNx@calimero.vinschen.de>
	<20250303233919.4f463d642c88623f9c520f74@nifty.ne.jp>
	<Z8X6uJJwhVA7i7lk@calimero.vinschen.de>
	<74c86bc5-ba6c-4ea2-b39f-d41ef538c5f9@dronecode.org.uk>
	<Z8nvhKqPZ6k7DgIs@calimero.vinschen.de>
	<79e2e9a1-f7e3-43a8-b1fd-1a1bdd477158@gmail.com>
	<mu8psj16ga7p81dvnk6kfhmg6fhvqvvddi@4ax.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741475429;
 bh=NALw37a1aythyNIkPrYZ6jh8g9efBYsMDeovInCZmF8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=kGTxNp+SJNTOzDHdXoUcZCX62qkGOzAIVavj4iaJ8cB/J20YHzMH/0xmtzYj7qBX1rExz6MP
 AW1pM9ibrSzSiqNya1rhIab1AAtaOECVij6nkDnusgPhL+ST1uZTHxVylvFgfISpP1d//qq6Y9
 C2jkACOft9Wz8Fr3udKxSyyipDEQKcqLrEH4eglge/IfsiLwc2q1L/Fev+k272RBgW+Vaxq5kt
 6YueDwye6jGy29xvzbICnPRZrmoPDTbAj4dOwOQ0RQNrTxjievCSv7r5bZO6+BvKkjeWl3hJI2
 Onvyq1L1ZoUGug40mT5IaWSIOwjccfZWdeT+0JMH1hiERGyQ==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 08 Mar 2025 15:08:58 -0500
Andrew Schulman wrote:
> > >> I think Takashi-san must be about due another gold star, as he's been doing
> > >> some sterling work recently, fixing complex and difficult to reproduce bugs!
> > > 
> > > Absolutely!  Yesterday I was even mulling over a pink plush hippo, but
> > > Takashi already has one over his fireplace and I wasn't sure if a second
> > > one isn't taking too much space.
> > > 
> > > Corinna
> > 
> > An hippo is well deserved IMHO
> > 
> > Regards
> > Marco
> 
> Awarded! https://cygwin.com/goldstars/#TY

I am deeply honored and humbled.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

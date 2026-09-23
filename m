Return-Path: <SRS0=ANL/=HP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 3204D4BAE7DD
	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 01:55:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3204D4BAE7DD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3204D4BAE7DD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790128547; cv=none;
	b=A+IZmDz4FcurWqhI4fQ3NWipdcf3ZcxP079ETOApj2bDURnxT5r0h9TUksUj9ZbkT2qE5f6HvHBCVwPOyNwgbjidy+dGXtnlsJpRPOlACbPRwf942P3y6Sgc5J7+eKcqKTlcXysElaffRkyday/eA9PnGy4rxDrkz16XxIT6LpQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790128547; c=relaxed/simple;
	bh=hcIk6jUXTvEw5/MLS+U8HamGkOqzKU3QCX2/M/FZOSY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YXnF9nzkLw7H7fJoueq8FEDziyOtKL3Xg/G0zd/MJ5i7hQb9FdbYSdfK1Bn1c1awEV/drJBw0ji3e6WMvNhIay6pmNNz5XaKvSB5diqnOWmRNjsp94cherEhcA6iCFBf5A4djFcykDSVdK70rQIl6xo97K2sJtcAIu5jpotY1fU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=F3iiGYSb
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3204D4BAE7DD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=F3iiGYSb
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260923015545291.BFDI.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 10:55:45 +0900
Date: Wed, 23 Sep 2026 10:55:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Fix "unused but set variable" warnings with gcc 16
Message-Id: <20260923105544.d6411ade83fa326e6e1674a5@nifty.ne.jp>
In-Reply-To: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
References: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790128545;
 bh=PzUKf9D6FCiiTa8+CgV1TqHe5HuHS3Fgh/dV+7RqekY=;
 h=Date:From:To:Subject:In-Reply-To;
 b=F3iiGYSbKnP6UFu84xSwqd30RQ1pMObRmRLeYMiqA6/FEcAAgQWC3Yv0gAs/HJFtgXqeQQxR
 PizH784wYx2nQqalCOfL41XCnFzpAeRP/aZQmPQu7++YnaI6v/okmboIdLldTrRwHdL/uPVeP5
 Cn/CmGF8bdnjgbK5PCjOPdNtGZWI/0pA0fwcNMhQbDVOw4RIR1Nm9dXANwFTopggW7LSMcOt6l
 JGjgnbE/VnKfO+dA8aJnhLg1aMkuiAR7UE2EmUP5RXOx6mMgiMKQEjpIOc6Gqrk3PSvqhPg36S
 MhzNzJ3lFizJ6nlBV2yH2kkbmj9LYYSk0T65njFv4u2TO2jQ==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 22 Sep 2026 18:37:34 +0100
Jon Turney <jon.turney@dronecode.org.uk> wrote:
> Jon Turney (3):
>   Cygwin: Variable 'looped' computed but never used
>   Cygwin: Variable 'prot' computed but never used
>   Cygwin: Variable 'nfences' computed but never used
> 
>  winsup/cygserver/sysv_shm.cc | 6 ++++++
>  winsup/cygwin/mm/malloc.cc   | 4 ++++
>  winsup/cygwin/spawn.cc       | 2 --
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> -- 
> 2.51.0

All LGTM. Please go ahead.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

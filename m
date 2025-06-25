Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ACFEC3857BAF; Wed, 25 Jun 2025 11:43:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ACFEC3857BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750851808;
	bh=TDqb9parIBOWvGgoaHuiNZt8siH8blBe6YjDVjLbuWc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=c4AlNNhO14GlMDDfq6haHbOyPM6vRz9q3DN9CpU3kMo96T9+zvw+wd75mbsdcmOlY
	 UOVp00ggQOlgRhTbNWhEQo0B7ucl3nS9O5wkXPr+wmGPhP1g7SUz5AUdUS9U9kOIOn
	 vcr0S1ew2TiWz50fBC70i5sIwkq3xuuhW/5Kg4i4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 93CEAA80B69; Wed, 25 Jun 2025 13:43:26 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:43:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: signal: Do not suspend myself and use VEH
Message-ID: <aFvg3hoUyfr_bVSd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250625110434.1533-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625110434.1533-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

One last question.

On Jun 25 20:04, Takashi Yano wrote:
> After the commit f305ca916ad2, some stress-ng tests fail in arm64
> windows. There seems to be two causes for this issue. One is that
> calling SuspendThread(GetCurrentThread()) may suspend myself in
> the kernel. Branching to sigdelayed in the kernel code does not
> work as expected as the original _cygtls::interrup_now() intended.
> The other cause is, single step exception sometimes does not trigger
> exception::handle() for some reason. Therefore, register vectored
> exception handler (VEH) and use it for single step exception instead.
> [...]
> +	  while (!in_singlestep_handler)
> +	    RtlWaitOnAddress (&in_singlestep_handler, &bool_false,
> +			      sizeof (bool), NULL);

Is there *any* situation thinkable which would make this loop run
forever?  I.e., a situation where the VEH doesn't start?  And,
would we even have a way to handle that?


Corinna

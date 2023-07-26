Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4D42A3858D35; Wed, 26 Jul 2023 13:12:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4D42A3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1690377126;
	bh=bDav5ZwcUlLTKSZRTaQ6iCoZWk90HmJtg7u7bpzKb/Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TGkqRxtbKpacaP2W59Jtx9aBXO7SRFOHC0AfdBLTuUHO/EkXM4ksV7vdy1VICf3Gb
	 Bpv/DpEX4sg3i3CIyx78z1ezrtx3hy3QFNfpuqeQ7tREYEN2Jc6eoJt8xZxQIBFCsm
	 z13j8Wob7jLtF6aIm2E+LbtBvXo7Ii6HDNBPVHNw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E7EA1A80889; Wed, 26 Jul 2023 15:12:03 +0200 (CEST)
Date: Wed, 26 Jul 2023 15:12:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Fix AT_EMPTY_PATH handling
Message-ID: <ZMEbo2OrE9dcaAmK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
 <ZL6W9M4TXFv3Igcy@calimero.vinschen.de>
 <c6a8b6d9-0cce-afe8-75b0-71f60b9af0af@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6a8b6d9-0cce-afe8-75b0-71f60b9af0af@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 26 11:10, Johannes Schindelin wrote:
> Hi Corinna,
> 
> I had a look over the patches and they all make sense. I also tested the
> code to make sure that the `tar xf` regression I needed to be fixed is
> also addressed by this patch series.
> 
> As I don't really know the customs of the Cygwin project, please feel free
> to add any Reviewed-by:, Acked-by: or whatever footers (or, if none of
> those are appropriate, I am of course totally okay with no footer at all).
> 
> Thank you so much for fixing this!
> Johannes

Great, thanks for reviewing and testing!

I'll push it later today.


Thanks,
Corinna

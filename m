Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 429D74BA540C; Wed, 10 Dec 2025 17:37:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 429D74BA540C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765388225;
	bh=ydlaIDyiDvYxPL+X4cCESQ4u70b5g79jKiBNOBpaqGM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dj9Y//7Muyg4kQdZLeLWwEb04QOnkhDVpi6zUjmWT5WRXvwUGBoCMjK4H04wNwJVr
	 Uho/GfqNr+x8rKd1IPQMXPLB3TkIkSK7hWlH41C3+aNoh9qArQxHPh16T93EJoGglk
	 Ko8I6+ALdZEo6SUT2w9T1hytbJALmFnI3RkNjPmg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 60B19A80D1A; Wed, 10 Dec 2025 18:37:03 +0100 (CET)
Date: Wed, 10 Dec 2025 18:37:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [WIP::PATCHES] [RFC] Preliminary ARM64 compilation support for
 Cygwin
Message-ID: <aTmvvwfClr2suB2R@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082C051C4E43AB64AD4B9959FA2A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA0P287MB3082C051C4E43AB64AD4B9959FA2A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

thanks for letting us know, this is pretty exciting!

Just one nit for now.  The first patch contains newlib/Makefile.in but
not newlib/Makefile.am.  Please make sure to change Makefile.am instead.


Thanks,
Corinna


On Dec  8 10:09, Thirumalai Nagalingam wrote:
> Hi Everyone,
> 
> I'm sharing a set of ~28 patches that enable preliminary compilation of the Cygwin on ARM64.
> [27 patch files (001-026 patches + one consolidated '[MAIN]-Cygwin-Workarounds-to-compile-for-aarch64.patch' containing all changes].
> 
> 
>   *   These patches are work-in-progress and not yet ready for upstream review.
>   *   They are being posted here primarily to make the work public and efforts visible to the community.
>   *   In the near future, we plan to improve them and re-submit them in separate threads for proper review and eventual merging into upstream/master.
>   *   A [V2] of many of these patches will be prepared and submitted.
> 
> Although this series is not ready for detailed review, anyone interested is welcome to look through the changes. Feedback, suggestions, or enhancements are appreciated.
> I would also like to acknowledge and thank Radek Bartoň <radek.barton@microsoft.com> and Evgeny Karpov <Evgeny.Karpov@microsoft.com> for their contributions to this effort.
> 
> Thanks to everyone for maintaining Cygwin.
> 
> Best regards,
> Thirumalai Nagalingam
> <Thirumalai.nagalingam@multicorewareinc.com>





























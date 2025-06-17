Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CD0A2383983F; Tue, 17 Jun 2025 09:54:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD0A2383983F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750154049;
	bh=GfxhbpT7uywdMOEFSD2SI2TvZOqoEdAotywo1W4WWTk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bmEQi3gbeEMtACrJnBPVb4ugEiQiJwp++McTn2WE73mSEozsOZA5dke3vFP99rnFT
	 iViJ2k74VRqO6Rt/JL/VPc0qsnqGStvR7ujmpZ2BxA9o6kiPo4SnPk5OPV3NfsMwq9
	 pVH9TmF2k9gosDviZEGU4HMRMybOZL52iK622J9U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AC543A80961; Tue, 17 Jun 2025 11:54:07 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:54:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper
Message-ID: <aFE7P8wupyJiuPXC@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	Jeremy Drake <cygwin@jdrake.com>, cygwin-patches@cygwin.com
References: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>


@Thirumalai, your patch looks good, but I have only marginal knowledge
of AArch64 assembler, so I would be grateful to get input from somebody
having more insight.

@Jeremy, can you please help review Aarch64 patches especially if they
contain assembler code?


Thanks,
Corinna


On Jun  5 07:46, Thirumalai Nagalingam wrote:
> Hello,
> 
> Please find my patch attached for review.
> 
> This patch adds AArch64-specific inline assembly block for the pthread
> wrapper used to bootstrap new threads. It sets up the thread stack,
> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original
> stack via VirtualFree, and invokes the target thread function.
> 
> Thanks & regards
> Thirumalai Nagalingam



Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 83D4A4BA2E3B; Mon, 30 Mar 2026 08:32:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 83D4A4BA2E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774859571;
	bh=1l4Ntpqov47YlxZQy35qkJ4Fo5tQDNyRYFR4M3JaoCY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=US3Xob/2aKJRqCQOwAGnrtK8+L/H1D6RVan5GGm7lR0Ztjf0ZpbcGg1m+/h/upTmn
	 KFsW0f9E7FQ69CcIugzX3YHOPG8N2LnRAOUY8+XP10Zq/vv5zRKtb46hJT6Ui7OQl1
	 Ys9AC8opHX+xow4CPLEmjh1gPAIewzntiMQBhDPM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 82D41A80C43; Mon, 30 Mar 2026 10:32:49 +0200 (CEST)
Date: Mon, 30 Mar 2026 10:32:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: aarch64 SEH fixes and handler refactoring
Message-ID: <aco1MXC1NVxdBMp4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082CAC457D335E3325522CD9F48A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB3082CAC457D335E3325522CD9F48A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

On Mar 24 12:42, Thirumalai Nagalingam wrote:
> Hi all,
> 
> The previously posted patches for aarch64 SEH support and handler refactoring were marked as work-in-progress. Now they should be ready for upstream review.
> This series [2 patches] includes changes related to:
> 
> 
>   *   Proper symbol references for exception handlers on aarch64
>   *   Refactoring of SEH handler data setup via macros
>   *   Guarding altstack_wrapper in exceptions.cc for supported architectures
> 
> These patches will unblock merging of patch from Igor Podgainoi [SEH: Fix crash and handle second unwind phase on aarch64]( https://cygwin.com/pipermail/cygwin-patches/2026q1/014741.html)

Patches pushed with Igor's followup patch.


Thanks,
Corinna




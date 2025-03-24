Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C20E33858423; Mon, 24 Mar 2025 10:25:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C20E33858423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742811933;
	bh=PhZAFPeVDuJPjZkvW4gXDGZl4Qo54kU7TDRDWjdnjM4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=uYNqo2Ed7Lnc5dKayNuprtrTJYuaANiOMLEY/0oMCx534nQgWcexh7n37Ud6mWvRJ
	 EYobl+E2w2sv39nVWxslkdQuF4jMA97q8+vvdTR0DqNt/hlp10U4Ay7mj+33mGbsHP
	 2UUfAVxPfJjKJp6lchnCAAUrzyRQztC7GXglv59E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B9012A80B7A; Mon, 24 Mar 2025 11:25:31 +0100 (CET)
Date: Mon, 24 Mar 2025 11:25:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Clear direction flag in sigdeleyed
Message-ID: <Z-EzG5FMhKL9lqJM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250324012833.518-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324012833.518-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 24 10:28, Takashi Yano wrote:
> x86_64 ABI requires the direction flag in CPU flags register cleared.
> https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions
> However, currently that flag is not maintained in signal handler.
> Therefore, if the signal handler is called when that flag is set, it
> destroys the data and may crash if rep instruction is used in the
> signal handler. With this patch, the direction flag is cleared in
> sigdelayed() by adding cld instruction.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257704.html
> Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/scripts/gendef | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> index a2f0392bc..861a2405b 100755
> --- a/winsup/cygwin/scripts/gendef
> +++ b/winsup/cygwin/scripts/gendef
> @@ -179,6 +179,7 @@ sigdelayed:
>  	movq	%rsp,%rbp
>  	pushf
>  	.seh_pushreg %rax			# fake, there's no .seh_pushreg for the flags
> +	cld					# x86_64 ABI requires direction flag cleared
>  	# stack is aligned or unaligned on entry!
>  	# make sure it is aligned from here on
>  	# We could be called from an interrupted thread which doesn't know
> -- 
> 2.45.1

GTG, of course!


Thanks,
Corinna

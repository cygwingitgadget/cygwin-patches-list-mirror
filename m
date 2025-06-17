Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 898363852FCB; Tue, 17 Jun 2025 09:15:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 898363852FCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750151724;
	bh=Y9kG9PfvHqM4mdBt39Ovdh7GgEmKOoPjVxvAOVTDgIQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=c1yOn/hhBfr29Gp86AZT1u0i6eSqKtfRI06HdGb4OEwgP47sMaOFDtounomTsKHVo
	 UGPxCMTF28FTH7C7j6w9GkqV/e5lY+VJWRuKKru6bKqfsHTjkZPDkd1ELD3DT3aw4k
	 6+moDQCINdm7o0/AUm9mBsGduL12CsX7M53zLevE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6F179A80961; Tue, 17 Jun 2025 11:15:22 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:15:22 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Revert _cygtls::inside_kernel() change
Message-ID: <aFEyKtHoBKecMZ0q@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250529012654.2077-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529012654.2077-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On May 29 10:26, Takashi Yano wrote:
> This patch partially reverts the commit b7097ab39ed0 because it
> seems to cause issues when longjmp is used within a signal handler.
> The problem that the commit addressed no longer occurs even if this
> chage is reverted.
> 
> Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc           | 6 +++---
>  winsup/cygwin/local_includes/cygtls.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

LGTM

Thanks,
Corinna

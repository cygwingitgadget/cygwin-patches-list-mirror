Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E2AFB3858280; Wed, 26 Mar 2025 09:15:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E2AFB3858280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742980519;
	bh=bhnpw5jFMFfDNC4pEIO1oT31BJADJw3t8HoWPErYHNc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WZQmzrlAqdzXqsjkl/f9sucVu4QakJJFSGGRR+xc65m1Lx15k/E8AEaxPRo3N8wnY
	 XsK9NKhyq8znHnLfLdGXogvJttZokkseAc63X54Lg5606w8fdr9RpvlMzpI7Q50Idg
	 mOXXHgMjAvEZoYGnYUSIQDdS6Gk+5TF9mduPr1zM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8C2A5A8067E; Wed, 26 Mar 2025 10:15:17 +0100 (CET)
Date: Wed, 26 Mar 2025 10:15:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Copy context to alternate stack in
 the SA_ONSTACK case
Message-ID: <Z-PFpVuuV3-8PEgw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250325125417.1898-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325125417.1898-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 25 21:54, Takashi Yano wrote:
> After the commit 0210c77311ae, the context passed to signal handler
> cannot be accessed from the signal handler that uses alternate stack.
> This is because the context locally copied is on the stack that is
> different area from the signal handler uses. With this patch, copy
> the context to alternate signal stack area to avoid this situation.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257714.html
> Fixes: 0210c77311ae ("Cygwin: signal: Use context locally copied in call_signal_handler()")
> Reported-by: Bruno Haible <bruno@clisp.org>
> Reviewed-by: Corinna Vischen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc | 8 ++++++++
>  winsup/cygwin/release/3.6.1 | 5 +++++
>  2 files changed, 13 insertions(+)

LGTM, please push.


Thanks,
Corinna

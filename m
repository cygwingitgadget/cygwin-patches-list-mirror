Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3AA9F4BA23FE; Sun, 19 Apr 2026 10:23:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3AA9F4BA23FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1776594231;
	bh=Ye3fzRU6BYmQqPkuTBmp0CtKlcUhWLRE/d0rZsg9VJs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=MJkSVbID6+bIz542xTAOGmg8G5u0WF8sD9fvQSzk29lGrOBZop0QAqq/3XKPZtJhz
	 7TwLkHt90CS/IJHRTNPtLaDKUF7KHidtuCq9RVH9aXKtWIgQmqhILD4vIf2IyVg6KA
	 Xo7n1kU3o7UNlbGS/fiBXJ0rUx7jX2JxWcg8zATg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 50084A8096D; Sun, 19 Apr 2026 12:23:49 +0200 (CEST)
Date: Sun, 19 Apr 2026 12:23:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: select: Set errno when peek() returns -1
Message-ID: <aeStNfAaLRmw9H3X@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260417194531.993-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417194531.993-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Apr 18 04:45, Takashi Yano wrote:
> Currently, poll() sometimes returns -1 with errno == 0 if the fd is
> not opened. This is due to lack of setting errno when peek() fails.
> This patch ensure to set errno to thread_errno if peek() returns
> NULL.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2026-April/259602.html
> Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> Reported-by: Nahor <nahor.j+cygwin@gmail.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/select.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Looks like an obvious fix :)

Thanks,
Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 36B52385703B; Thu, 26 Jun 2025 07:55:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 36B52385703B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750924536;
	bh=ASrImUQaBmaSk8EnO7UX09yqIcWMJSIp4cCMEGAoZlk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=GPGXKqraPBKASJ1rza+ADdN9+MUO49UDoWD8q6wYsoH5LY7HlrWWJvJWArDOsCzTK
	 ocwL4J9L+GUxcy1l9yAExM7uscnsg1CXh3csRphKbd8DwzoJ5iNEiRs2p4yEiBq5OB
	 Adr84bgY+fHP4Sj+0z7TfHjNhlpWGAqKMGWhPx/Y=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0A8FBA80C93; Thu, 26 Jun 2025 09:55:34 +0200 (CEST)
Date: Thu, 26 Jun 2025 09:55:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: signal: Do not suspend myself and use VEH
Message-ID: <aFz89XJDU--ESV-x@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250626062031.1093-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626062031.1093-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jun 26 15:20, Takashi Yano wrote:
> After the commit f305ca916ad2, some stress-ng tests fail in arm64
> windows. There seems to be two causes for this issue. One is that
> calling SuspendThread(GetCurrentThread()) may suspend myself in
> the kernel. Branching to sigdelayed in the kernel code does not
> work as expected as the original _cygtls::interrup_now() intended.
> The other cause is, single step exception sometimes does not trigger
> exception::handle() for some reason. Therefore, register vectored
> exception handler (VEH) and use it for single step exception instead.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258332.html
> Fixes: f305ca916ad2 ("Cygwin: signal: Prevent unexpected crash on frequent SIGSEGV")
> Reported-by: Jeremy Drake <cygwin@jdrake.com>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc           | 55 ++++++++++++++++++---------
>  winsup/cygwin/local_includes/cygtls.h |  1 +
>  winsup/cygwin/local_includes/ntdll.h  |  2 +
>  3 files changed, 40 insertions(+), 18 deletions(-)

Great, thanks, let's try this.  10 ms might be a bit short under load,
but we can always raise the value if push comes to shove.


Thanks,
Corinna

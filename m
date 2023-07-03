Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A00403858D1E; Mon,  3 Jul 2023 10:52:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A00403858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688381547;
	bh=aP3bgmItEusnMZfwQDXtwrqi+pini4ZdLQr0vRVRcig=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=DzBxL516gWrCiMdVMNFrZHHEzPy/l+MZHC203mELycLeYsTtf4R24qXsIz8i2dFNj
	 DK2pevD04KNmapGGbd8S2JqX3aPv22VPgLtZaSy1MXBk/kULfjvigQOuh0tZbcLRg0
	 sT0ItqBdudIwxz9S40povbZYUQsxgzehbr0jQhWQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E4893A80D55; Mon,  3 Jul 2023 12:52:25 +0200 (CEST)
Date: Mon, 3 Jul 2023 12:52:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dtable: Delete old kludge code for /dev/tty.
Message-ID: <ZKKoaQlqEXjBjNV7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230627132826.9321-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627132826.9321-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jun 27 22:28, Takashi Yano wrote:
> This old kludge code assigns fhandler_console for /dev/tty even
> if the CTTY is not a console when stat() has been called. Due to
> this, the problem reported in
> https://cygwin.com/pipermail/cygwin/2023-June/253888.html
> occurs after the commit 3721a756b0d8 ("Cygwin: console: Make the
> console accessible from other terminals.").
> 
> This patch fixes the issue by dropping the old kludge code.
> 
> Reported-by: Bruce Jerrick <bmj001@gmail.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>

Please add a "Fixes:" tag line.

> ---
>  winsup/cygwin/dtable.cc | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index 18e0f3097..9427e238e 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -598,12 +598,7 @@ fh_alloc (path_conv& pc)
>  	  fh = cnew (fhandler_mqueue);
>  	  break;
>  	case FH_TTY:
> -	  if (!pc.isopen ())
> -	    {
> -	      fhraw = cnew_no_ctor (fhandler_console, -1);
> -	      debug_printf ("not called from open for /dev/tty");
> -	    }

This is ok-ish.  The problem is that the original patch 23771fa1f7028
does not explain *why* it assigned a console fhandler if the file is not
open.  Given that, it's not clear what side-effects we might encounter
if we change this.  Do you understand the situation here can you explain
why dropping this kludge will do the right thing now?  If so, it would
be great to have a good description of the original idea behind the
code and why we don't need it anymore in the commit message.


Thanks,
Corinna

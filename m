Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9B20B3857C67; Wed, 25 Jun 2025 11:37:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9B20B3857C67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750851455;
	bh=MsNoAxhrteipmRRYB0/ghb+ds+IE9o0rApnW9maOnGM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=sujsxB8sbxf5UBYlBA1j/X9juLcez7Dby//LKjKy8VTVTJRXtv5zDjNdIP6yhuUWS
	 ImPQwghDm07UY50qGeWqgWC38C+OG6RGYnbnnHqL0h2MqnNEuWYLR6Odmpl9XlLlNq
	 4/eEc8g7Fa2c35Zv3uTr03Bm/uvzBlwj55pj//hw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 868B4A80E29; Wed, 25 Jun 2025 13:37:33 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:37:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-ID: <aFvffapPEsFfW2--@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
 <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
 <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
 <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
 <4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
 <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jun 25 19:55, Takashi Yano wrote:
> Hi Johannes,
> 
> On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> > 
> > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > 
> > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > 
> > > > I'd revise the patch as follows. Could you please test if the
> > > > following patch also solves the issue?
> > > 
> > > Will do.
> > 
> > For the record, in my tests, this fixed the hangs, too.
> 
> Thanks for testing.
> However, I noticed that this patch changes the behavior Corinna was
> concerned about.
> 
> After trying various things, I found yet another solution for the issue.
> 
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> index e35d523bb..e36aa57fc 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -647,7 +647,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>  	    }
>  	  if (!NT_SUCCESS (status))
>  	    break;
> -	  if (io.Information > 0 || len <= PIPE_BUF || short_write_once)
> +	  if (io.Information > 0 || len <= PIPE_BUF)
>  	    break;
>  	  /* Independent of being blocking or non-blocking, if we're here,
>  	     the pipe has less space than requested.  If the pipe is a
> 
> Corinna, what do you think?

I think you two should continue to find a solution.  I'm not going to
interfere.


Corinna

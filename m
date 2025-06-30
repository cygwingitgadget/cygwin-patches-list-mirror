Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8B4D03852129; Mon, 30 Jun 2025 09:51:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8B4D03852129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751277117;
	bh=VtjwzZaDBXHBav7oPsjynQfLWGZtKtCwaPlD9INHhto=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=tSQhe1CwfCBO+XrvA8EtO7A1+fcpO42jBka+6BDb9lSxdDg3hecL7YPJyBMLyYbmU
	 pas7TyxpQfcDN6N4L32qSeJSloWkLeZAVlv3U4Gpmr7swHllG0WqbJ5wgFIgR67TMd
	 xxPlH6WF3+UBX6ix6O1jC5mZGA2gqWhPrwOiD8V4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BC657A80897; Mon, 30 Jun 2025 11:51:54 +0200 (CEST)
Date: Mon, 30 Jun 2025 11:51:54 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: testsuite: test passing directory fd to child
Message-ID: <aGJeOk-3UQvFOwtL@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1b4da216-51cb-cbc5-7a2d-db997429eed3@jdrake.com>
 <aF6POTp2VGPfPE6m@calimero.vinschen.de>
 <4288efc0-5e49-84cc-0f96-2a0d07f4b121@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4288efc0-5e49-84cc-0f96-2a0d07f4b121@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 27 12:13, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 26 13:34, Jeremy Drake via Cygwin-patches wrote:
> > > It doesn't make a whole lot of sense to redirect stdin/out/err to/from a
> > > directory handle, but test it anyway.
> >
> > I disagree.  There's nothing wrong if a program expects a directory
> > handle on a file descriptor if the task is, for instance, to perform
> > readdir on the incoming descriptor.
> >
> > Therefore, the code is ok, the commit message isn't.
> 
> Revised commit message
>     Cygwin: testsuite: test passing directory fd to child
> 
>     This is a legal (if non-obvious) thing to do, so test it.
> 
>     Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> 
> OK to push this series?

Yup, go ahead.

Thanks,
Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9F7494BA2E1D; Wed, 10 Dec 2025 17:40:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F7494BA2E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765388442;
	bh=J9oaX/s6dlM+qdS9+r4v/XpJXF059SGBvBlSKMMnr/M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DjclXHAjDcTgMvXFIYkZSjICcZqEA9RXpnHWfuKUr2hfKjefsbs76/6GGt+OPJmdv
	 2B6oG2fhHIuuiKCP07xkrAnbxfp2dBeuPAf+KhntYfahiN4scJoFCQu56dWy9SXkxt
	 Qe6ZOMuOTeydCM97CaBy8LlVVaTc6iMG8xxJp8aM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BCAC7A80CA4; Wed, 10 Dec 2025 18:40:40 +0100 (CET)
Date: Wed, 10 Dec 2025 18:40:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Update the "building cygwin" FAQ
Message-ID: <aTmwmFp_oV0l1h7L@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com
References: <20251210114043.16625-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251210114043.16625-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Dec 10 11:40, Jon Turney wrote:
> Shorten the example path for clarity.
> 
> Using --prefix rather than DESTDIR to select the install location is
> generically wrong (and specifically wrong because it causes an
> incorrectly prefixed /etc/cygserver.conf path to be baked into the
> cygserver built).
> 
> Install using -j1 because... cygwin's install rules overwrite things
> installed by newlib, so running those in parallel can have undesired
> results. (something something tooldir something something)
> ---
>  winsup/doc/faq-programming.xml | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Yeah, good one, thank you.


Corinna

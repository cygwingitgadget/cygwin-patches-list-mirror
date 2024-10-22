Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E82ED3858D21; Tue, 22 Oct 2024 15:00:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E82ED3858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729609219;
	bh=jH0k/S8pI40+DmiUuJz/8H/txeyVQz0VCT9w0/mXxgE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Jt8yLOwGopmfjEjLPqg8fBowtO7t89LSmn5FLigeehwJYeoRRM92WgYq+1PEgyEyw
	 jb0IxJyVIxQDhzhS2QNY5mh1HgtG2Oq1X1m+Kr52KmfZ8GBdoXAv8/d3AQxaY7fQZ5
	 3vo9dS3pGcdZBw2b/8Bf2b7zSaI3mQiSfnlQz4So=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E08ABA80D05; Tue, 22 Oct 2024 17:00:17 +0200 (CEST)
Date: Tue, 22 Oct 2024 17:00:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com, Mark Liam Brown <brownmarkliam@gmail.com>
Subject: Re: [PATCH] Cygwin: Minor updates to load average calculations
Message-ID: <Zxe-AUQTuTGtggNV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com,
	Mark Liam Brown <brownmarkliam@gmail.com>
References: <20241009051950.3170-1-mark@maxrnd.com>
 <Zxe9cMw7fNi8qImG@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxe9cMw7fNi8qImG@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Oct 22 16:57, Corinna Vinschen wrote:
> On Oct  8 22:19, Mark Geisert wrote:
> > -  *load = rql + running;
> > +  *load = running + rql;
> 
> Not sure I'm understanding this right, but wouldn't a default queue length
> of 1 make more sense?

Either way, as a bugfix this should go into 3.5.5, so it would be nice
to get a matching entry for the release/3.5.5 file.


Thanks,
Corinna

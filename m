Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CF9123858D38; Mon,  4 Nov 2024 10:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CF9123858D38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730716392;
	bh=Wlkxo6c5I2RP4Hofj9N+Lwcdd9IIaaBNWy7Gx2VgQWI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=G0E/GvH/vqFbgG2+UAKT2F4jFLg8kxzdG/YkhEgijUbDeBz9kwnMNO3vCPmbcyoUB
	 m33jiVy8ZS+gzGWiV64JlvsC4JTVZoeFYrswJ3KwzuPwTsKCTB/ROY0BA1DSxHWNd9
	 PcIr4euaUTlMmasKadzbN5xbnzaYhCxhbleMzzPU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B3F04A80C4D; Mon,  4 Nov 2024 11:33:10 +0100 (CET)
Date: Mon, 4 Nov 2024 11:33:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Minor updates to load average calculations
Message-ID: <Zyii5jaKhgFlaeid@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241009051950.3170-1-mark@maxrnd.com>
 <Zxe9cMw7fNi8qImG@calimero.vinschen.de>
 <8b57844e-c9fe-4135-99fc-8a1b98be21be@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b57844e-c9fe-4135-99fc-8a1b98be21be@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 01:31, Mark Geisert wrote:
> > > -  *load = rql + running;
> > > +  *load = running + rql;
> > 
> > Not sure I'm understanding this right, but wouldn't a default queue length
> > of 1 make more sense?
> 
> I don't think so. That would make an idle system show a load of 1/ncpus
> because of the division a couple lines up from the end.

Oh yes, you're right.


Thanks,
Corinna

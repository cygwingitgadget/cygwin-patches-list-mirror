Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BDA4538252ED; Tue, 17 Jun 2025 18:03:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BDA4538252ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750183407;
	bh=GdjCtck1NipVImwAEqFHY87a2/r9D5LQVlhi97aeNGU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kpRxDNYvaNTTNpWAOBXfPUkhukxWL+Cbr3vnExs6ahus1Q/7dHpaYg+PucYa7uSLk
	 8vu1hD/yu051eCtWzzWAs6Ve2OTRdmdDs88/BceT8UCqE2dkIQPmvnWDbbgvDSpFu+
	 ILhdAjt753GCEzdxlzA3kof1J10HW/RFO9fI2p3A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EC4A9A80961; Tue, 17 Jun 2025 20:03:23 +0200 (CEST)
Date: Tue, 17 Jun 2025 20:03:23 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 2/3] Cygwin: hook posix_spawn/posix_spawnp
Message-ID: <aFGt6wzEbOqc8yA-@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <610f9534-b03b-a495-d046-6f09f7a077db@jdrake.com>
 <aFE4hznx51Xw_aNF@calimero.vinschen.de>
 <9a350320-4d7a-509a-c5a7-beee9185824d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a350320-4d7a-509a-c5a7-beee9185824d@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 17 10:44, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 17 Jun 2025, Corinna Vinschen wrote:
> 
> > On May 29 10:58, Jeremy Drake via Cygwin-patches wrote:
> > > +
> > > +/* HACK: duplicate some structs from newlib/libc/posix/posix_spawn.c */
> >
> > That would be better defined in a common newlib header.
> 
> Is there some precendent on how to handle an "internal" header shared
> between newlib and cygwin, but not a "public" header to be installed?

Yes, search the cygwin sources for "setlocale.h".


Corinna

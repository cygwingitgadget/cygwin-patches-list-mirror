Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 047363858D20; Mon, 28 Oct 2024 12:03:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 047363858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730116990;
	bh=nkjcbiLpXJwczTXZ2tSRP37j5Gn5ZEjRuIYxSBmeL20=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ksuC0V0QNrRPQE/HijblRCflXTn/l0V7wgCsXmNqrtMiz4W3rJAiaY3Q2BXx18RPc
	 S+mloXB3VdNRYhMZhQZmzN9bvVj+hAjqsWbDq48g8P+RtxDIJJ8myM3tyBU+SKn3VM
	 5s+BJ6OMDaUtznOJS9s3CsV5zk3RwgAtKp1kLunA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D72C9A80A36; Mon, 28 Oct 2024 13:03:07 +0100 (CET)
Date: Mon, 28 Oct 2024 13:03:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-ID: <Zx99e_o0S_TZtS9y@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
 <Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
 <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
 <ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
 <20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
 <Zx9fk6yQ1etCVwek@calimero.vinschen.de>
 <20241028203019.4158316e34926d1afc6fa3cf@nifty.ne.jp>
 <Zx98wR12dIyVNXZ0@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zx98wR12dIyVNXZ0@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Oct 28 13:00, Corinna Vinschen wrote:
> On Oct 28 20:30, Takashi Yano wrote:
> > > > Please try:
> > > > $ ./a.out `expr 65536 - 4096 + 543` 1
> > > > pipe capacity: 65536
> > > > write: writable 1, 61983 3553
> > > > write: writable 0, 543 3010
> > > > write: writable 0, 543 2467
> > > > write: writable 0, 543 1924
> > > > write: writable 0, 543 1381
> > > > write: writable 0, 543 838
> > > > write: writable 0, 543 295
> > > > write: writable 0, -1 / Resource temporarily unavailable
> > 
> > The above case was result in Linux environment.
> > 
> > > > $ ./a.out `expr 65536 - 4096 + 1234` 1
> > > > pipe capacity: 65536
> > > > write: writable 1, 62674 2862
> > > > write: writable 0, 1234 1628
> > > > write: writable 0, 1234 394
> > > > write: writable 0, -1 / Resource temporarily unavailable
> > 
> > This also is the result in Linux environment.
> 
> Ah, ok.  It's a result of the computations for reusing buffer pages vs.
> skipping to new ones to allow as much aligned writes as possible. 

> of comments.

Sorry, copy/paste leftover, just ignore.

> We cant't follow this behaviour.
> 
> 
> Corinna

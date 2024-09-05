Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4AAB83858C32; Thu,  5 Sep 2024 15:38:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4AAB83858C32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1725550693;
	bh=H5CPivWTiuaGbKFKA5vKH5/0kba/YClSBWDnDub7Lhk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=I9gKJGhYH1vfsL9ngNOEugk9ljhw3sqCoZlRbxLl9JVebQCq48p+ca+Aj54DuIpNj
	 wBdfiEJCsJaJSua+d9QoyjSbFxE9HWekelBzGt30Ll+8kvzNBRcVNdh56901Dmb+xV
	 ytZG+KX+TQV4LPDHS4T6NQX3k6tjkCq1c/SHtq6o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 21799A80E7B; Thu,  5 Sep 2024 17:38:11 +0200 (CEST)
Date: Thu, 5 Sep 2024 17:38:11 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-ID: <ZtnQY6Cxf_6Bbo6Q@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
 <ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
 <a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
 <20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
 <20240902233313.171fb48cc8243cd095d7280f@nifty.ne.jp>
 <20240905221841.002f3f6fa53baa468b0cd136@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905221841.002f3f6fa53baa468b0cd136@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

I think you should push your original patch to the 3.5 branch for now,
and we test the big change in the main branch first.


Thanks,
Corinna


On Sep  5 22:18, Takashi Yano wrote:
> Hi Corinna, Ken and Johannes
> 
> On Mon, 2 Sep 2024 23:33:13 +0900
> Takashi Yano wrote:
> > On Mon, 2 Sep 2024 22:50:45 +0900
> > Takashi Yano wrote:
> > > On Mon, 2 Sep 2024 14:48:35 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > > I have tested it and the symptom is addressed.
> > > 
> > > Thanks for testing.
> > > 
> > > > I do have to wonder whether it is intentional that calling
> > > > `set_pipe_non_blocking(false)` followed by `set_pipe_non_blocking(true)`
> > > > on an originally-non-blocking pipe will "restore" it to blocking mode,
> > > > though.
> > > 
> > > I'm not sure how such symptom occurs.
> > > 
> > > Calling `set_pipe_non_blocking(true)` on an originally-non-blocking pipe
> > > will set `was_blocking_read_pipe` to false.
> > > 
> > > Furthermore, regardless of the value of `was_blocking_read_pipe`, calling
> > > set_pipe_non_blocking(false) always sets the pipe blocking mode. It is not
> > > due to "restore" logic.
> > 
> > Ah...
> > However, if a cygwin app executes non-cygwin app and the non-cygwin app exits,
> > the read pipe remains on blocking mode. Then the cygwin app cannot handle
> > signal on blocking read() after that.
> > 
> > Let me consider...
> 
> I have submit a new patch for these issues.
> With this pathch the strategy of pipe read/write for blocking/non-blocking
> is re-designed. To eliminate toggling the pipe blocking mode, cygwin pipe
> is always blocking mode basically, and non-blocking mode is sumulated by
> raw_read() and raw_write().
> 
> The new patch will be posted shortly with subject:
> [PATCH] Cygwin: pipe: Switch pipe mode to blocking mode by defaut
> 
> What do you think of this idea?
> 
> -- 
> Takashi Yano <takashi.yano@nifty.ne.jp>

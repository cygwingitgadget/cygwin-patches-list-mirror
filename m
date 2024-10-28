Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8BB253858D20; Mon, 28 Oct 2024 11:54:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8BB253858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730116478;
	bh=beJH6CSdDRQbd5rCqnmGgicBm0iET/0Liqt3KzrtI80=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BORaG7KoIhdAV/5qWMOvhiKYYb2Ee46i427VSlLwmdRDNFLl296fzIra81dWNvKVH
	 cbDHbIoYxHr7s7BLZbZiB86ocin2idZIrDwdNj3CGDA6mZJOQAxqhJWwc3T9ZGnrgu
	 yKlYe4YqzzkNz2MQBYU8gPOIeTXaOrBLKvGnLEr8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 59B2DA80A36; Mon, 28 Oct 2024 12:54:36 +0100 (CET)
Date: Mon, 28 Oct 2024 12:54:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-ID: <Zx97fDrEcVspfZ23@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
 <Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
 <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
 <ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
 <20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
 <Zx9fk6yQ1etCVwek@calimero.vinschen.de>
 <20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Oct 28 20:23, Takashi Yano wrote:
> Hi Corinna,
> 
> On Mon, 28 Oct 2024 10:55:31 +0100
> > So this should actually be:
> > 
> >   pipe capacity: 65536
> >   write: writable 1, 40000 25536
> >   write: writable 1, 24576 960
> >   write: writable 0, 512 448
> >   write: writable 0, 256 192
> >   write: writable 0, 128 64
> >   write: writable 0, 64 0
> >   write: writable 0, -1 / Resource temporarily unavailable
> > 
> > just as in the blocking case.
> 
> I have just tried commit 686e46ce714803f47d3183c954ceaf51976157cc,
> however the result is the same:
> CYGWIN_NT-10.0-19045 HP-Z230 3.6.0-dev-182-g686e46ce7148.x86_64 2024-10-28 11:17 UTC x86_64 Cygwin
> $ ./a.exe 40000 1
> pipe capacity: 65536
> write: writable 1, 40000 25536
> write: writable 1, 24576 960
> write: writable 0, -1 / Resource temporarily unavailable
> 
> What is wrong???

I really don't know. I just rebuilt 686e46ce7148 as well:

  CYGWIN_NT-10.0-22631 vmbert11 3.6.0-dev-182-g686e46ce7148.x86_64 2024-10-28 11:51 UTC x86_64 Cygwin
  $ ./x 40000 1
  pipe capacity: 65536
  write: writable 1, 40000 25536
  write: writable 1, 24576 960
  write: writable 0, 512 448
  write: writable 0, 256 192
  write: writable 0, 128 64
  write: writable 0, 64 0
  write: writable 0, -1 / Resource temporarily unavailable

Weird...


Corinna

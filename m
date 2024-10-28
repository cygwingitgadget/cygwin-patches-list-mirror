Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 21F3E3858D26; Mon, 28 Oct 2024 09:55:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 21F3E3858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730109334;
	bh=dIuh+xrWvdKKakdgscbuoo3O9Bg7VJBuGQxPVesMMGk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=j+O+4gxZbwk7LY6f6qAK/8FSg6QuOMx286XmxUTXY6MVj8DFUb7CE79tQWMC1GJtv
	 2CRAdRrBdAS/Nz9O2uEINqvP020UT/00BLvTzCW8m7jXP4duJ97rZcVpxiCZ2+951H
	 TiIB5Qmx9x327bnI74DqErx98HE//OW5SgvU5Rww=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8F8BAA80A36; Mon, 28 Oct 2024 10:55:31 +0100 (CET)
Date: Mon, 28 Oct 2024 10:55:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-ID: <Zx9fk6yQ1etCVwek@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
 <Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
 <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
 <ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
 <20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Oct 27 17:57, Takashi Yano wrote:
> Hi Corinna,
> 
> On Thu, 24 Oct 2024 12:21:04 +0200
> Corinna Vinschen wrote:
> > > > Before:
> > > > 
> > > >   $ ./x 40000
> > > >   pipe capacity: 65536
> > > >   write: writable 1, 40000 25536
> > > >   write: writable 1, 24576 960
> > > >   write: writable 0, 512 448
> > > >   write: writable 0, 256 192
> > > >   write: writable 0, 128 64
> > > >   write: writable 0, 64 0
> > > >   write: writable 0, -1 / Resource temporarily unavailable
> > > > 
> > > > After:
> > > > 
> > > >   $ ./x 40000
> > > >   pipe capacity: 65536
> > > >   write: writable 1, 40000 25536
> > > >   write: writable 1, 25536 0
> > > >   write: writable 0, -1 / Resource temporarily unavailable
> > > > 
> > > > This way, we get into the EAGAIN case much faster again, which was
> > > > one reason for 170e6badb621.
> > > > 
> > > > Does this make more sense, and if so, why?  If this is really the
> > > > way to go, the comment starting at line 634 (after applying your patch)
> > > > will have to be changed as well.
> > > 
> > > Perhaps, I did not understand intent of 170e6badb621. Could you please
> > > provide the test program (./x)? I will check my code.
> > 
> > I attached it.  If you call it with just the number of bytes per write,
> > e.g. `./x 12345', the writes are blocking.  If you add another parameter,
> > e.g. `./x 12345 1', the writes are nonblocking.
> 
> Thanks for the test case.
> I think I could restore the previous behaviour. Please try v9 patch.
> 
> CYGWIN_NT-10.0-19045 HP-Z230 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin
> $ ./a.exe 40000 1
> pipe capacity: 65536
> write: writable 1, 40000 25536
> write: writable 1, 24576 960
> write: writable 0, -1 / Resource temporarily unavailable
> 
> Just after the commit 170e6badb621 (master branch)

Oops.  You tested in the wrong spot.  The original patch wasn't quite
polished, the followup patches 1ed909e047a2 and 686e46ce7148 are also
required to show the intended behaviour, and the intended behaviour is
the same in the blocking and non-blocking case...

> $ ./a.exe 40000 1
> pipe capacity: 65536
> write: writable 1, 40000 25536
> write: writable 1, 24576 960
> write: writable 0, -1 / Resource temporarily unavailable

So this should actually be:

  pipe capacity: 65536
  write: writable 1, 40000 25536
  write: writable 1, 24576 960
  write: writable 0, 512 448
  write: writable 0, 256 192
  write: writable 0, 128 64
  write: writable 0, 64 0
  write: writable 0, -1 / Resource temporarily unavailable

just as in the blocking case.

The ideal commit for testing the intendend behaviour is f78009cb1ccf,
because that's your regression fix slowing down writes.

As I wrote in the commit message of 170e6badb621, the idea is to defer
EAGAIN/EINTR when the write buffer starts to be filled up. 

The code I came up with does NOT resemble Linux closely, because the way
Linux pipe buffers work is by some simple but fast paging mechanism,
which may even lead to pipes being smaller than PIPE_BUF.  Nevertheless,
except in some border cases, Linux often still returns some non-0 value
when our former code already returned EAGAIN/EINTR.

While this was mainly a problem in the blocking case, I thought the
buffer usage computation should be identical between blocking and
non-blocking, just as on Linux.

> Please try:
> $ ./a.out `expr 65536 - 4096 + 543` 1
> pipe capacity: 65536
> write: writable 1, 61983 3553
> write: writable 0, 543 3010
> write: writable 0, 543 2467
> write: writable 0, 543 1924
> write: writable 0, 543 1381
> write: writable 0, 543 838
> write: writable 0, 543 295
> write: writable 0, -1 / Resource temporarily unavailable

The intended behaviour (after commit 686e46ce7148) is:

  pipe capacity: 65536
  write: writable 1, 61983 3553
  write: writable 0, 2048 1505
  write: writable 0, 1024 481
  write: writable 0, 256 225
  write: writable 0, 128 97
  write: writable 0, 64 33
  write: writable 0, 32 1
  write: writable 0, -1 / Resource temporarily unavailable

> $ ./a.out `expr 65536 - 4096 + 1234` 1
> pipe capacity: 65536
> write: writable 1, 62674 2862
> write: writable 0, 1234 1628
> write: writable 0, 1234 394
> write: writable 0, -1 / Resource temporarily unavailable

And here:

  pipe capacity: 65536
  write: writable 1, 62674 2862
  write: writable 0, 2048 814
  write: writable 0, 512 302
  write: writable 0, 256 46
  write: writable 0, 32 14
  write: writable 0, 8 6
  write: writable 0, 4 2
  write: writable 0, 2 0
  write: writable 0, -1 / Resource temporarily unavailable

And if somebody has a better idea instead of the "next-less-power-of-2"
writing, I'm all ears. We can always come up with another method, as
long as it's the same usage in the blocking and non-blocking case.


Thanks,
Corinna

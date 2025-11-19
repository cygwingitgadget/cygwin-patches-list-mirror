Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ABEAC384D168; Wed, 19 Nov 2025 09:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ABEAC384D168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763543447;
	bh=6UOUc/qvS0kvOGuc625UQBZS+d8F+dddNAnYz+VkkqY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OL3L4g6E+L9Gc69sZREdPSFhIskjUNcqV6wcy85AlhsgTe3jQ1Sa6eE4UW/4j3VT1
	 neSEgVMIU13KyK8mUY0qVmKCjw30Jk9iWknsJubzEPAUpDJcznSBiB4PijGbPlStQb
	 HL0USUlfdy0zOgvbJt83TXB5+L/DIM3BhRz9D6mI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9D10BA80BEF; Wed, 19 Nov 2025 10:10:45 +0100 (CET)
Date: Wed, 19 Nov 2025 10:10:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Simplify creating invisible console
Message-ID: <aR2JlenfzUFMI3Kp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251118124034.1097179-1-corinna-cygwin@cygwin.com>
 <20251119173807.1e541c0a8853a2880d00cfa9@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119173807.1e541c0a8853a2880d00cfa9@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 19 17:38, Takashi Yano wrote:
> On Tue, 18 Nov 2025 13:40:32 +0100
> Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > Starting with Windows 11 24H2, the new function AllocConsoleWithOptions()
> > introduces what we're desperately missing since Windows 95: a simple
> > call to create an invisible console.
> > 
> > Reintroduce the old fhandler_console::create_invisible_console method we
> > have been using once up to Windows Vista, and use it now to call
> > AllocConsoleWithOptions() on systems supporting this shiny new function.
> > 
> > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > 
> > Corinna Vinschen (2):
> >   Cygwin: wincap: add wincap entry for Windows 11 24H2
> >   Cygwin: console: (re-)introduce simple creation of invisible console
> > 
> >  winsup/cygwin/autoload.cc               |  1 +
> >  winsup/cygwin/fhandler/console.cc       | 21 ++++++++++++--
> >  winsup/cygwin/local_includes/fhandler.h |  1 +
> >  winsup/cygwin/local_includes/wincap.h   |  2 ++
> >  winsup/cygwin/wincap.cc                 | 37 ++++++++++++++++++++++++-
> >  5 files changed, 58 insertions(+), 4 deletions(-)
> 
> Both patch LGTM. I also confirmed that new create_invisible_console
> works fine in Win11 25H2.
> 
> Thanks!

Thanks for the review! Pushed.


Corinna

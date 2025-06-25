Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7B7773858039; Wed, 25 Jun 2025 11:36:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7B7773858039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750851377;
	bh=goUyzYkXupxNZMqxR4y6HOcjJUmoRY7jz0kLuhgqPiY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kga9NAqQir1brsIOiguo/KRw4KZ+N88ZCH6NsIuoyUNF88bTjo/Ist5+NjC2v6hm8
	 jbbIcw/8B1tsx3YL9S2z7qNtevVKOZjdY+Qx5d2A6tFygvlxUaydBSgKe5WAu5TXEs
	 OAGN4b63kjOlGHic6JEkhf6GNouh5LbYJfycpXB8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 35C33A80E29; Wed, 25 Jun 2025 13:36:15 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:36:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: signal: Do not suspend myself and use VEH
Message-ID: <aFvfL9Vz8mKQiVwF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250623205707.1387-1-takashi.yano@nifty.ne.jp>
 <aFpbgHpjSYkgPGGI@calimero.vinschen.de>
 <20250625195806.99522fb0d7b7f741760baf59@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625195806.99522fb0d7b7f741760baf59@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jun 25 19:58, Takashi Yano wrote:
> On Tue, 24 Jun 2025 10:02:08 +0200
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Jun 24 05:56, Takashi Yano wrote:
> > > After the commit f305ca916ad2, some stress-ng tests fail in arm64
> > > windows. There seems to be two causes for this issue. One is that
> > > calling SuspendThread(GetCurrentThread()) may suspend myself in
> > > the kernel. Branching to sigdelayed in the kernel code does not
> > > work as expected as the original _cygtls::interrup_now() intended.
> > > The other cause is, single step exception sometimes does not trigger
> > > exception::handle() for some reason. Therefore, register vectored
> > > exception handler (VEH) and use it for single step exception instead.
> > 
> > Patch LGTM, except that we have to link against another DLL now.
> > I searched for another way and it turns out there are equivalent
> > Rtl functions RtlWaitOnAddress/RtlWakeAddressSingle in ntdll.dll.
> > 
> > I pasted my tweak to your patch below, hope that's ok with you.
> 
> Thanks!
> 
> I tested your tweaked patch, and it works as expected.

Great, thanks!

> One thing I do not understand is, what is the last argument
> of RtlWaitOnAddress()? Is there any document about that?

It's the timeout value.  The same thing as with NtCreateTimer.
Compare with https://sourceware.org/cgit/newlib-cygwin/tree/winsup/cygwin/local_includes/cygwait.h#n36

Documentation is... rare. Very unfortunate.


Corinna

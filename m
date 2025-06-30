Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 81F663852129; Mon, 30 Jun 2025 09:55:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 81F663852129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751277300;
	bh=H2vj2XQhWtiUKTFUtU4QvmvRRkqcow5lyLpnXzCRYGk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=TquInyOQvStKRrJKPoE/aOqROuzcRunxxtFjeHVzFsbL34Cdx4mTHPLBaDWlgFCNw
	 Q6R055B/qyhGpnO/CcC9Q87aC4ARHO0pQr3w5GuoIjzNaoLMs9OtzLx+IRSsRyReCi
	 b/fNQvyuEnZyGwk4Ix9QOiWNIE0QonCaPpSeni+o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 643F5A80B7A; Mon, 30 Jun 2025 11:54:58 +0200 (CEST)
Date: Mon, 30 Jun 2025 11:54:58 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <aGJe8j_E8aitHVoE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cb938c47-80dd-78c6-876f-7a36112960af@jdrake.com>
 <aF59GwzNozRYeAp4@calimero.vinschen.de>
 <aF6Qoq0yXMg4z3Jo@calimero.vinschen.de>
 <e3b78bde-3b2e-cdc8-0319-fda17c47579e@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3b78bde-3b2e-cdc8-0319-fda17c47579e@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 27 16:32, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 27 13:14, Corinna Vinschen wrote:
> > > On Jun 26 16:55, Jeremy Drake via Cygwin-patches wrote:
> > > > stdin and stdout were alreadly allowed for popen, but implementing
> > > > posix_spawn in terms of spawn would require stderr as well.
> > > >
> > > > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > > > ---
> > > >  winsup/cygwin/dcrt0.cc                    | 2 ++
> > > >  winsup/cygwin/local_includes/child_info.h | 6 +++---
> > > >  winsup/cygwin/spawn.cc                    | 5 +++--
> > > >  3 files changed, 8 insertions(+), 5 deletions(-)
> > >
> > > LGTM.  A sentence on why we can actually use the filler bytes now
> > > wouldn't hurt in the commit message.
> >
> > ....or rather...
> >
> > > int worker (const char *, const char *const *, const char *const [],
> > > -                    int, int = -1, int = -1);
> > > +                    int, int = -1, int = -1, int = -1);
> >
> > ....maybe this should actually get an array of three descriptors,
> > rather than getting one additional argument per descriptor, i.e.
> >
> >   int worker (const char *, const char *const *, const char *const [],
> >   -                    int, int = -1, int = -1);
> >   +                    int, int[3]);
> >
> > There's no good reason for these default args anyway.
> 
> It's getting kind of silly how many args this function has.  The
> construction of this function (using placement new to reconstruct "this"
> inside worker) is kind of awkward for using members and setters (though
> this was done for the posix_spawn semaphore).  Might it make sense to pass
> a (pointer to a) struct/class instead?

Kind of like CreateProcess :}

But yeah. I'd suggets to keep the first three args (argc, argv, envp)
as they are and add a struct as arg 4. This way, all args are passed
through registers.

Thanks,
Corinna

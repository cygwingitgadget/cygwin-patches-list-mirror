Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2CF14385DDE3; Wed,  2 Jul 2025 10:47:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2CF14385DDE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751453249;
	bh=DjViUR993Q2LY8lY7MpQ9k/+adDbMNkivYgfsIAoaFg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=gSBtYukHokLUj/wiFPU1qKBq5ecqFtDvix4f34i3vI8YazQbvutn5vBiZUPvnMsTa
	 7OjZKSvu7UJvo1FBlaJgpqAfdluJYO0gfjARv9SxEgr1/0YJ6sHgUDwwJbfjUUU6Tx
	 Tgq5iFjYA42rey8tg0UoyRDeqjkT657LGE4PFv68=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D822DA80CFD; Wed, 02 Jul 2025 12:47:26 +0200 (CEST)
Date: Wed, 2 Jul 2025 12:47:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <aGUOPvEQJSiWiSN8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cb938c47-80dd-78c6-876f-7a36112960af@jdrake.com>
 <aF59GwzNozRYeAp4@calimero.vinschen.de>
 <aF6Qoq0yXMg4z3Jo@calimero.vinschen.de>
 <e3b78bde-3b2e-cdc8-0319-fda17c47579e@jdrake.com>
 <aGJe8j_E8aitHVoE@calimero.vinschen.de>
 <6d39964a-ca56-e76c-0076-90ed7694aa73@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d39964a-ca56-e76c-0076-90ed7694aa73@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 30 12:18, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 30 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 27 16:32, Jeremy Drake via Cygwin-patches wrote:
> > > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> > >
> > > It's getting kind of silly how many args this function has.  The
> > > construction of this function (using placement new to reconstruct "this"
> > > inside worker) is kind of awkward for using members and setters (though
> > > this was done for the posix_spawn semaphore).  Might it make sense to pass
> > > a (pointer to a) struct/class instead?
> >
> > Kind of like CreateProcess :}
> >
> > But yeah. I'd suggets to keep the first three args (argc, argv, envp)
> > as they are and add a struct as arg 4. This way, all args are passed
> > through registers.

...which is wrong of course.  "this" is arg 1, so only three more args
can be passed in registers on x86_64.

> darn, one too many args (mode) so that most callers could not need to use
> the struct.  I'd suggest moving mode to the front and putting envp in the
> struct, but all existing callers do pass envp (it seems the various exec*
> and spawn* variants all funnel down to one that passes environment).
> Could pack both argc and mode into one 64-bit arg, but that's too ugly to
> seriously consider.

Indeed.  We will have to live with at least one arg on the stack or a
pointer to a struct which also takes argc, argv and stuff, but the
downside of this is that it gets confusing easily.

So yeah, I wonder if something like this works and is sufficiently
readable...

child_info_spawn::worker (const char *prog_arg, int mode,
			  kindoflike_create_process_args *spawn_args)


Corinna

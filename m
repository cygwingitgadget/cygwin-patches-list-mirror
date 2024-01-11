Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DCB1A3857736; Thu, 11 Jan 2024 09:42:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DCB1A3857736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1704966138;
	bh=N5r/9HxcQJ2M3nIxjL4NmUmJQUFaX3INlwi0sdI9R/8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=w51rM/W72xuFF7j4jWevnJhUvpHrFTtMHldtgdJW/g56+nVlUkj8tJxbVKSBm2/06
	 IMQmVpUonCMpvqqZwMGZGwWA8LorjBgMl1tVx+YBwaNUbF4zrpVa8Lemrv5hvtwr8L
	 LjUhsipUD+VrP3k3R8gNtyLIiz2PLO+F/5HlBpCs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C0608A80871; Thu, 11 Jan 2024 10:42:14 +0100 (CET)
Date: Thu, 11 Jan 2024 10:42:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <ZZ-39tW-1UK-69eD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240110135705.557-1-jon.turney@dronecode.org.uk>
 <20240110135705.557-2-jon.turney@dronecode.org.uk>
 <ZZ64BtnmZtmyRZYi@calimero.vinschen.de>
 <b1cbea19-824e-4763-ad69-f634beb0c081@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1cbea19-824e-4763-ad69-f634beb0c081@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 17:38, Jon Turney wrote:
> On 10/01/2024 15:30, Corinna Vinschen wrote:
> > On Jan 10 13:57, Jon Turney wrote:
> [...]
> > > 
> > > Also: Fix the (deprecated) cygwin_dumpstack() function so it will now
> > > write a .stackdump file, even when ulimit -c is zero. (Note that
> > > cygwin_dumpstack() is still idempotent, which is perhaps odd)
> > 
> > Given it's deprecated and not exposed in the headers, and given
> > we only still need the symbol for backward compat, how about making
> > this function a no-op instead?
> 
> We still need the function internally to write stackdumps.

Oh, right, I missed the usage in api_fatal.  I was only talking
about the exported function, or rather, the fact that it's exported.
We could split it in internal and external function and...

> I know it's use has long been discouraged, but doing a GitHub code search
> does find some uses of it.  What is the suggested replacement?

...doing nothing in the exported function was the idea.  There appear to
be a handful of projects on github though, which call it.  Not sure it's
the right thing to do, though.  External code should better raise a
signal in this case.

However, if we take it as given, and if external code calls
cygwin_stackdump, do we really want it to create a stackdump, or
shouldn't the behaviour be the same as if a core-creating signal has
been raised?  See below.

> (I'm also wondering if the idempotency is in the wrong place.  Is it
> possible for signal_exit() get called by multiple threads?  In which case it
> probably needs to do something sane in that case)

signal_exit is only called from sigpacket::process, and this method
in turn is only called from the wait_sig function, so it's only
called from the signal thread.

I just wonder if we really want to create a stackdump unconditionally
at all, after introducing corefile support and handling ulimit the
way you do it.

I.e., we have (basically) three situations:

- A core-creating signal has been raised
- api_fatal calls cygwin_stackdump
- External code calls cygwin_stackdump

Wouldn't it make sense to handle them equally, depending on
the ulimit settings?

> > Can't this be done by adding the max size as parameter to dumper?
> > 
> 
> Maybe. That would make forward/backwards compatibility problems when mixing
> dumper and cygwin versions.

How's that supposed to happen?  dumper is part of the Cygwin package,
so, together with using the right absolute path, there's no way to
use the wrong dumper version.  If so, it's certainly an SEP.

> I don't think we can control the size of the file as we write it, we'd need
> to check afterwards if it was too big, and then remove/truncate.
> 
> And we need to do the same action for stackdumps, so I think it makes more
> sense to do that checking in the DLL.

I see.  It's a bit unfortunate though, if dumper tries to create
a 2 Gigs file which is later truncated, if we're low on disk space.
But yeah, disk space isn't much of a problem these days, I guess...

> [...]
> > > diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
> > > index 008854a07..dca5c5db0 100644
> > > --- a/winsup/cygwin/environ.cc
> > > +++ b/winsup/cygwin/environ.cc
> > > @@ -832,6 +832,7 @@ environ_init (char **envp, int envc)
> > >       out:
> > >         findenv_func = (char * (*)(const char*, int*)) my_findenv;
> > >         environ = envp;
> > > +      dumper_init ();
> > 
> > Sorry, but I don't quite understand why dumper_init is called so early
> > and unconditionally.  Why not create the command on the fly?
> 
> For the same reason we create the error_start debugger command at process
> initialisation.
> 
> If I had to guess, that's because calling malloc() when we're in the middle
> of crashing may not be very reliable.
> 
> (of course, we go on to ruin this attention to detail by calling
> small_printf to append the Windows PID during exec_prepared_command(), even
> though we also knew that at process startup)
> 
> [...]
> > > -extern "C" void
> > > -error_start_init (const char *buf)
> > > +static void
> > > +command_prep (const char *buf, PWCHAR *command)
> > >   {
> > > -  if (!buf || !*buf)
> > > -    return;
> > > -  if (!debugger_command &&
> > > -      !(debugger_command = (PWCHAR) malloc ((2 * NT_MAX_PATH + 20)
> > > -					    * sizeof (WCHAR))))
> > > +  if (!*command &&
> > > +      !(*command = (PWCHAR) malloc ((2 * NT_MAX_PATH + 20)
> > > +				    * sizeof (WCHAR))))
> > 
> > Not your fault, but the length of this string must not exceed 32767 wide
> > chars, incuding the trailing \0 per
> > https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessw
> > The only reason I can see for using these large arrays is to avoid
> > length checks.
> > 
> > We could get away with two static 64K pages for debugger_command and
> > dumper_command.  Or even with one if we just copy the required stuff
> > into the single debugger_command array when required.  That would also
> > drop the requirement for the extra allocation in initial_env().
> 
> Well, it's garbage anyhow because we can calculate the exact size of the
> output before we do the allocation, which is presumably usually much less.

Good point.  Either way, static space would drop the malloc/HeapAlloc
stuff entirely.


Thanks,
Corinna

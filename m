Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5F3C93858CD9; Tue, 18 Mar 2025 19:23:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F3C93858CD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742325833;
	bh=Gj2LE9HR2DxVqsKhjJ5XLqO7IxJomPzwvcEV31J+Qp8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=xndx/EaKrasoX7Eqavw2HX/hn5AsM2nSsHBy2vCXwtqZJLxVghdswisBe5+9XnUAm
	 hKZj7sV3b6imVn2vNdZ17ZcU1u2zoHuNh++aeCdPRliPq0cZTy7S8pLY9KhlAylw2b
	 UAWoHHUzCdMChN3C8qFMC0ZsHotmzduDRPKd5Tko=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CA59EA8098D; Tue, 18 Mar 2025 20:23:50 +0100 (CET)
Date: Tue, 18 Mar 2025 20:23:50 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
Message-ID: <Z9nIRlpIEfAbNoJ2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
 <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com>
 <Z9k9OcYu5Y47VsjU@calimero.vinschen.de>
 <e63f40de-faf7-2187-9f13-7bce6f7d7238@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e63f40de-faf7-2187-9f13-7bce6f7d7238@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 18 10:45, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 18 Mar 2025, Corinna Vinschen wrote:
> 
> > On Mar 17 17:39, Jeremy Drake via Cygwin-patches wrote:
> > > Since you kind of asked, here's a proof-of-concept that uses udis86 (I
> > > left a whole bunch of pointer<->integer warnings since this is a PoC).
> > > Tested on windows 11 and 8:
> >
> > Cool.  I like the idea.  But obviously, this can't make it into 3.6
> > anymore.
> 
> Right.  So the next thing to figure out is how to include udis86.  It is
> BSD 2-clause license, so that should be fine.  The way I see it, we could
> either static link it from a Cygwin/MSYS2 package, or vendor it.  I keep
> coming back to vendoring, there has not been any activity on the
> repository in years, there are only a few source files in the library part
> of the code, and of them several can be left out because we aren't
> intending to generate disassembly text output.  There is also a
> "standalone mode" macro that gets defined if built as part of the Linux
> kernel, which suggests we can define that if inside Cygwin also.  We can
> also reduce the size impact by removing/disabling the mappping of
> instruction mnemonic enum to string since we won't need that either.
> 
> If I want to try that, would it make more sense to drop these files in a
> subdirectory of winsup/cygwin, or winsup, or somewhere else?

Subdir of winsup/cygwin, probably.  What I'm most curious about is the
size it adds to the DLL.  I wonder if, say, an extra 32K is really
usefully spent, given it only checks a small part of ntdll.dll, and only
once per process tree, too.

> Should I be moving this discussion to cygwin-developers?  (that list
> doesn't seem to get much action, and the last time I used it I got
> redirected to the cygwin list).

We can discuss this on cygwin-developers.  It's pretty underused these
days.

That reminds me, I think we could use it for collecting ideas for 3.7 as
well.  There's a bit of stuff in the latest POSIX-1.2024 which might be
nice in Cygwin, too.


Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 004AA3857C78; Fri, 21 Mar 2025 10:21:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 004AA3857C78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742552510;
	bh=I+DI/x/3JlnyjxA4c3kZQrh1mQs9RdTJcp4Si2JKQtE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=vW799qZ4Df0AJtUsGRSCcP7VvsXY3zB+DnWMhIfP5WZNudt3EGYCHCp5x9sOYwJsb
	 e0kxKciIvUOPc7YJRdH0Ks6hYtIW8O70+A/YKyCBeeMUVIwPzdBP7f2phKKt6rGrAV
	 GasKS/05ZnXsJEbhvb7NkZkl3misGCf3n8qoGLWs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BE1DFA804D5; Fri, 21 Mar 2025 11:21:47 +0100 (CET)
Date: Fri, 21 Mar 2025 11:21:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Use udis86 to walk x64 machine code in find_fast_cwd_pointer
Message-ID: <Z909u65b6xoM3AUN@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
 <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com>
 <Z9k9OcYu5Y47VsjU@calimero.vinschen.de>
 <e63f40de-faf7-2187-9f13-7bce6f7d7238@jdrake.com>
 <Z9nIRlpIEfAbNoJ2@calimero.vinschen.de>
 <5097ccfa-83f6-c76e-6c59-28c876cc2db8@jdrake.com>
 <Z9wgTR92yo4P24Ze@calimero.vinschen.de>
 <Z9wgpVqrlTML8Mq7@calimero.vinschen.de>
 <62ec041c-a21c-2a38-4bf6-3853b504057d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62ec041c-a21c-2a38-4bf6-3853b504057d@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 20 13:01, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 20 Mar 2025, Corinna Vinschen wrote:
> 
> > On Mar 20 15:03, Corinna Vinschen wrote:
> > > On Mar 18 22:11, Jeremy Drake via Cygwin-patches wrote:
> > > > On Tue, 18 Mar 2025, Corinna Vinschen wrote:
> > > >
> > > > > Subdir of winsup/cygwin, probably.  What I'm most curious about is the
> > > > > size it adds to the DLL.  I wonder if, say, an extra 32K is really
> > > > > usefully spent, given it only checks a small part of ntdll.dll, and only
> > > > > once per process tree, too.
> > > >
> > > > I did this with msys-2.0.dll, but it shouldn't matter as a delta.
> > > > all are stripped msys-2.0.dll size
> > > > start:
> > > > 3,246,118 bytes
> > > > with udis86 vendored, but not called:
> > > > 3,247,142 bytes
> > > > with find_fast_cwd_pointer rewritten to use udis86:
> > > > 3,328,550 bytes
> > > >
> > > > (I know the second one isn't realistic, the linker could exclude unused
> > > > code, I was just kind of curious)
> > > >
> > > > This is with all the "translate to assembly text, intel or at&t syntax"
> > > > and "table of strings for opcodes" stuff removed to try to save space,
> > > > still a net increase of 82,432 bytes.
> > >
> > > The DLL has currently a size of 3 Megs, optimzed, stripped.  82K are
> > > two more allocation granularity slots, 51 instead of 49, about 2%.
> >
> > 4!  4%.  I said 4%, right?
> >
> > *facepalm*
> 
> I'll take that as "patches welcome" :)  I'd also like to take the
> opportunity to add ARM64 support based on my PoC, but I feel bad about
> dropping another blob of code into path.cc.  Would it make sense to rename
> to find_fast_cwd_pointer_x64, move it into a separate source file, and add

find_fast_cwd_pointer_x86_64

> another source file for find_fast_cwd_pointer_arm64?  Or I guess put both

find_fast_cwd_pointer_aarch64

We should use the offical tags, not the Windows ones.  It's ok for the
uname output, but other than that...

> into a fastcwd.cc and #ifdef __x86_64__ the x64 variant (that will of
> course always be true at this point)?

A new fastcwd.cc would make sense.  Theoretically the aarch64 code
should go into an aarch64 subdir, just as with the x86_64 subdir,
but I guess this is handling the AMD64 on ARM64 emulation rather than
the native ARM64 mode?  Will there be any difference between the two
later on if we start supporting native ARM64?  If so, the name
of the function should probably express this.


Thanks,
Corinna

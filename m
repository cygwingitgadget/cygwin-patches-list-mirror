Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A4AE6385840D; Thu, 20 Mar 2025 14:03:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A4AE6385840D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742479439;
	bh=HyrYTouAk0WR8a3wBmXe/zdvk+OeIvKIeMSma65E1UI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KKajeMW1wycqHlCzGIH17QpIaReLtC1sYCHNXYl05+XzhyA1ChZvhdcDB5FDB8L5h
	 kKowULu5A7E34N242Vis720/llDM5gwd+ehufI7xf3Hz2dVMqBMzo2Yxe97j4OkWG1
	 2pFvnCl1p8zSMqVG7QkBPC+wSEJjWFhTpTU/gyLg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6A404A804B1; Thu, 20 Mar 2025 15:03:57 +0100 (CET)
Date: Thu, 20 Mar 2025 15:03:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Use udis86 to walk x64 machine code in find_fast_cwd_pointer
Message-ID: <Z9wgTR92yo4P24Ze@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
 <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com>
 <Z9k9OcYu5Y47VsjU@calimero.vinschen.de>
 <e63f40de-faf7-2187-9f13-7bce6f7d7238@jdrake.com>
 <Z9nIRlpIEfAbNoJ2@calimero.vinschen.de>
 <5097ccfa-83f6-c76e-6c59-28c876cc2db8@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5097ccfa-83f6-c76e-6c59-28c876cc2db8@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 18 22:11, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 18 Mar 2025, Corinna Vinschen wrote:
> 
> > Subdir of winsup/cygwin, probably.  What I'm most curious about is the
> > size it adds to the DLL.  I wonder if, say, an extra 32K is really
> > usefully spent, given it only checks a small part of ntdll.dll, and only
> > once per process tree, too.
> 
> I did this with msys-2.0.dll, but it shouldn't matter as a delta.
> all are stripped msys-2.0.dll size
> start:
> 3,246,118 bytes
> with udis86 vendored, but not called:
> 3,247,142 bytes
> with find_fast_cwd_pointer rewritten to use udis86:
> 3,328,550 bytes
> 
> (I know the second one isn't realistic, the linker could exclude unused
> code, I was just kind of curious)
> 
> This is with all the "translate to assembly text, intel or at&t syntax"
> and "table of strings for opcodes" stuff removed to try to save space,
> still a net increase of 82,432 bytes.

The DLL has currently a size of 3 Megs, optimzed, stripped.  82K are
two more allocation granularity slots, 51 instead of 49, about 2%.
So in reality you probably won't notice a difference in loading time
or memory pressure.

>   /* Next we search for the locking mechanism and perform a sanity check.
>      On Pre- (or Post-) Windows 8 we basically look for the
>      RtlEnterCriticalSection call.  Windows 8 does not call
>      RtlEnterCriticalSection.  The code manipulates the FastPebLock manually,
>      probably because RtlEnterCriticalSection has been converted to an inline
>      function.  Either way, we test if the code uses the FastPebLock. */

We can throw anything related to pre-8.1 out of the Window, if it helps
to reduce the code.

Corinna

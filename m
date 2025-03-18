Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0DAB53858D29; Tue, 18 Mar 2025 09:30:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0DAB53858D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742290236;
	bh=QmKCaj+oYDCeEnQ+98Kt8hStLQpbXIOIIOV2ofMehe8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=pW/XNSqHyZVNc3n467G/TUe8/o5bvkOuToAm4DCxtjq9yLqKqZu/CiOW1snMURXN2
	 OcxE0xZiJYEBCksRIon0+29xL7p0FC6JjO1gPzrWlS0myAnEel5RYA6HJOZdobx4Av
	 yluu7pqubHNqp5uFEDmQZghesyH7aeMhJzDlWQ9I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 081D1A80846; Tue, 18 Mar 2025 10:30:34 +0100 (CET)
Date: Tue, 18 Mar 2025 10:30:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
Message-ID: <Z9k9OcYu5Y47VsjU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
 <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 17 17:39, Jeremy Drake via Cygwin-patches wrote:
> On Sat, 1 Mar 2025, Johannes Schindelin wrote:
> 
> > Note: In the long run, we may very well want to follow the insightful
> > suggestion by a helpful Windows kernel engineer who pointed out that it
> > may be less fragile to implement kind of a disassembler that has a
> > better chance to adapt to the ever-changing code of
> > `ntdll!RtlpReferenceCurrentDirectory` by skipping uninteresting
> > instructions such as `mov %rsp,%rax`, `mov %rbx,0x20(%rax)`, `push %rsi`
> > `sub $0x70,%rsp`, etc, and focuses on finding the `lea`, `call
> > ntdll!RtlEnterCriticalSection` and `mov ..., rbx` instructions, much
> > like it was prototyped out for ARM64 at
> > https://gist.github.com/jeremyd2019/aa167df0a0ae422fa6ebaea5b60c80c9
> 
> Since you kind of asked, here's a proof-of-concept that uses udis86 (I
> left a whole bunch of pointer<->integer warnings since this is a PoC).
> Tested on windows 11 and 8:

Cool.  I like the idea.  But obviously, this can't make it into 3.6
anymore.

As for the original patch, if a release of Windows comes out which
actually needs this change, we will certainly merge it into 3.6.x
bugfix releases, so there's no actual pressure to put it into 3.6.0.


Corinna

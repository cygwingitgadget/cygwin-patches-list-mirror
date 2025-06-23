Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A919C38693C9; Mon, 23 Jun 2025 07:12:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A919C38693C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750662767;
	bh=CX6g2th6sNygDlSnn3xG2yhkieYt6YEfNOcpF15QfMI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KBZkyklXiHCCyau6VqLFrrCAwbLqUQ0y606Fhvs4R3P0sjRegxBhAmZnGwzzRrNDt
	 B5SDvtJdT0zSFujxLSR/3ceV+2XH5A4xUvunPiN2azSstoDyMO/X3Gr2kX8ET+IUt4
	 0wexCWH2mWNTpnrFLhHVc1E1U6BkNw//kncruSs0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6F1E2A80846; Mon, 23 Jun 2025 09:12:45 +0200 (CEST)
Date: Mon, 23 Jun 2025 09:12:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: stack base initialization for
 AArch64
Message-ID: <aFj-bZ28sTEOvVqj@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
 <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com>
 <DB9PR83MB0923E495EA001D0887EC80469279A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923E495EA001D0887EC80469279A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 23 06:29, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Thank you for pointing this out. I didn't know this was related to ABI
> calling conventions in this particular case. Simple removal of the
> `sub` instruction is causing tests regressions in our development
> branch [...]

Just removing the sub expression seems wrong anyway because the code
would neglect to set the sp register, isn't it?


Thanks,
Corinna


> current upstream master branch (induced by recent changes to pthread).
> It will take some time to investigate and validate this change.
> 
> Thank you for your patience,
> 
> Radek
> 
> ________________________________________
> From: Jeremy Drake <cygwin@jdrake.com>
> Sent: Saturday, June 21, 2025 8:47 PM
> To: Radek Barton <radek.barton@microsoft.com>
> Cc: cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>
> Subject: [EXTERNAL] Re: [PATCH] Cygwin: stack base initialization for AArch64
>  
> On Wed, 18 Jun 2025, Jeremy Drake via Cygwin-patches wrote:
> 
> > On Wed, 18 Jun 2025, Radek Barton via Cygwin-patches wrote:
> >
> > > -#ifdef __x86_64__
> > >            /* Set stack pointer to new address.  Set frame pointer to
> > >               stack pointer and subtract 32 bytes for shadow space. */
> > > +#if defined(__x86_64__)
> > >            __asm__ ("\n\
> > >                     movq %[ADDR], %%rsp \n\
> > >                     movq  %%rsp, %%rbp  \n\
> > >                     subq  $32,%%rsp     \n"
> > >                     : : [ADDR] "r" (stackaddr));
> > > +#elif defined(__aarch64__)
> > > +         __asm__ ("\n\
> > > +                  mov fp, %[ADDR] \n\
> > > +                  sub sp, fp, #32 \n"
> >
> > Is the 32-byte shadow space part of the aarch64 calling convention spec,
> > or is this just copying what x86_64 was doing?  My impression is that this
> > space was part of the x86_64 calling convention.
> 
> The patch for pthread stack initialization dropped the 32-byte shadow
> space, and I believe this patch should as well.

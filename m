Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BE86E4BA2E3E; Thu,  9 Apr 2026 14:54:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BE86E4BA2E3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1775746492;
	bh=/6uGZoQBAZMM6CmVAJ+54VTpvOlscf58XSu8yYIrUjE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Jf2pnbcRcFHI0iIkjv+Dc/cvfLRKGPrpdTRXYavhPA8c3D8/wOkfvBMHwR2virVgG
	 aVVx8RRJxMCm3qo5gNpkgdFzerCg2kWN78DIFhTWc/1GPlnxi6y4UAA6rwEivRWJ84
	 YqeC56yWFjMOj/y/3SdurE7SY5NrKAXiZB664W00=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CEF05A80987; Thu, 09 Apr 2026 16:54:50 +0200 (CEST)
Date: Thu, 9 Apr 2026 16:54:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Evgeny Karpov <evgeny.karpov@arm.com>
Cc: cygwin-patches@cygwin.com, nd@arm.com
Subject: Re: [PATCH v3] Cygwin: SEH: Fix crash and handle second unwind phase
 on AArch64
Message-ID: <ade9ulHPRvekUycV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Evgeny Karpov <evgeny.karpov@arm.com>,
	cygwin-patches@cygwin.com, nd@arm.com
References: <adU95HxqoWa4xgSQ@arm.com>
 <adeVSHfhTSJYMjpj@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adeVSHfhTSJYMjpj@arm.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Evgeny,

On Apr  9 14:02, Evgeny Karpov wrote:
> On Tue, Apr 07, 2026, Corinna Vinschen wrote:
> > Hi Igor,
> > 
> > On Apr  7 17:24, Igor Podgainoi wrote:
> > > Hi Corinna,
> > > 
> > > On Mar 31 15:51, Corinna Vinschen wrote:
> > > > Do we actually *need* the .seh_code on x86_64, or would it be sufficient
> > > > to change this to .text for both targets?
> > > 
> > > No, as the SEH metadata is defined in the .text section just like the
> > > preceding code, there should be no functional difference between them
> > > on x86_64. As far as I can tell, this is largely a matter of style -
> > > for example, LLVM does not appear to reference .seh_code anywhere in
> > > its codebase.
> > > 
> > > The latest proposed AArch64 SEH implementation in binutils does not
> > > support the .seh_code directive at this stage.
> > > 
> > > As for the original reason for the introduction of this directive,
> > > the binutils commit 3c6256d29e2c528880a3cf8df43adf32c7780de5 from
> > > 2014-03-25 by Nick Clifton <nickc@redhat.com> explicitly states:
> > > > This is helpful because the code section may not be .text.
> > > 
> > > So it seems to have been initially used for convenience.
> > 
> > Thanks! Shall we just drop the SEH_CODE macro then, or should we 
> > keep it as is?  What do you think?
> 
> After some thinking on this topic, perhaps it makes sense to
> simplify portability by supporting .seh_code on AArch64.
> 
> The binutils-seh-v7 patch series
> https://sourceware.org/pipermail/binutils/2026-March/148657.html
> will be extended and .seh_code will be added to binutils-seh-v8.

That sounds great.  For the time being, I'll push your patch as is,
so you can just provide a followup patch reusing .seh_code for
aarch64 as well, as soon as we can provide a new binutils version.


Thanks!
Corinna

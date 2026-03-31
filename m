Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 87DC24B92095; Tue, 31 Mar 2026 17:41:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 87DC24B92095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774978913;
	bh=GSeP4GKNlblo+Og5ZySEdCWz1nOAT7qdu4YvDBOhJXo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JyU7aZraiAQAH179NNL13v+e8x1WFNxjETArcPTEGLvarDxX8hcejQMLLtLrfBrwL
	 XZhKINrsM7tXwki5aBd6OZyaWxBwQaRa2qTawC5SezXFVB3kPYY6XpsD1Yp6156E39
	 DW/IT0SmyQu2SDkPyctVXzVZqjGL++pK0r0ZVGrI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9CB0DA80667; Tue, 31 Mar 2026 19:41:51 +0200 (CEST)
Date: Tue, 31 Mar 2026 19:41:51 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Evgeny Karpov <evgeny.karpov@arm.com>
Cc: cygwin-patches@cygwin.com, nd@arm.com
Subject: Re: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Message-ID: <acwHX7mXkmLqoRlO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Evgeny Karpov <evgeny.karpov@arm.com>,
	cygwin-patches@cygwin.com, nd@arm.com
References: <cover.1774613608.git.igor.podgainoi@arm.com>
 <042c0cc99b70b4ec9959d4977b8cfcb224200bbb.1774613608.git.igor.podgainoi@arm.com>
 <aco1lg07YbVH7rVR@calimero.vinschen.de>
 <acv7F8ccSij6IVsi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acv7F8ccSij6IVsi@arm.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Evgeny,

On Mar 31 18:49, Evgeny Karpov wrote:
> On Mon, Mar 30, 2026, Corinna Vinschen wrote:
> > On Mar 27 12:43, Igor Podgainoi wrote:
> > > This patch adds the SEH_CODE macro (defined in exception.h), allowing
> > > a single EXCEPTION_HANDLER_DATA metadata definition to be used on both
> > > AArch64 and x86_64 architectures.
> > >
> > > It also fixes an issue related to stack replacement in _dll_crt0 that
> > > impacts SEH and signal handling, where due to an epilogue optimization
> > > on AArch64 the epilogue might appear before _main_tls->call. However,
> > > after the stack replacement this optimization becomes broken.
> >
> > Can you explain why this problem only affects aarch64 and not x86_64
> > as well?
> 
> It looks like the x86_64 epilogue is also optimized and appears before
> _main_tls->call.
> However, the x86_64 epilogue uses the shadow stack which was allocated after
> the stack replacement. It means if _dll_crt0 is modified, it might bring more
> operations for unwinding, and that might access the stack outside of the shadow
> space. It will lead to the same issue as on AArch64. Potentially, the compiler
> barrier should be enabled also on x86_64. And the shadow space concept does not
> apply to AArch64.

Thanks for the explanation, I think I see what you mean.  Right now we
subtract 16 bytes from the stacklimit as startaddress for the new stack,
see https://sourceware.org/cgit/newlib-cygwin/tree/winsup/cygwin/create_posix_thread.cc#n270

So... since we're setting up an entirely new stack anyway, would it
make sense to subtract, say, 256 bytes from the stack for both targets
instead of just the 16 bytes?  That way there should always be enough
space for the epilogue, isn't it?


Thanks,
Corinna

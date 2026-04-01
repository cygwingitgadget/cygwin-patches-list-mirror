Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 57A5D4BA23C0; Wed,  1 Apr 2026 18:29:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 57A5D4BA23C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1775068175;
	bh=cO7MfGfBHMEfgcqzg0eegWOnjVZfja4M7Z8ouXOGn9E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f9aVWq38SHdtga6deZLnEX99iftfFonQIVKOaPb1srIbxS5wNZU3Q+NdL3m1mgpR9
	 a5YqYyHuG64OUJ7DPYcn/ZgpA3G4a4dZFc2Jn70m3EmR3vfzZJ4fTQolBmIOit9o43
	 cemsFq2Xu/ueC47Cukeay4OxNGUF2yI/D5YRKVbY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2CAF9A80BB2; Wed, 01 Apr 2026 20:29:33 +0200 (CEST)
Date: Wed, 1 Apr 2026 20:29:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Evgeny Karpov <evgeny.karpov@arm.com>
Cc: cygwin-patches@cygwin.com, nd@arm.com
Subject: Re: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Message-ID: <ac1kDax3b-MmJSdB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Evgeny Karpov <evgeny.karpov@arm.com>,
	cygwin-patches@cygwin.com, nd@arm.com
References: <aco1lg07YbVH7rVR@calimero.vinschen.de>
 <ac08uYQWXPNTnsi3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac08uYQWXPNTnsi3@arm.com>
List-Id: <cygwin-patches.cygwin.com>

On Apr  1 17:41, Evgeny Karpov wrote:
> On Tue, Mar 31, 2026, Corinna Vinschen wrote:
> > On Mar 31 18:49, Evgeny Karpov wrote:
> > > On Mon, Mar 30, 2026, Corinna Vinschen wrote:
> > > > On Mar 27 12:43, Igor Podgainoi wrote:
> > > > > This patch adds the SEH_CODE macro (defined in exception.h), allowing
> > > > > a single EXCEPTION_HANDLER_DATA metadata definition to be used on both
> > > > > AArch64 and x86_64 architectures.
> > > > >
> > > > > It also fixes an issue related to stack replacement in _dll_crt0 that
> > > > > impacts SEH and signal handling, where due to an epilogue optimization
> > > > > on AArch64 the epilogue might appear before _main_tls->call. However,
> > > > > after the stack replacement this optimization becomes broken.
> > > >
> > > > Can you explain why this problem only affects aarch64 and not x86_64
> > > > as well?
> > > 
> > > It looks like the x86_64 epilogue is also optimized and appears before
> > > _main_tls->call.
> > > However, the x86_64 epilogue uses the shadow stack which was allocated after
> > > the stack replacement. It means if _dll_crt0 is modified, it might bring more
> > > operations for unwinding, and that might access the stack outside of the shadow
> > > space. It will lead to the same issue as on AArch64. Potentially, the compiler
> > > barrier should be enabled also on x86_64. And the shadow space concept does not
> > > apply to AArch64.
> > 
> > Thanks for the explanation, I think I see what you mean.  Right now we
> > subtract 16 bytes from the stacklimit as startaddress for the new stack,
> > see https://sourceware.org/cgit/newlib-cygwin/tree/winsup/cygwin/create_posix_thread.cc#n270
> 
> Hi Corinna,
> 
> The stack is also subtracted here
> https://sourceware.org/cgit/newlib-cygwin/tree/winsup/cygwin/dcrt0.cc#n1043
> 
> > So... since we're setting up an entirely new stack anyway, would it
> > make sense to subtract, say, 256 bytes from the stack for both targets
> > instead of just the 16 bytes?  That way there should always be enough
> > space for the epilogue, isn't it?
> 
> 
> It looks like 256 bytes will not solve the issue.
> It seems that after the stack replacement, it is not expected to return from _main_tls->call.
> Otherwise, with the broken stack after the replacement, it might crash.
> 
> The epilogue unwinds the prologue, and the stack might be significantly moved in the prologue.
> For instance, by allocating memory on stack.
> Event slight shifts on stack can impact the epilogue optimization when it appears before 
> _main_tls->call.
> This is why it is better to prevent the epilogue optimization in _dll_crt0 by a compiler 
> barrier after the stack replacement.
> 
> If the statement for no return is correct, another way to describe it is that the epilogue
> should never be called in _dll_crt0 after the stack replacement.

We can return to this point if user_data->main is NULL, but that should
only happen if the cygwin DLL is loaded dynamically.  This in turn
disables creating the new stack.

So, shall we just drop the #if __aarch64__ and always instantiate the
barrier?

Do you want to provide a patch for that?

Oh, btw., we have a __mem_barrier definition in cygtls.h. Shouldn't
we use that in _dll_crt0 as well?


Thanks,
Corinna

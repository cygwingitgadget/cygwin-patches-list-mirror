Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B9E6E3858D35; Tue, 19 Nov 2024 09:45:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9E6E3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732009543;
	bh=cC6eqvB+/ZGsIrm3sOIE7nIIx23rKqsZMr4vaaMcmFo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UuKln3jFATkhETWFUy8upCf8yNkpVFdIinzGh/TKD+dg1pbrfg6TioTdbEaMd4+Uf
	 yrrYqy9ThZQeG3rOUrXvv+8BWekjfEnjuvaJT/33SjudHhmLtOTQR1ytOSdnq+guRy
	 9UzxwZs43T5TV0VAd08rHoifNPRmC8XgZ4yi12KY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 754F6A80A6B; Tue, 19 Nov 2024 10:45:41 +0100 (CET)
Date: Tue, 19 Nov 2024 10:45:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygthread: suspend thread before terminating.
Message-ID: <ZzxeRTIcGPxqeJND@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>,
	cygwin-patches@cygwin.com
References: <ac88704b-3f63-1f14-3412-4acce012f729@jdrake.com>
 <ZztRRVIiOBcJtnzZ@calimero.vinschen.de>
 <08896610-b789-4b1c-645f-79dfb354ad74@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08896610-b789-4b1c-645f-79dfb354ad74@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 18 10:10, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 18 Nov 2024, Corinna Vinschen wrote:
> 
> > Neat, but if this only affects the ARM64 emulation, shouldn't this only
> > be called under wincap.cpu_arch() == PROCESSOR_ARCHITECTURE_AMD64?
> 
> Wouldn't this always be true though?

Copy/Paste and not thinking straight is doing that for me, sorry.

The above was supposed to be PROCESSOR_ARCHITECTURE_ARM64, but this is
obviously dumb either way.  What I *meant* was checking if we're running
in an emulation vias GetNativeSystemInfo or IsWow64Process2.  We're
using the latter in find_fast_cwd() already.

> (Except that I backported this to
> 3.3.6 for i686 support, where I'd have to check for that possibility as
> well).

Have I missed something?  I thought this only occurs in an
AMD64-on-ARM64 environment. What is it used for on i686?

> Is this just to avoid the code when a native ARM64 Cygwin appears?

No, the idea was running the code only if we know we're being emulated
on ARM64.  I just screwed up :}

> I have been sort of considering if the results from IsWow64Process2 should
> be cached in wincap, then we could check that here if we are running on
> ARM64 under emulation, and also used the cached value in the check around
> FAST_CWD.  In addition, I was thining it might make sense to include this
> info in `uname -s` like -WOW64 used to be when i686 was supported.

That might be a good idea in the long run and patches are welcome.
Right now we have this isolated usage of IsWow64Process2 in find_fast_cwd().
Given this function is called at least once in a process tree anyway,
wincap would be a natural place to keep the info.

And yeah, maybe we can just attach "-ARM64" to the -s info or something.

> 
> > A one-line comment explain why ERROR_OPERATION_ABORTED is exempt from
> > the debug message might be helpful here.
> 
> OK (if I can limit myself to one line ;))
> 
> > > -	    chld_procs[i].wait_thread->terminate_thread ();
> > > +	    if (!CancelSynchronousIo (chld_procs[i].wait_thread->thread_handle ()))
> >
> > This expression should be bracketed.  But actually, can you just change
> > this to
> >
> >    if (chld_procs[i].wait_thread
> >        && CancelSynchronousIo())
> > please?  And another comment might be helpful here, too.
> 
> OK

Thanks,
Corinna

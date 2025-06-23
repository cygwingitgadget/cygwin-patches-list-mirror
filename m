Return-Path: <SRS0=2kyc=ZG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 8C471386482E
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 14:20:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C471386482E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C471386482E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750688431; cv=none;
	b=lmI+8H/XV49xDFycet29SwebF2YYZcV9vMXgOKY43plGGhuOF3uR451vu9zK8YPGYY469pvViaXIZj7p3jV1Waz4nfw5YBou2GayYgcLK8QMoC97rJdnhgyReNgLbPWI919LGGaA+92gSECm/5bGurcrPq/4UYn+dVlfgNEPl0E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750688431; c=relaxed/simple;
	bh=QiepHAsU9DxfVbrTUHPGoJXF6h0ILVTBBFZlHlzc/uI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Y8b3/3Wsyu4qi6l8fbb6qInCcjy/QmZ4qMsnIOtAnNkvJEnqGYVCUgDnX1bz78EFPOluKZ55NsQKv1M7NIbg9lC9rh2x1VhVeApCSBvSHuJiYmZXNjXVKr1tvJnbl/G2fPJvdFCHYUIRgtgf8zv78Gt/9F3GVrEO/DCZ6qzhWeE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C471386482E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VKcxICqC
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20250623142022963.UIBB.125258.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 23:20:22 +0900
Date: Mon, 23 Jun 2025 23:20:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Do not suspend myself and use VEH
Message-Id: <20250623232022.f74c6aa3d8838162675b308f@nifty.ne.jp>
In-Reply-To: <aFlXBYX6L1xKOvOb@calimero.vinschen.de>
References: <20250623115152.1844-1-takashi.yano@nifty.ne.jp>
	<aFlXBYX6L1xKOvOb@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750688423;
 bh=C0WzAuoNOs0VjwvINODMsYFPFjMXLFkkrTqhKAZeMzg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=VKcxICqCGoaUVy3l2uZaE6QZDyrRP/WOixcsjP+wwkD9YFWd6sWks0k8MkxbMbO0AzirJ+fp
 Pe7/WoRF+8tbh8JMinYfgxOjebHxsQAR6UVE2l8ZDBFfsAh+QIP37bJET8KKvXeicj/7uAi5XR
 zrTb7eGcQ1lOsHGrhFhBTC3g3ptRl0e1wWh6ocvz0OBw4L6jeDvi/w88K6RNmunNVVCPjhURO9
 KOUeXYh/JUFmfryNc0yVuqiAf6ExN0yTJD6iTn4TZVhukmXiedDTdi01aP6RDSxgMfUL1/G+L6
 ahh7LGyCJINMoyQuDjNhYwmeZQulhzwfZItUhHlBJbLbdwSQ==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Thanks for reviewing.

On Mon, 23 Jun 2025 15:30:45 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Jun 23 20:51, Takashi Yano wrote:
> > After the commit f305ca916ad2, some stress-ng tests fail in arm64
> > windows. There seems to be two causes for this issue. One is that
> > calling SuspendThread(GetCurrentThread()) may suspend myself in
> > the kernel. Branching to sigdelayed in the kernel code does not
> > work as expected as the original _cygtls::interrup_now() intended.
> > The other cause is, single step exception sometimes does not trigger
> > exception::handle() for some reason. Therefore, register vectored
> > exception handler (VEH) and use it for single step exception instead.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258332.html
> > Fixes: f305ca916ad2 ("Cygwin: signal: Prevent unexpected crash on frequent SIGSEGV")
> > Reported-by: Jeremy Drake <cygwin@jdrake.com>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/exceptions.cc           | 46 +++++++++++++++------------
> >  winsup/cygwin/local_includes/cygtls.h |  1 +
> >  2 files changed, 27 insertions(+), 20 deletions(-)
> > 
> > diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> > index a4699b172..e5193551b 100644
> > --- a/winsup/cygwin/exceptions.cc
> > +++ b/winsup/cygwin/exceptions.cc
> > @@ -653,13 +653,6 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
> >    static int NO_COPY debugging = 0;
> >    _cygtls& me = _my_tls;
> >  
> > -  if (me.suspend_on_exception)
> > -    {
> > -      SuspendThread (GetCurrentThread ());
> > -      if (e->ExceptionCode == (DWORD) STATUS_SINGLE_STEP)
> > -	return ExceptionContinueExecution;
> > -    }
> > -
> >    if (debugging && ++debugging < 500000)
> >      {
> >        SetThreadPriority (hMainThread, THREAD_PRIORITY_NORMAL);
> > @@ -923,6 +916,22 @@ sig_handle_tty_stop (int sig, siginfo_t *, void *)
> >  }
> >  } /* end extern "C" */
> >  
> > +static HANDLE h_veh = NULL;
> > +static LONG CALLBACK
> > +veh (EXCEPTION_POINTERS *ep)
> 
> A better name would be nice. Something like singlestep_handler or something
> more appropriate.

Done.

> > +{
> > +  if (_my_tls.suspend_on_exception)
> > +    {
> > +      _my_tls.in_exception_handler = true;
> > +      while (_my_tls.suspend_on_exception) ; /* Don't call yield() to privent
>                                                                          ^^^^^^^
>                                                                          prevent
> 
> > +						the thread form being suspended
> > +						in the kernel. */
> > +      if (ep->ExceptionRecord->ExceptionCode == (DWORD) STATUS_SINGLE_STEP)
> > +	return EXCEPTION_CONTINUE_EXECUTION;
> > +    }
> > +  return EXCEPTION_CONTINUE_SEARCH;
> > +}
> > +
> >  bool
> >  _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
> >  			struct sigaction& siga)
> > @@ -943,25 +952,22 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
> >  	 by setting the trap flag (TF) before calling ResumeThread(). This
> >  	 will trigger either STATUS_SINGLE_STEP or the exception caused by
> >  	 the instruction that Rip originally pointed to.  By suspending the
> > -	 targeted thread within exception::handle(), Rip no longer points
> > -	 to the problematic instruction, allowing safe handling of the
> > -	 interrupt. As a result, Rip can be adjusted appropriately, and the
> > -	 thread can resume execution without unexpected crashes.  */
> > +	 targeted thread within the vectored exception handler veh(), Rip no
> > +	 longer points to the problematic instruction, allowing safe handling
> > +	 of the interrupt.  As a result, Rip can be adjusted appropriately,
> > +	 and the thread can resume execution without unexpected crashes. */
> >        if (!inside_kernel (cx, true))
> >  	{
> > +	  if (h_veh == NULL)
> > +	    h_veh = AddVectoredExceptionHandler (1, veh);
> 
> h_veh is static, but not NO_COPY.  I'm pretty sure this might crash
> a subsequently forked child.
> 
> IMO it would make more sense to make h_veh a local var and call
> RemoveVectoredExceptionHandler after calling SuspendThread.

Done.

> >  	  cx->EFlags |= 0x100; /* Set TF (setup single step execution) */
> >  	  SetThreadContext (*this, cx);
> >  	  suspend_on_exception = true;
> > +	  in_exception_handler = false;
> >  	  ResumeThread (*this);
> > -	  ULONG cnt = 0;
> > -	  NTSTATUS status;
> > -	  do
> > -	    {
> > -	      yield ();
> > -	      status = NtQueryInformationThread (*this, ThreadSuspendCount,
> > -						 &cnt, sizeof (cnt), NULL);
> > -	    }
> > -	  while (NT_SUCCESS (status) && cnt == 0);
> > +	  while (!in_exception_handler)
> > +	    yield ();
> 
> We're yielding a lot, which may waste CPU time.  Rather than yielding,
> we should consider to use WaitOnAddress/WakeByAddress* more often.
> 
> https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitonaddress

Done.

> But there's another problem I don't get.  The VEH apparently
> runs in the context of the single stepping thread (you're using
> _my_tls in the VEH).  It sets in_exception_handler to true and then
> goes into a busy loop before returning the exception flag.
> 
> But that means the following SuspendThread...
> 
> 
> > +	  SuspendThread (*this);
> 
> ...will suspend the thread while in the VEH...
> 
> >  	  GetThreadContext (*this, cx);
> >  	  suspend_on_exception = false;
> 
> ...because suspend_on_exception is true up to here.
> 
> How is that supposed to work?

Perhaps I don't fully understand your concern.

I intended to suspend the thread at the busy loop in the VEH.
Then, branching to sigdelayed from there and return to the busy loop
with suspend_on_exception flag of false.

What is your point?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

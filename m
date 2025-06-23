Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9BAB638505D0; Mon, 23 Jun 2025 13:30:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9BAB638505D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750685447;
	bh=bvqPVK1wbXzSRbzivxUO1pkLJcA+afDijC7tzFJ3NoM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NRLK+K2uptTwKUtgNOtz/e8vEAAp9D/Yu2umS6uQ4kaYvJtYVplGdzLuIbPjrTD2j
	 vMXa28yMtoL6OQmyZ/rnCZp031T3N3ViqEPnnvfPTSf2HlvNhRseafEoKvq4Kvg1HB
	 I/XTafR4Vh3CFecaKVqeF+4LLKRfk9EihzqDlmmw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7E876A80D72; Mon, 23 Jun 2025 15:30:45 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:30:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Do not suspend myself and use VEH
Message-ID: <aFlXBYX6L1xKOvOb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250623115152.1844-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623115152.1844-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jun 23 20:51, Takashi Yano wrote:
> After the commit f305ca916ad2, some stress-ng tests fail in arm64
> windows. There seems to be two causes for this issue. One is that
> calling SuspendThread(GetCurrentThread()) may suspend myself in
> the kernel. Branching to sigdelayed in the kernel code does not
> work as expected as the original _cygtls::interrup_now() intended.
> The other cause is, single step exception sometimes does not trigger
> exception::handle() for some reason. Therefore, register vectored
> exception handler (VEH) and use it for single step exception instead.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258332.html
> Fixes: f305ca916ad2 ("Cygwin: signal: Prevent unexpected crash on frequent SIGSEGV")
> Reported-by: Jeremy Drake <cygwin@jdrake.com>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc           | 46 +++++++++++++++------------
>  winsup/cygwin/local_includes/cygtls.h |  1 +
>  2 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index a4699b172..e5193551b 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -653,13 +653,6 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
>    static int NO_COPY debugging = 0;
>    _cygtls& me = _my_tls;
>  
> -  if (me.suspend_on_exception)
> -    {
> -      SuspendThread (GetCurrentThread ());
> -      if (e->ExceptionCode == (DWORD) STATUS_SINGLE_STEP)
> -	return ExceptionContinueExecution;
> -    }
> -
>    if (debugging && ++debugging < 500000)
>      {
>        SetThreadPriority (hMainThread, THREAD_PRIORITY_NORMAL);
> @@ -923,6 +916,22 @@ sig_handle_tty_stop (int sig, siginfo_t *, void *)
>  }
>  } /* end extern "C" */
>  
> +static HANDLE h_veh = NULL;
> +static LONG CALLBACK
> +veh (EXCEPTION_POINTERS *ep)

A better name would be nice. Something like singlestep_handler or something
more appropriate.

> +{
> +  if (_my_tls.suspend_on_exception)
> +    {
> +      _my_tls.in_exception_handler = true;
> +      while (_my_tls.suspend_on_exception) ; /* Don't call yield() to privent
                                                                         ^^^^^^^
                                                                         prevent

> +						the thread form being suspended
> +						in the kernel. */
> +      if (ep->ExceptionRecord->ExceptionCode == (DWORD) STATUS_SINGLE_STEP)
> +	return EXCEPTION_CONTINUE_EXECUTION;
> +    }
> +  return EXCEPTION_CONTINUE_SEARCH;
> +}
> +
>  bool
>  _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
>  			struct sigaction& siga)
> @@ -943,25 +952,22 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
>  	 by setting the trap flag (TF) before calling ResumeThread(). This
>  	 will trigger either STATUS_SINGLE_STEP or the exception caused by
>  	 the instruction that Rip originally pointed to.  By suspending the
> -	 targeted thread within exception::handle(), Rip no longer points
> -	 to the problematic instruction, allowing safe handling of the
> -	 interrupt. As a result, Rip can be adjusted appropriately, and the
> -	 thread can resume execution without unexpected crashes.  */
> +	 targeted thread within the vectored exception handler veh(), Rip no
> +	 longer points to the problematic instruction, allowing safe handling
> +	 of the interrupt.  As a result, Rip can be adjusted appropriately,
> +	 and the thread can resume execution without unexpected crashes. */
>        if (!inside_kernel (cx, true))
>  	{
> +	  if (h_veh == NULL)
> +	    h_veh = AddVectoredExceptionHandler (1, veh);

h_veh is static, but not NO_COPY.  I'm pretty sure this might crash
a subsequently forked child.

IMO it would make more sense to make h_veh a local var and call
RemoveVectoredExceptionHandler after calling SuspendThread.

>  	  cx->EFlags |= 0x100; /* Set TF (setup single step execution) */
>  	  SetThreadContext (*this, cx);
>  	  suspend_on_exception = true;
> +	  in_exception_handler = false;
>  	  ResumeThread (*this);
> -	  ULONG cnt = 0;
> -	  NTSTATUS status;
> -	  do
> -	    {
> -	      yield ();
> -	      status = NtQueryInformationThread (*this, ThreadSuspendCount,
> -						 &cnt, sizeof (cnt), NULL);
> -	    }
> -	  while (NT_SUCCESS (status) && cnt == 0);
> +	  while (!in_exception_handler)
> +	    yield ();

We're yielding a lot, which may waste CPU time.  Rather than yielding,
we should consider to use WaitOnAddress/WakeByAddress* more often.

https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitonaddress

But there's another problem I don't get.  The VEH apparently
runs in the context of the single stepping thread (you're using
_my_tls in the VEH).  It sets in_exception_handler to true and then
goes into a busy loop before returning the exception flag.

But that means the following SuspendThread...


> +	  SuspendThread (*this);

...will suspend the thread while in the VEH...

>  	  GetThreadContext (*this, cx);
>  	  suspend_on_exception = false;

...because suspend_on_exception is true up to here.

How is that supposed to work?


Thanks,
Corinna

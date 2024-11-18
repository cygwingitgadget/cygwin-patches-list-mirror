Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ECB083858C62; Mon, 18 Nov 2024 14:37:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ECB083858C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1731940679;
	bh=pqJlyG7C2etJJQmlUbHLe38WJCEkQDjMPkyRFo9ulSo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MgyzZSk7inySE+epbIu4o32NA3uTnPvTUnJZuc38/dRlGKvMNfwXv/mv0aIT7lqv+
	 SG2Hdo7PQQpZl4xTBfmGmZ5IKN/MWrpk1Bibke9YPLw53Z6Es9C7gDAh+/j2s1ZPrX
	 YbBz8E5i/1NiWGsyXt/ustbR3iNfSYYmulrBDQUQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A3247A814E0; Mon, 18 Nov 2024 15:37:57 +0100 (CET)
Date: Mon, 18 Nov 2024 15:37:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygthread: suspend thread before terminating.
Message-ID: <ZztRRVIiOBcJtnzZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>,
	cygwin-patches@cygwin.com
References: <ac88704b-3f63-1f14-3412-4acce012f729@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac88704b-3f63-1f14-3412-4acce012f729@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,


thanks for this patch, it looks pretty nice.  A few minor points...

On Nov 14 08:24, Jeremy Drake via Cygwin-patches wrote:
> @@ -302,6 +302,20 @@ cygthread::terminate_thread ()
>    if (!inuse)
>      goto force_notterminated;
> 
> +  if (_my_tls._ctinfo != this)
> +    {
> +      CONTEXT context;
> +      context.ContextFlags = CONTEXT_CONTROL;
> +      /* SuspendThread makes sure a thread is "booted" from emulation before
> +	 it is suspended.  As such, the emulator hopefully won't be in a bad
> +	 state (aka, holding any locks) when the thread is terminated. */
> +      SuspendThread (h);
> +      /* We need to call GetThreadContext, even though we don't care about the
> +	 context, because SuspendThread is asynchronous and GetThreadContext
> +	 will make sure the thread is *really* suspended before returning */
> +      GetThreadContext (h, &context);
> +    }
> +

Neat, but if this only affects the ARM64 emulation, shouldn't this only
be called under wincap.cpu_arch() == PROCESSOR_ARCHITECTURE_AMD64?

>    TerminateThread (h, 0);
>    WaitForSingleObject (h, INFINITE);
>    CloseHandle (h);
> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> index e31a67d8f4..2395c36665 100644
> --- a/winsup/cygwin/pinfo.cc
> +++ b/winsup/cygwin/pinfo.cc
> @@ -1252,13 +1252,14 @@ proc_waiter (void *arg)
> 
>    for (;;)
>      {
> -      DWORD nb;
> +      DWORD nb, err;
>        char buf = '\0';
> 
>        if (!ReadFile (vchild.rd_proc_pipe, &buf, 1, &nb, NULL)
> -	  && GetLastError () != ERROR_BROKEN_PIPE)
> +	  && (err = GetLastError ()) != ERROR_BROKEN_PIPE)
>  	{
> -	  system_printf ("error on read of child wait pipe %p, %E", vchild.rd_proc_pipe);

A one-line comment explain why ERROR_OPERATION_ABORTED is exempt from
the debug message might be helpful here.

> +	  if (err != ERROR_OPERATION_ABORTED)
> +	    system_printf ("error on read of child wait pipe %p, %E", vchild.rd_proc_pipe);
>  	  break;
>  	}
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 81b6c31695..360bdac232 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -410,7 +410,8 @@ proc_terminate ()
>  	  if (!have_execed || !have_execed_cygwin)
>  	    chld_procs[i]->ppid = 1;
>  	  if (chld_procs[i].wait_thread)
> -	    chld_procs[i].wait_thread->terminate_thread ();
> +	    if (!CancelSynchronousIo (chld_procs[i].wait_thread->thread_handle ()))

This expression should be bracketed.  But actually, can you just change
this to

   if (chld_procs[i].wait_thread
       && CancelSynchronousIo())


please?  And another comment might be helpful here, too.


Thanks,
Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 657713858D34; Wed, 27 Nov 2024 16:53:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 657713858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732726436;
	bh=AHgkvP+s29Li/5xCtyOvS/4o40e+2+CdrdqOVQ34Hds=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=o7d/seClQai0zzltSG8NnDEkjzfAKhgcib/cNEl5ll7tAFtOLntKZOA+FGroZ7to6
	 RF6aqICd9tFBF9rBQ0WUXCrJ3Vv61GaLsMi36vq5ocGA9S8h/qgrluvCpQSN88Wtki
	 CjRcevLqFASslSF6BThbzFUVPdrZOcXIk0iqxsUw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EF133A80901; Wed, 27 Nov 2024 17:53:53 +0100 (CET)
Date: Wed, 27 Nov 2024 17:53:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/7] Cygwin: signal: Optimize the priority of the sig
 thread
Message-ID: <Z0dOoZwvFlgsCJNd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
 <20241126085521.49604-5-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126085521.49604-5-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 26 17:55, Takashi Yano wrote:
> Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
> This causes a critical delay in the signal handling in the main thread
> if too many signals are received rapidly and the CPU is very busy.
> In this case, most of the CPU time is allocated to the sig thread, so
> the main thread cannot have a chance to handle signals. With this patch,
> the sig thread priority is set to the same priority as the main thread
> to avoid such a situation. Furthermore, if the signal is alerted to
> the main thread, but the main thread does not handle it yet, in order
> to increase the chance of handling it in the main thread, reduce the
> sig thread priority to THREAD_PRIORITY_LOWEST temporarily.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index b8d961a07..fc4360951 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1319,6 +1319,23 @@ wait_sig (VOID *)
>      {
>        DWORD nb;
>        sigpacket pack = {};
> +      /* Follow to the main thread priority */
                   
Just "Follow the ..."

> +      int prio = THREAD_PRIORITY_NORMAL;
> +      if (cygwin_finished_initializing)
> +	{
> +	  HANDLE h_main_thread = NULL;
> +	  threadlist_t *tl_entry = cygheap->find_tls (_main_tls);
> +	  if (_main_tls->thread_id)
> +	    h_main_thread = OpenThread (THREAD_QUERY_INFORMATION,
> +					FALSE, _main_tls->thread_id);

We already have the main thread handle globally available in hMainThread.

But there's something I don't understand here: You don't know if the
main thread is actually the thread handling the signal.  So why should
the priority of the main thread be the role model?

The culprit of the behaviour you're seeing is the fact that *all*
cygthread's are running with THREAD_PRIORITY_HIGHEST prio.

Maybe it's time to rethink this.  Most (none?) of the cygthreads really
need highest priority.  This *may* have been useful when we only had a
single CPU core, but these times have gone by, and cygthreads serve
quite a few tasks which don't need THREAD_PRIORITY_HIGHEST.

We could try to start all threads with normal priority, and
only threads suffering from priority problems could be moved to
another prio.

> +      if (cygwin_finished_initializing)
> +	{
> +	  threadlist_t *tl_entry = cygheap->find_tls (_main_tls);
> +	  if (_main_tls->current_sig)
> +	    /* Decrease the priority in order to make main thread process
> +	       this signal. */
> +	    SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_LOWEST);
> +	  cygheap->unlock_tls (tl_entry);
> +	}

Along these lines, I really wonder if this is required.  What if
we just stick to THREAD_PRIORITY_NORMAL here?


Thanks,
Corinna

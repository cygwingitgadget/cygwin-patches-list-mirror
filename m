Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 88FD83858D26; Tue,  3 Dec 2024 14:31:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 88FD83858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733236294;
	bh=jrsmet+45bcpYEmbz4awcd2JdyZ3+iNQkYol2Ta90/E=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=l78cAq0OetT5Uplz5w1FZASUkE1eo+iQm8skmWXNjWMPZ2rHV+SDT45EobdVKCkw+
	 6HdaCRRhvBO7EhGV3q4Xzy1n41C1EabbKmvz/7E33v7CQXaavKzHhvL4/y/tMl5coW
	 rlW+Oh+zROys9HCa1Ms70h2OA8dCQsSu4Wz03Cpc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 313C8A80B66; Tue,  3 Dec 2024 15:31:32 +0100 (CET)
Date: Tue, 3 Dec 2024 15:31:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Increase chance of handling signal in
 main thread
Message-ID: <Z08WRPqDgNyCc45f@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
 <20241203140203.8351-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203140203.8351-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  3 23:01, Takashi Yano wrote:
> If process() failed and the signal remains in the queue, the most
> possible reason is that the target thread already armed by another
> signal and do not handle it yet. With this patch, to increase the
> chance of handling it in the other threads, call yield() before
> retrying process().
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: e10f822a2b39 ("Cygwin: signal: Handle queued signal without explicit __SIGFLUSH")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 4c557f048..7e02e61f7 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1342,7 +1342,10 @@ wait_sig (VOID *)
>  	pack.si.si_signo = __SIGFLUSH;
>        else if (sigq.start.next
>  	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
> -	pack.si.si_signo = __SIGFLUSH;
> +	{
> +	  yield ();
> +	  pack.si.si_signo = __SIGFLUSH;
> +	}
>        else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
>  	Sleep (INFINITE);	/* Assume were exiting.  Never exit this thread */
>        else if (nb != sizeof (pack) || !pack.si.si_signo)
> -- 
> 2.45.1

LGTM.


Thanks,
Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 33FB33857BA0; Tue, 18 Nov 2025 16:22:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 33FB33857BA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763482957;
	bh=2n0zyxRuGvFv68fZgmnXRfm6KxAM9PvwcOyQNppYlq4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=yN5BzGeKHpRT3cPHqijUv9MPwJHOU8BDnFBMmtMZBT1Z/+4r8o39AakmxYec49fPW
	 WCVIkVKH5odo+Je/jkBcjiUcgm5bwMZJGBnZ7ZpZk5poMJqxGW5SKaPpu72DesIF/d
	 2Lf0Z2DO89n002W6NNSPVijyJLzAt8Yyg5q3rcp4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 51616A80C83; Tue, 18 Nov 2025 17:22:35 +0100 (CET)
Date: Tue, 18 Nov 2025 17:22:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: dll_init: Call __cxa_finalize() for
 DLL_LOAD even in exit_state
Message-ID: <aRydS7KaXPK99ppW@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251118140943.7357-1-takashi.yano@nifty.ne.jp>
 <20251118140943.7357-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118140943.7357-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 18 23:09, Takashi Yano wrote:
> If dlclose() for DLL A is called in the destructor of DLL B which
> linked with the main program, __cxa_finalize() should be called even
> in exit_state. This is because if the destructor of DLL B is called
> in exit_state, DLL A will be unloaded by dlclose().

Sorry if I'm dense, but aren't these two sentences kind of circular?
Shouldn't the first sentence rather explain that DLL B loaded DLL A?

Kind of like this:

  If the loadtime linked DLL B dlopen's DLL A, __cxa_finalize() should
  always be called at dll detach time.  This is because ...

> Thereofre, if __cxa_finalize()is not called here, the destructor of
  Therefore                   space?

> DLL A will be called in exit() even though DLL A is already unloaded.
> This causes crash at exit(). In the case above, __cxa_finalize()
> should be called before unloading DLL A even in exit_state.

> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
> Fixes: c019a66c32f8 ("* dll_init.cc (dll_list::detach) ... Don't call __cxa_finalize in exiting case.")
> Reported-by: Thomas Huth <th.huth@posteo.eu>
> Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/dll_init.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
> index 1369165c9..5ef0fa875 100644
> --- a/winsup/cygwin/dll_init.cc
> +++ b/winsup/cygwin/dll_init.cc
> @@ -584,7 +584,10 @@ dll_list::detach (void *retaddr)
>  	  /* Ensure our exception handler is enabled for destructors */
>  	  exception protect;
>  	  /* Call finalize function if we are not already exiting */
> -	  if (!exit_state)
> +	  /* We always call the finalize function for a dlopen()'ed DLL
> +        because its destructor may crash if invoked during exit()
> +        after dlclose(). */

I think this comment is puzzeling for the code reader.  "exit() after
dlclose()" *seems* to imply that it crashes at exit() time even if
dlclose() has been called explicitely.  The problem is that the
context here is tricky, so it's quite hard to explain why a crash may
occur if __cxa_finalize isn't called here in only a few words.  It may
be helpful to extend the comment and explain this more thoroughly...

Code-wise, the patch LGTM.


Corinna

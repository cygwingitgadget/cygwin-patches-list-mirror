Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E5066384D14B; Wed, 19 Nov 2025 09:11:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E5066384D14B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763543507;
	bh=Mk/92uXejsK2I6+jbIgJXgMEocLS1VFYnOOfVrdwh3o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gk6m34cJ6yRtqfSQusVnlNApHlJZWBH+2vTUUOeZiy+RfjaEo7L+mLvu5kDuFr8ob
	 na4bQ0n+Gq/oxv6HcIpZSM97qi5ZLbUQtPrmfpk4myAL46Wd1C9nxZme28GjHf0ZBL
	 CwjGt36scWTVD9Zw2+ZfP1XbQZ0ldU5Yga5/LD60=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 47F24A80443; Wed, 19 Nov 2025 10:11:46 +0100 (CET)
Date: Wed, 19 Nov 2025 10:11:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com, Thomas Huth <th.huth@posteo.eu>
Subject: Re: [PATCH v3 1/2] Cygwin: dll_init: Always call __cxa_finalize()
 for DLL_LOAD
Message-ID: <aR2J0rv3QLiMzFpC@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,
	cygwin-patches@cygwin.com, Thomas Huth <th.huth@posteo.eu>
References: <20251118234535.194356-1-takashi.yano@nifty.ne.jp>
 <20251118234535.194356-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118234535.194356-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 19 08:45, Takashi Yano wrote:
> For dlopen()'ed DLL, __cxa_finalize() should always be called at dll
> detach time. The reason is as follows. In the case that dlopen()'ed
> DLL A is dlclose()'ed in the destructor of DLL B, and the destructor
> of DLL B is called in exit_state, DLL A will be unloaded by dlclose().
> If __cxa_finalize() for DLL A is not called here, the destructor of
> DLL A will be called in exit() even though DLL A is already unloaded.
> This causes crash at exit(). In this case, __cxa_finalize() should be
> called before unloading DLL A even in exit_state.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
> Fixes: c019a66c32f8 ("* dll_init.cc (dll_list::detach) ... Don't call __cxa_finalize in exiting case.")
> Reported-by: Thomas Huth <th.huth@posteo.eu>
> Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>, Corinna Vinschen <corinna-cygwin@cygwin.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/dll_init.cc | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
> index 1369165c9..d2ed74bed 100644
> --- a/winsup/cygwin/dll_init.cc
> +++ b/winsup/cygwin/dll_init.cc
> @@ -584,7 +584,16 @@ dll_list::detach (void *retaddr)
>  	  /* Ensure our exception handler is enabled for destructors */
>  	  exception protect;
>  	  /* Call finalize function if we are not already exiting */
> -	  if (!exit_state)
> +	  /* For dlopen()'ed DLL, __cxa_finalize() should always be called
> +	     at dll detach time. The reason is as follows. In the case that
> +	     dlopen()'ed DLL A is dlclose()'ed in the destructor of DLL B,
> +	     and the destructor of DLL B is called in exit_state, DLL A will
> +	     be unloaded by dlclose(). If __cxa_finalize() for DLL A is not
> +	     called here, the destructor of DLL A will be called in exit()
> +	     even though DLL A is already unloaded. This causes crash at
> +	     exit(). In this case, __cxa_finalize() should be called before
> +	     unloading DLL A even in exit_state. */
> +	  if (!exit_state || d->type == DLL_LOAD)
>  	    __cxa_finalize (d->handle);
>  	  d->run_dtors ();
>  	}
> -- 
> 2.51.0

Sounds good to me, now, thanks!


Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 24715385735A; Tue, 18 Nov 2025 16:31:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 24715385735A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763483474;
	bh=PRB3AYBS7ucKEp8AA0jvvm3wYOCOu6yztRu3hOifHbQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=afaVkfhggHkZ0SrrC11kod9BNAFGhnlohdQZeL8Ww/wTygYf9WorjH2bm6c1JbeET
	 /yPBLfQaZccvTuclVhsfyL3UF2yTZKrgv+ol3gFIV/9Q2z/Ns3vG+PQh8Mk+P+ZOTm
	 kLK4+dORgTmdhjEnpqQgZCMFFw9ZnOOF2l6Qdjbw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 78D11A80CFD; Tue, 18 Nov 2025 17:31:12 +0100 (CET)
Date: Tue, 18 Nov 2025 17:31:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: dll_init: Don't call dll::init() twice
 for DLL_LOAD.
Message-ID: <aRyfUJ-BKOnskONG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251118140943.7357-1-takashi.yano@nifty.ne.jp>
 <20251118140943.7357-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118140943.7357-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 18 23:09, Takashi Yano wrote:
> If dlopen() for DLL A is called in constructor DLL B, the constructor
> for DLL A is called twice, once called via cygwin_attach_dll() called
> from LoadLibrary(), and again from dll_list::init(). That is, the DLL
> with DLL_LOAD does not need dll::init() in dll_list::init(). This issue
> was found when debugging the issue:
> https://cygwin.com/pipermail/cygwin/2025-October/258877.html
> This patch remove dll::init() call in dll_list::init() for DLL_LOAD.
> 
> Fixes: 2eb392bd77de ("dll_init.cc: Revamp.  Use new classes.")
> Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/dll_init.cc | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
> index 5ef0fa875..e26457a69 100644
> --- a/winsup/cygwin/dll_init.cc
> +++ b/winsup/cygwin/dll_init.cc
> @@ -612,9 +612,10 @@ dll_list::init ()
>    /* Walk the dll chain, initializing each dll */
>    dll *d = &start;
>    dll_global_dtors_recorded = d->next != NULL;
> -  /* Init linked and early loaded Cygwin DLLs. */
> +  /* Init linked Cygwin DLLs. As for loaded DLLs, dll::init() is already
> +     called via _cygwin_dll_entry called from LoadLibrary(). */
>    while ((d = d->next))
> -    if (d->type == DLL_LINK || d->type == DLL_LOAD)
> +    if (d->type == DLL_LINK)
>        d->init ();
>  }
>  
> -- 
> 2.51.0

LGTM.


Thanks,
Corinna

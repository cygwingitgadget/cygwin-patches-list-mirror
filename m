Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DD2814BB5906; Mon,  2 Feb 2026 17:17:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DD2814BB5906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770052634;
	bh=0s8WdrkyBW7Ld9wL0Eoa4Eums0aU15XiXBLkrsmeU80=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=s6/56sAOk9rWlRdx1DNcKyfx9v1rYYKX9APDWdUlI89ubd9rB5NY5X5Po0fwp16KY
	 zzxIsCbXH2uVbQFY20lsAWHpD9m9fiYt9NyUXuUNgFMThh4XOWMYNmF0ZO83zRnIsb
	 CjKCdGcbxArRGWQ5ScVf4+sjuftL2/Mwsh19ufzo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 11D77A80543; Mon, 02 Feb 2026 18:17:13 +0100 (CET)
Date: Mon, 2 Feb 2026 18:17:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: child_info: remove filler bytes
Message-ID: <aYDcGX11O0UMODrx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260126102652.382670-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126102652.382670-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Jan 26 11:26, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> The filler bytes in child_info were only necessary for Vista to
> workaround a bug in WOW64. We just neglected to remove them so far.
> 
> Fixes: a4efb2a6698f ("Cygwin: remove support for Vista entirely")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/local_includes/child_info.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
> index 25d99fa7de36..dc0b75dee694 100644
> --- a/winsup/cygwin/local_includes/child_info.h
> +++ b/winsup/cygwin/local_includes/child_info.h
> @@ -33,7 +33,7 @@ enum child_status
>  #define EXEC_MAGIC_SIZE sizeof(child_info)
>  
>  /* Change this value if you get a message indicating that it is out-of-sync. */
> -#define CURR_CHILD_INFO_MAGIC 0x77f25a01U
> +#define CURR_CHILD_INFO_MAGIC 0x3c5c4429U
>  
>  #include "pinfo.h"
>  struct cchildren
> @@ -111,7 +111,6 @@ public:
>    void *stackbase;	// StackBase of parent thread
>    size_t guardsize;     // size of POSIX guard region or (size_t) -1 if
>  			// user stack
> -  char filler[4];
>    child_info_fork ();
>    void handle_fork ();
>    bool abort (const char *fmt = NULL, ...);
> @@ -145,7 +144,6 @@ public:
>    cygheap_exec_info *moreinfo;
>    int __stdin;
>    int __stdout;
> -  char filler[4];
>  
>    void cleanup ();
>    child_info_spawn () {};
> -- 
> 2.52.0

Pushed.

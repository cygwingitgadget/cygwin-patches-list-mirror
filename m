Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CAACE3858D3C; Fri, 16 Jun 2023 15:04:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CAACE3858D3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1686927847;
	bh=/Pwf+cQk2sHfnvPEqa6xUfQTXOHLOBRsR2v3TrG1N0Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hAVNqLQol6f7Y/wWmVqvV6tlH1CM4XaM5wD65ODpsU1k6kjzgR3zrWxs7v0Z2nXuF
	 WkltYqTtGbstEpfr1jxcxIg8dkcCQFC88QMoULL9GNVEbNBp+dM31EdkpYEWs/w2PQ
	 L313RmR0azH8PZZsdSBtx6ytLIdO+u4ERLMcgq34=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1DF20A80B72; Fri, 16 Jun 2023 17:04:06 +0200 (CEST)
Date: Fri, 16 Jun 2023 17:04:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Philippe Cerfon <philcerf@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
Message-ID: <ZIx55su+P5zInrqa@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Philippe Cerfon <philcerf@gmail.com>,
	cygwin-patches@cygwin.com
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca>
 <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
 <ZH80lgpsfWwCZp+R@calimero.vinschen.de>
 <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
 <ZIBWqTEkn9c9GWfF@calimero.vinschen.de>
 <CAN+za=NjpooX1JrwbgDgX8yzHkn6AwtYH8yCOjzkUspMZd1W6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+za=NjpooX1JrwbgDgX8yzHkn6AwtYH8yCOjzkUspMZd1W6g@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Philippe,

On Jun 16 16:09, Philippe Cerfon wrote:
> Hey Corinna.
> 
> On Wed, Jun 7, 2023 at 12:06 PM Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Hmm, the comparisons would have to check for XATTR_NAME_MAX anyway,
> > so maybe inlining is cleaner in this case.
> 
> Please have a look at the updated and attached patches.
> 
> Thanks,
> Philippe.

Oh well. Now that I see it in real life, my idea to use the entire
expression inline wasn't that great, it seems... 

I didn't want to keep MAX_EA_NAME_LEN because now that we have an
official name for the value, having an unofficial name using a different
naming convention is a bit weird.

On the other hand, having a macro for the expression certainly looks
much cleaner.  Also, only one place to change (should a change ever be
necessary).

Sorry about that.

What do you think about something like _XATTR_NAME_MAX_ONDISK_?

I can also just push the patches and we discuss this further afterwards,
your call.


Thanks,
Corinna



> @@ -55,7 +54,7 @@ read_ea (HANDLE hdl, path_conv &pc, const char *name, char *value, size_t size)
>       returns the last EA entry of the file infinitely.  Even utilizing the
>       optional EaIndex only helps marginally.  If you use that, the last
>       EA in the file is returned twice. */
> -  char lastname[MAX_EA_NAME_LEN];
> +  char lastname[(XATTR_NAME_MAX + 1 - strlen("user."))];
>  
>    __try
>      {
> @@ -95,7 +94,7 @@ read_ea (HANDLE hdl, path_conv &pc, const char *name, char *value, size_t size)
>  	      __leave;
>  	    }
>  
> -	  if ((nlen = strlen (name)) >= MAX_EA_NAME_LEN)
> +	  if ((nlen = strlen (name)) >= (XATTR_NAME_MAX + 1 - strlen("user.")))
>  	    {
>  	      set_errno (EINVAL);
>  	      __leave;
> @@ -197,7 +196,7 @@ read_ea (HANDLE hdl, path_conv &pc, const char *name, char *value, size_t size)
>  		  /* For compatibility with Linux, we always prepend "user." to
>  		     the attribute name, so effectively we only support user
>  		     attributes from a application point of view. */
> -		  char tmpbuf[MAX_EA_NAME_LEN * 2];
> +		  char tmpbuf[(XATTR_NAME_MAX + 1 - strlen("user.")) * 2];
>  		  char *tp = stpcpy (tmpbuf, "user.");
>  		  stpcpy (tp, fea->EaName);
>  		  /* NTFS stores all EA names in uppercase unfortunately.  To
> @@ -297,7 +296,7 @@ write_ea (HANDLE hdl, path_conv &pc, const char *name, const char *value,
>        /* Skip "user." prefix. */
>        name += 5;
>  
> -      if ((nlen = strlen (name)) >= MAX_EA_NAME_LEN)
> +      if ((nlen = strlen (name)) >= (XATTR_NAME_MAX + 1 - strlen("user.")))
>  	{
>  	  set_errno (EINVAL);
>  	  __leave;
> -- 
> 2.40.1
> 


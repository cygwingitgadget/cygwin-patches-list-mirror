Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AD21C3846091; Sun, 30 Mar 2025 21:43:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AD21C3846091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743371039;
	bh=QUfnifMbpc78C/gzgNnB1SVM6naQ/vIokOSn+s5rCsw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CG29iO0X4YtuODATJh6mSq9O9z3Ni17bQKwgoJPoko2M9R6oDALxLT3FP2pdx8lKj
	 dpVmFHQZfHVbNCtUx3X1hsnMLSrMMThNxU6p4w7fPHRTOBaX8w/jEFxrG0KjIuAy8Z
	 Re2uTNPfNcxn6yW0hmyTFm8HhpxeRh56z5BLnW9A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 860F9A80961; Sun, 30 Mar 2025 23:43:52 +0200 (CEST)
Date: Sun, 30 Mar 2025 23:43:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Yuyi Wang <Strawberry_Str@hotmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dlfcn: fix ENOENT in dlclose
Message-ID: <Z-m7GKMd5fXqlq2S@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Yuyi Wang <Strawberry_Str@hotmail.com>,
	cygwin-patches@cygwin.com
References: <TYTPR01MB109233E1CD6728FC1CAAFB90EF8A22@TYTPR01MB10923.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYTPR01MB109233E1CD6728FC1CAAFB90EF8A22@TYTPR01MB10923.jpnprd01.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Yuri,

On Mar 30 23:00, Yuyi Wang wrote:
> dlclose tries to decrease the ref count of the dll* entry, but a new dll
> opened by dlopen doesn't create a new dll* entry.
> ---
>  winsup/cygwin/dlfcn.cc | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
> index fb7052473..3093ec1be 100644
> --- a/winsup/cygwin/dlfcn.cc
> +++ b/winsup/cygwin/dlfcn.cc
> @@ -350,14 +350,15 @@ dlclose (void *handle)
>      {
>        /* reference counting */
>        dll *d = dlls.find (handle);
> -      if (!d || d->count <= 0)
> +      if (d && d->count <= 0)
>  	{
>  	  errno = ENOENT;
>  	  ret = -1;
>  	}
>        else
>  	{
> -	  --d->count;
> +	  if (d)
> +	    --d->count;
>  	  if (!FreeLibrary ((HMODULE) handle))
>  	    {
>  	      __seterrno ();
> -- 
> 2.48.1.windows.1-2

Thanks for the patch, but that's not the right way to fix this issue,
afaics.  I tested this scenario, and this problem only occurs with
dlopening cygwin1.dll.

The reason is that the dll_list::find method returns NULL if the found
DLL is cygwin1.dll.  This makes sense for other places where the method
is used, but it doesn't make sense for dlopen/dlclose.  
So dll_list::find needs a way to return the dll pointer so we can
refcount cygwin1.dll like any other DLL so dlclose succeeds.

While looking into it, I found another refcount problem in terms of
RTLD_NODELETE.  I fixed that too.

Please give the next test release cygwin-3.7.0-0.24.g98112b9f6f90
a try.


Thanks,
Corinna

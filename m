Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 132A33858C3A; Tue, 26 Nov 2024 13:30:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 132A33858C3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732627844;
	bh=YcQUX3AoKQ/h1kTg5ud7MNaySUK5tNiYT+2e30hfTVo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=l+TTInZs9QJ8IZOnNee2yeZA4m0R7dOq5ZXnahjI3cQLNhHxrLRfFQL0/SRS9Qpl5
	 UB5ulPW1i7vBoxclwvrWt8NjOnXs5B/HvAL8BtgksOsWGZZIfaBCtxPocTZp3Qr375
	 MQICbOEHLJFnPxno7Wl/s3ov5bo9dTVKtPXKErWc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F3185A80E83; Tue, 26 Nov 2024 14:30:41 +0100 (CET)
Date: Tue, 26 Nov 2024 14:30:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: uname: add host machine tag to sysname.
Message-ID: <Z0XNgZoVQI_P5FMD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ecdfa413-1ad4-ea0e-4f01-33579f1616e9@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecdfa413-1ad4-ea0e-4f01-33579f1616e9@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 25 11:24, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> If the Cygwin dll's architecture is different from the host system's
> architecture, append an additional tag that indicates the host system
> architecture (the Cygwin dll's architecture is already indicated in
> machine).
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> v2: get rid of hardcoded string lengths, use wincap accessors
> directly instead of caching their returns, actually add "n" variable as
> intended
> 
>  winsup/cygwin/uname.cc | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/uname.cc b/winsup/cygwin/uname.cc
> index dd4160189c..2410dc502e 100644
> --- a/winsup/cygwin/uname.cc
> +++ b/winsup/cygwin/uname.cc
> @@ -24,6 +24,38 @@ extern "C" int getdomainname (char *__name, size_t __len);
>  #define ATTRIBUTE_NONSTRING
>  #endif
> 
> +static int
> +append_host_suffix (char * buf)
> +{
> +  int n = 0;
> +  if (wincap.host_machine () != wincap.cygwin_machine ())
> +    {
> +      switch (wincap.host_machine ())
> +	{
> +	  case IMAGE_FILE_MACHINE_AMD64:
> +	    /* special case for backwards compatibility */
> +	    if (wincap.cygwin_machine () == IMAGE_FILE_MACHINE_I386)
> +	      n = stpcpy (buf, "-WOW64") - buf;
> +	    else
> +	      n = stpcpy (buf, "-x64") - buf;
> +	    break;

> +	  case IMAGE_FILE_MACHINE_I386:
> +	    n = stpcpy (buf, "-x86") - buf;
> +	    break;
> +	  case IMAGE_FILE_MACHINE_ARMNT:
> +	    n = stpcpy (buf, "-ARM") - buf;
> +	    break;
> +	  case IMAGE_FILE_MACHINE_ARM64:
> +	    n = strcpy (buf, "-ARM64") - buf;
> +	    break;
> +	  default:
> +	    n = __small_sprintf (buf, "-%04y", (int) wincap.host_machine ());
> +	    break;
> +	}

You can greatly simplify this switch.  We don't support 32 bit systems
and we will never again support 32 bit systems.  Any combination
including a 32 bit system can just go away.  Theoretically, only
the IMAGE_FILE_MACHINE_ARM64 case should be left.

>    __try
>      {
>        char buf[NI_MAXHOST + 1] ATTRIBUTE_NONSTRING;
> +      int n;
> 
>        memset (name, 0, sizeof (*name));
>        /* sysname */
> -      __small_sprintf (name->sysname, "CYGWIN_%s-%u",
> -		       wincap.osname (), wincap.build_number ());
> +      n = __small_sprintf (name->sysname, "CYGWIN_%s-%u",
> +			   wincap.osname (), wincap.build_number ());
> +      n += append_host_suffix (name->sysname + n);

I guess a length check is not required here.  The __small_sprintf
creates a 21 byte string, or 22 byte as soon as the build number gets
6 digits.  The field length is 65 bytes, so there's some spare.  But
at least we talked about it :)


Thanks,
Corinna

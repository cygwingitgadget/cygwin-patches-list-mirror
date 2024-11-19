Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6A4603858D34; Tue, 19 Nov 2024 16:30:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A4603858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732033847;
	bh=SDHhYhHR+AZBX/gZKMzz/XPVzeiBQoMep5yUqKmB7bg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=blv0YoDWmEujd5F45BWzOtbfx968HqNigzi717oS7rFeMz7AMcN1t8/kkZkG5rVd/
	 paRXuas3R2CD0EjgKQG1CKNw3YuhEbBbBlUeskqDVTUpgagz/um7Az0pttFEDR8ljH
	 9qPNUEr2ypDxcsbhzeTKL3fVKPwvMwVUcIh9vD5w=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 49A7AA80D6C; Tue, 19 Nov 2024 17:30:16 +0100 (CET)
Date: Tue, 19 Nov 2024 17:30:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: David Warner <david@warnr.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add Windows Server 2025 build number
Message-ID: <Zzy9GBs9J07ExRJT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: David Warner <david@warnr.net>, cygwin-patches@cygwin.com
References: <20241119095530.41303-1-david@warnr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119095530.41303-1-david@warnr.net>
List-Id: <cygwin-patches.cygwin.com>

Hi David,

thanks for the patch, but...

On Nov 19 09:55, David Warner wrote:
> ---
>  winsup/utils/mingw/cygcheck.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.cc
> index 1dde2ecba..659e8428a 100644
> --- a/winsup/utils/mingw/cygcheck.cc
> +++ b/winsup/utils/mingw/cygcheck.cc
> @@ -1459,7 +1459,9 @@ dump_sysinfo ()
>  		  else if (osversion.dwBuildNumber <= 17763)
>  		    strcpy (osname, "Server 2019");
>  		  else if (osversion.dwBuildNumber <= 20348)
> -		    strcpy (osname, "Server 2022");
> +            strcpy (osname, "Server 2022");
> +          else if (osversion.dwBuildNumber <= 26100)
> +            strcpy (osname, "Server 2025");

...why do you change the TABs to spaces here?  Please keep the
TAB setting intact.


Thanks,
Corinna



>  		  else
>  		    strcpy (osname, "Server 20??");
>  		}
> -- 
> 2.47.0
> 

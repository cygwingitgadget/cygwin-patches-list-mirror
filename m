Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AE6DE3858C56; Tue, 19 Nov 2024 19:06:39 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 00976A80D6C; Tue, 19 Nov 2024 20:05:49 +0100 (CET)
Date: Tue, 19 Nov 2024 20:05:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: David Warner <david@warnr.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Fix tabs/spaces
Message-ID: <ZzzhjYFW7n6uur7o@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: David Warner <david@warnr.net>, cygwin-patches@cygwin.com
References: <20241119100140.43240-1-david@warnr.net>
 <20241119100140.43240-2-david@warnr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119100140.43240-2-david@warnr.net>
List-Id: <cygwin-patches.cygwin.com>

Hi David,

I saw this too late and then had trouble with my mail service.
I merged the two patches and pushed it.


Thanks,
Corinna

On Nov 19 10:02, David Warner wrote:
> ---
>  winsup/utils/mingw/cygcheck.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.cc
> index 659e8428a..89a08e560 100644
> --- a/winsup/utils/mingw/cygcheck.cc
> +++ b/winsup/utils/mingw/cygcheck.cc
> @@ -1459,9 +1459,9 @@ dump_sysinfo ()
>  		  else if (osversion.dwBuildNumber <= 17763)
>  		    strcpy (osname, "Server 2019");
>  		  else if (osversion.dwBuildNumber <= 20348)
> -            strcpy (osname, "Server 2022");
> -          else if (osversion.dwBuildNumber <= 26100)
> -            strcpy (osname, "Server 2025");
> +		    strcpy (osname, "Server 2022");
> +		  else if (osversion.dwBuildNumber <= 26100)
> +		    strcpy (osname, "Server 2025");
>  		  else
>  		    strcpy (osname, "Server 20??");
>  		}
> -- 
> 2.47.0
> 

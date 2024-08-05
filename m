Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0F2FE3858401; Mon,  5 Aug 2024 10:11:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0F2FE3858401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1722852666;
	bh=8a56PamIp5ZHGJD08obSnQUlP36MNdRjxis1q+ng39k=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Hn3UONVBSps8xbQ3tiGcEBXx43B/P6Hbjut4r0pQGKVAX9m5Je+tFYSQELe+R71v6
	 mDU/qgXxW9hAtf7bD64+kHhBUQlNvz2V7zRgo0uf1Jlux4lt822wKvY4BV5Ed5qhFe
	 gRl7Vmg5lNk4f2KoBu4d8o2vIwhsSKV5VeKx5PQw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A1DD7A807E3; Mon,  5 Aug 2024 12:11:03 +0200 (CEST)
Date: Mon, 5 Aug 2024 12:11:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/6] Cygwin: Suppress array-bounds warning from
 NtCurrentTeb()
Message-ID: <ZrClN78W3jULqPeX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-2-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804214829.43085-2-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Aug  4 22:48, Jon Turney wrote:
> This disables a warning seen with gcc 12 caused by intrinsics used by
> the inline implementation of NtCurrentTeb() inside w32api headers.
> 
> > In function ‘long long unsigned int __readgsqword(unsigned int)’,
> >     inlined from ‘_TEB* NtCurrentTeb()’ at /usr/include/w32api/winnt.h:10020:86,
> > [...]
> > /usr/include/w32api/psdk_inc/intrin-impl.h:838:1: error: array subscript 0 is outside array bounds of ‘long long unsigned int [0]’ [-Werror=array-bounds]
> 
> See also: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105523#c6
> ---
>  winsup/cygwin/local_includes/winlean.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/local_includes/winlean.h b/winsup/cygwin/local_includes/winlean.h
> index 5bf1be262..62b651be6 100644
> --- a/winsup/cygwin/local_includes/winlean.h
> +++ b/winsup/cygwin/local_includes/winlean.h
> @@ -53,7 +53,10 @@ details. */
>  #define __undef_CRITICAL
>  #endif
>  
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Warray-bounds"
>  #include <windows.h>
> +#pragma GCC diagnostic pop
>  #include <wincrypt.h>
>  #include <lmcons.h>
>  #include <ntdef.h>
> -- 
> 2.45.1

Looks like every other way to workaround this is worse.  Please push.

Thanks,
Corinna

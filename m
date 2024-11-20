Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DCFE83858D20; Wed, 20 Nov 2024 15:34:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DCFE83858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732116848;
	bh=gweegsvSu37Gp+EETtReeGdJ34tSl0ChVWmQqx7/g4k=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KALq4Lzh3oIvcvBd0tD6ZQ3fJ0bDfDuowrPWvXEuDtJF9jVZzUlW9/7t7sKqPIziq
	 7ZgzZd6FjscjnVMTRvWlkxKIg5LjWkIxE5zG1IAJ3IfpwL4dKm1Mq1n7mRPI0Ef1wH
	 kbabIU7z0i5vQMR6NGoxPOlPbtZ+4oGRXVCdx/Xo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E553DA814E9; Wed, 20 Nov 2024 16:33:37 +0100 (CET)
Date: Wed, 20 Nov 2024 16:33:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: SetThreadName: avoid spurious debug message
Message-ID: <Zz4BUR5C7It3xNTs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Jon Turney <jon.turney@dronecode.org.uk>
References: <20241120152630.1617419-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120152630.1617419-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 20 16:26, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> The following debug message occassionally shows up in strace output:
> 
>   SetThreadName: SetThreadDescription() failed. 00000000 10000000
> 
> The HRESULT of 0x10000000 is not an error, rather the set bit just
> indicates that this HRESULT has been created from an NTSTATUS value.
> 
> Use the IS_ERROR() macro instead of just checking for S_OK.
> 

I missed this line:

  Fixes: d4689b99c686 ("Cygwin: Set threadnames with SetThreadDescription()")

Treat it as already added, please...

> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/miscfuncs.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
> index 767384faa9ae..4220f6275785 100644
> --- a/winsup/cygwin/miscfuncs.cc
> +++ b/winsup/cygwin/miscfuncs.cc
> @@ -353,7 +353,7 @@ SetThreadName (DWORD dwThreadID, const char* threadName)
>        WCHAR buf[bufsize];
>        bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, buf, bufsize);
>        HRESULT hr = SetThreadDescription (hThread, buf);
> -      if (hr != S_OK)
> +      if (IS_ERROR (hr))
>  	{
>  	  debug_printf ("SetThreadDescription() failed. %08x %08x\n",
>  			GetLastError (), hr);
> -- 
> 2.47.0

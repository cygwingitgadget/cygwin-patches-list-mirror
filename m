Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AAFA63858002; Wed, 16 Aug 2023 07:51:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AAFA63858002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1692172278;
	bh=8bj/nFPNkOfPEfLP08wKXH1wiSia/Nn6LoQ5vee0rxc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=r7+3QSn7laxdmStWLoWgFnvMmmbzR4bNYAGXUn3PvhWOzg+l+x2aGfr3ughiDipGq
	 HPPr07N0pS87jhzOY7wRgCzLnVK8gVyq7o5RrFhxHOX+/R4PSk8OPknJBiwTC/CZ+M
	 YlKTD+Y5jOKqce9n6ePLALjgBAFWUMAvFnmDq2Ks=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C90ACA80C03; Wed, 16 Aug 2023 09:51:16 +0200 (CEST)
Date: Wed, 16 Aug 2023 09:51:16 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: shared: Fix access permissions setting in
 open_shared().
Message-ID: <ZNx/9DTJf9CXTlDU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230815233746.1424-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815233746.1424-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Aug 16 08:37, Takashi Yano wrote:
> After the commit 93508e5bb841, the access permissions argument passed
> to open_shared() is ignored and always replaced with (FILE_MAP_READ |
> FILE_MAP_WRITE). This causes the weird behaviour that sshd service
> process loses its cygwin PID. This triggers the failure in pty that
> transfer_input() does not work properly.
> 
> This patch resumes the access permission settings to fix that.
> 
> Fixes: 93508e5bb841 ("Cygwin: open_shared: don't reuse shared_locations parameter as output")
> Signedd-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/mm/shared.cc | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/mm/shared.cc b/winsup/cygwin/mm/shared.cc
> index 40cdd4722..7977df382 100644
> --- a/winsup/cygwin/mm/shared.cc
> +++ b/winsup/cygwin/mm/shared.cc
> @@ -139,8 +139,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
>        if (name)
>  	mapname = shared_name (map_buf, name, n);
>        if (m == SH_JUSTOPEN)
> -	shared_h = OpenFileMappingW (FILE_MAP_READ | FILE_MAP_WRITE, FALSE,
> -				     mapname);
> +	shared_h = OpenFileMappingW (access, FALSE, mapname);
>        else
>  	{
>  	  created = true;
> @@ -165,8 +164,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
>    do
>      {
>        addr = (void *) next_address;
> -      shared = MapViewOfFileEx (shared_h, FILE_MAP_READ | FILE_MAP_WRITE,
> -				0, 0, 0, addr);
> +      shared = MapViewOfFileEx (shared_h, access, 0, 0, 0, addr);
>        next_address += wincap.allocation_granularity ();
>        if (next_address >= SHARED_REGIONS_ADDRESS_HIGH)
>  	{
> -- 
> 2.39.0

Oh drat, whatever was I thinking at the time?  Thanks for catching
and fixing this!  Please push.


Corinna



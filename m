Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5373F385840B; Wed,  2 Apr 2025 20:30:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5373F385840B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743625843;
	bh=Qp5ma+WkHSfsBgQZVSFiwql0kojGk2S6gar1K2Uw1hA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Gbi6M1yuBzmSZBRYqX2qDKx19SqTJoAa1dAyFIv+ihVX/M22/oNfScgse2IHJHBZt
	 5gAm613O53FlvAzeGY5Vpk1tIcFrxUmQpUGvTezMpHnz8oYAtSkD/wUTTOSc4IqRQY
	 Zcfh4amTB1cSPoPj9SbqcfF8UABP5a/pTCKK7rIc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F3AC2A80C9C; Wed, 02 Apr 2025 22:29:48 +0200 (CEST)
Date: Wed, 2 Apr 2025 22:29:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: handle GetProcAddress returning NULL in
 GetArm64ProcAddress.
Message-ID: <Z-2ePII02PBpvN0S@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <110f5fb0-8161-09d9-df71-6ee96f8ec383@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <110f5fb0-8161-09d9-df71-6ee96f8ec383@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Apr  2 13:01, Jeremy Drake via Cygwin-patches wrote:
> This was an oversight, the caller of GetArm64ProcAddress does check for
> a NULL return, but it would have crashed in the memcmp before getting
> there.
> 
> Fixes: 2c5f25035d9f ("Cygwin: add find_fast_cwd_pointer_aarch64.")
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/aarch64/fastcwd.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/aarch64/fastcwd.cc b/winsup/cygwin/aarch64/fastcwd.cc
> index a85c539817..e53afc0046 100644
> --- a/winsup/cygwin/aarch64/fastcwd.cc
> +++ b/winsup/cygwin/aarch64/fastcwd.cc
> @@ -35,8 +35,8 @@ GetArm64ProcAddress (HMODULE hModule, LPCSTR procname)
>  #else
>  #error "Unhandled architecture for thunk detection"
>  #endif
> -  if (memcmp (proc, thunk, sizeof (thunk) - 1) == 0 ||
> -     (sizeof(thunk2) && memcmp (proc, thunk2, sizeof (thunk2) - 1) == 0))
> +  if (proc && (memcmp (proc, thunk, sizeof (thunk) - 1) == 0 ||
> +	(sizeof(thunk2) && memcmp (proc, thunk2, sizeof (thunk2) - 1) == 0)))
>      {
>        proc += sizeof (thunk) - 1;
>        proc += 4 + *(const int32_t *) proc;
> -- 
> 2.48.1.windows.1

Yup, makes sense. Please push.

Thanks,
Corinna

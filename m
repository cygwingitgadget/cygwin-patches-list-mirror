Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 226773858D34; Tue, 26 Nov 2024 13:33:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 226773858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732628027;
	bh=E0U/mMuzIbRcm8fUQi6CZW2BMMBCv0dWePlck+N909g=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=iw8/qqs7l7ksuDewPVx1L4lX1RWkppKuJ4c6TXFwjoVo1rrMlsGyXuVBjaJJ3ewjX
	 FlYFvM/fMfmYdS2okXHHEJ7h0w90SzOiwUFC8PZgb6jyY/JYQg/lxqO3B3n050TLXE
	 NGJ12TrDSs9jnM3YUZdm+ZCFZcfD3m7d03B3zOpo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1A5A3A80E4D; Tue, 26 Nov 2024 14:33:45 +0100 (CET)
Date: Tue, 26 Nov 2024 14:33:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
Message-ID: <Z0XOOW365ff53K6B@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Btw...

On Nov 25 11:21, Jeremy Drake via Cygwin-patches wrote:
> @@ -4617,14 +4617,12 @@ find_fast_cwd_pointer ()
>  static fcwd_access_t **
>  find_fast_cwd ()
>  {
> -  USHORT emulated, hosted;
>    fcwd_access_t **f_cwd_ptr;
> 
> -  /* First check if we're running in WOW64 on ARM64 emulating AMD64.  Skip
> +  /* First check if we're running on an ARM64 system.  Skip
>       fetching FAST_CWD pointer as long as there's no solution for finding
>       it on that system. */
> -  if (IsWow64Process2 (GetCurrentProcess (), &emulated, &hosted)
> -      && hosted == IMAGE_FILE_MACHINE_ARM64)
> +  if (wincap.host_machine () == IMAGE_FILE_MACHINE_ARM64)
>      return NULL;

We're doing this because nobody being able to debug ARM64 assembler came
up with a piece of code checking the ntdll assembler code to find the
address of the fast_cwd_pointer on ARM64.

You seem to have the knowledge and the means to do that, Jeremy.

Any fun tracking this down?


Thanks,
Corinna

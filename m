Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3FDBE3858C01; Mon, 13 Nov 2023 17:04:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3FDBE3858C01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699895075;
	bh=5QqXbXeWNSJ/t9zYYfhYW33meMMAFHAmcrrpf+U9QWw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=HE8M/t378tfyqoyfAL7MYIuBiVUM/EHlpFxx+mHadjZZkHIvkcJaf9No8h/nu+03o
	 7LDM5thAiR3x6t2wWe+jkWUlV0OEb1UrVPepMdCy5anolYjCkoKTGThFtut4e9e5mi
	 def7VdjWNbHFq7wxwSHtf7rn6+vg4QS0V0okg9n0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 43F80A80A3D; Mon, 13 Nov 2023 18:04:33 +0100 (CET)
Date: Mon, 13 Nov 2023 18:04:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix profiler error() definition and usage
Message-ID: <ZVJXISABdv5P8pqw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20231113094622.6710-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113094622.6710-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Nov 13 01:46, Mark Geisert wrote:
> Minor updates to profiler and gmondump, which share some code:
> - fix operation of error() so it actually works as intended
> - resize 4K-size auto buffer reservations to BUFSIZ (==1K)
> - remove trailing '\n' from 2nd arg on error() calls everywhere
> - provide consistent annotation of Windows error number displays
> 
> Fixes: 9887fb27f6126 ("Cygwin: New tool: profiler")
> Fixes: 087a3d76d7335 ("Cygwin: New tool: gmondump")
> Signed-off-by: Mark Geisert <mark@maxrnd.com>

Looks good basically, but I noticed some minor problem already
in the former version of this code:

> @@ -650,7 +652,7 @@ ctrl_c (DWORD)
>    static int tic = 1;
>  
>    if ((tic ^= 1) && !GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0))
> -    error (0, "couldn't send CTRL-C to child, win32 error %d\n",
> +    error (0, "couldn't send CTRL-C to child, Windows error %d",
>             GetLastError ());
>    return TRUE;

GetLastError returns a DWORD == unsigned int. %u would be the
right format specifier.  Care to fix that, too?


Thanks,
Corinna

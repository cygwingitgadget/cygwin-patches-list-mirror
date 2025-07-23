Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 07EA63858D3C; Wed, 23 Jul 2025 09:04:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 07EA63858D3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753261444;
	bh=Ebo12GXEfU/Cge98eQKQ5g5Yx7H2auF732FEMI9ty2I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=V9vrVpVgxZkOm7B7iONX/+p3++d5IkcFgkKGtezXrFIolV+tqhb3FW901oNOdWb1s
	 mJoZG+k/XrEGfwxqXQc4iKNB6NN7pPk90CkkdMcPbT96AOqPwPqwP/D6FfSg4rbk9X
	 MnCdu7DBVjQa7YrsTYCJFp6rrqBy/SA+UJJKefQ8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 589F0A80CF9; Wed, 23 Jul 2025 11:04:02 +0200 (CEST)
Date: Wed, 23 Jul 2025 11:04:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: process_fd: Fix handling of archetype fhandler
Message-ID: <aIClgpTaJ_6khEmq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul 22 21:32, Takashi Yano wrote:
> Previously, process_fd did not handle fhandler using archetype
> correctly. Due to lack of PC_OPEN flag for path_conv, build_fh_pc()
> could not initialize archetype. Because of this bug, accessing pty
> or console via process_fd fails.
> 
> With this patch, use build_fh_name() with PC_OPEN flag instead of
> build_fh_pc() to set PC_OPEN flag to path_conv.

Your patch fixes the issue, ok, but I don't understand why this occurs.

If the process opens /proc/PID/fd/N with PID != MYPID, it uses the
PICOM_FILE_PATHCONV commune request.  It copies the path_conv member
of the fd from the target process and this pc is used in the
build_fh_pc() call.

And here's what I don't get: If the pc has been fetched from a valid,
open file descriptor in the target process, why is the PATH_OPEN
flag not set?


Thanks,
Corinna



> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-May/258167.html
> Fixes: 7aca27b4fe55 ("Cygwin: introduce fhandler_process_fd and add stat(2) handling")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/process_fd.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/process_fd.cc b/winsup/cygwin/fhandler/process_fd.cc
> index d81495103..14ae8746a 100644
> --- a/winsup/cygwin/fhandler/process_fd.cc
> +++ b/winsup/cygwin/fhandler/process_fd.cc
> @@ -97,7 +97,7 @@ fhandler_process_fd::fetch_fh (HANDLE &out_hdl, uint32_t flags)
>  	      pc.get_posix ());
>        pc.set_posix (fullpath);
>      }
> -  fhandler_base *fh = build_fh_pc (pc);
> +  fhandler_base *fh = build_fh_name (pc.get_posix (), PC_OPEN);
>    if (!fh)
>      {
>        CloseHandle (hdl);
> -- 
> 2.45.1

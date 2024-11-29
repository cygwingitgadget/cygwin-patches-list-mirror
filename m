Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AF9763858D35; Fri, 29 Nov 2024 09:58:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AF9763858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732874300;
	bh=WWW6UoN9s+NuKTUMZh0Y9344HFYLZ0ilGs62vK16t48=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=qHu7uro1kWNOFO8OWcNaFSkZxVyybiy+rEsvRVu7wCm/ENmlrqnqHQHFOwr99Xf03
	 xSM/HtfAEpMKcCMTXtM8tkONWkP0jileKyH169XoLKfb654o2BVD9YCXYOtfl5bryw
	 IfUfL37fEPwYgWVM2ZFxWnaAy62/Tvcx56JxL8Wg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A814EA80984; Fri, 29 Nov 2024 10:58:18 +0100 (CET)
Date: Fri, 29 Nov 2024 10:58:18 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
Message-ID: <Z0mQOsUdxUvGQPS1@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4b3e07b2-bd40-088e-6a90-f6d7dca00a54@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b3e07b2-bd40-088e-6a90-f6d7dca00a54@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 11:22, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> This was already used in the FAST_CWD check, and could be used in a
> couple other places.
> 
> I found the "emulated"/process value returned from the function largely
> useless, so I did not cache it.  It is useless because, as the docs say,
> it is set to IMAGE_FILE_MACHINE_UNKNOWN (0) if the process is not
> running under WOW64, but Microsoft also doesn't consider x64-on-ARM64 to
> be WOW64, so it is set to 0 regardless if the process is ARM64 or x64.
> You can tell the difference via
> GetProcessInformation(ProcessMachineTypeInfo), but for the current
> process even that's overkill: what we really want to know is the
> IMAGE_FILE_MACHINE_* constant for the Cygwin dll itself, which is
> conveniently located in memory already, so cache that in wincap also for
> easy comparisons.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> v2: rename current_module_machine to cygwin_machine, adjust comment and
> remove ifdefs from fallback case when IsWow64Process2 fails.
> 
> v3: cache cygwin_mach as member in wincapc, rename extern IMAGE_DOS_HEADER
> to __image_base__ to avoid __asm__
> 
>  winsup/cygwin/local_includes/wincap.h |  4 ++++
>  winsup/cygwin/path.cc                 |  6 ++----
>  winsup/cygwin/wincap.cc               | 19 +++++++++++++++++++
>  3 files changed, 25 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna

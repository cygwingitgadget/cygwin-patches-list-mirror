Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 436A73858CDB; Mon,  9 Dec 2024 10:20:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 436A73858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733739651;
	bh=Mj8+eotbTFqekY0tOWxfkocufWC/2/LQMuMBql9ow5g=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=hYHiR2MfjMiop2IDom8SzQky0o+qMnPgtNNWQd0g/wedfGvY6PIj9dtRhl90VJ6g6
	 FXaFNTGpMrLiotHLOwACQdWq27LgDAYxWIU94iTcuPlxJD5LEwxAEbD7l01O01T5tN
	 c0/VnEuVOpKYHcWiduwkOrBmjvqDu7cVChtidLZA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 313D8A80B6E; Mon,  9 Dec 2024 11:20:49 +0100 (CET)
Date: Mon, 9 Dec 2024 11:20:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
Message-ID: <Z1bEgYIYR43Jn45A@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3a052da3-f60e-1d7a-f741-956926af23da@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a052da3-f60e-1d7a-f741-956926af23da@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Dec  6 17:52, Christian Franke wrote:
> A first attempt to add SCHED_BATCH.
> 
> Still TODO:
> - Add SCHED_IDLE/BATCH to winsup/doc/posix.xml
> - Provide correct values in (18) and (19) of /proc/PID/stat for SCHED_BATCH.
> - Provide correct value in (18) of /proc/PID/stat for SCHED_FIFO/RR.
> 
> -- 
> Regards,
> Christian
> 

> From 0822917252fdade3edc240b4fbfd3c0f47ef1deb Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Fri, 6 Dec 2024 17:32:29 +0100
> Subject: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
> 
> Add SCHED_BATCH to <sys/sched.h>.  SCHED_BATCH is similar to SCHED_OTHER,
> except that the nice value is mapped to a one step lower Windows priority.
> Rework the mapping functions to ease the addition of this functionality.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  newlib/libc/include/sys/sched.h          |   8 ++
>  winsup/cygwin/local_includes/miscfuncs.h |   4 +-
>  winsup/cygwin/miscfuncs.cc               | 155 +++++++++++++----------
>  winsup/cygwin/release/3.6.0              |  11 +-
>  winsup/cygwin/sched.cc                   |  15 ++-
>  winsup/cygwin/syscalls.cc                |  20 +--
>  6 files changed, 129 insertions(+), 84 deletions(-)
> 
> diff --git a/newlib/libc/include/sys/sched.h b/newlib/libc/include/sys/sched.h
> index c96355c24..265215211 100644
> --- a/newlib/libc/include/sys/sched.h
> +++ b/newlib/libc/include/sys/sched.h
> @@ -38,6 +38,14 @@ extern "C" {
>  #define SCHED_FIFO     1
>  #define SCHED_RR       2
>  
> +#if __GNU_VISIBLE
> +#if defined(__CYGWIN__)
> +#define SCHED_BATCH    0
> +#else
> +#define SCHED_BATCH    3
> +#endif
> +#endif

I would prefer that SCHED_BATCH gets its own, single value.
There's no good reason to add another ifdef for that.  Why
not just #define SCHED_BATCH 6?


Thanks,
Corinna

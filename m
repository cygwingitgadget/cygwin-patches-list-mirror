Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C18133858D20; Tue, 22 Oct 2024 15:06:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C18133858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729609575;
	bh=apqPAKGGTuv6akH0wvLseeFVZOQ06cM6ZzEvgVU9xvo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XonqRfeaUuPE9I8O8bMKfOSH+JL88DPp2AL5N9JBK3N2oddpLx8l50XO5khVMnPcz
	 KrlROIEM7yO2+16OeoCQk1Z3DuwQsp+mReAS9ArmtKO/HTQOn7S4M+7t5N2fJhozbN
	 Bc0dHSAac7JLODqTEi95mKNrLQLRs+Codl2Vmofk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9CFBAA80D05; Tue, 22 Oct 2024 17:06:13 +0200 (CEST)
Date: Tue, 22 Oct 2024 17:06:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: timer_delete: Fix return value
Message-ID: <Zxe_Zfp0BZL_bngZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <fb690e19-367f-0741-fffe-90c30df16351@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb690e19-367f-0741-fffe-90c30df16351@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Oct 12 18:58, Christian Franke wrote:
> Nobody checks the return value of functions which only free resources:
> close(), ..., timer_delete(), ... :-)

Sigh.  Apparently I broke it in 2019, see commit 229ea3f23c015.

> From 2d0c5b53bba2ded8d85ed725774498cffbb4f1de Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Sat, 12 Oct 2024 18:47:00 +0200
> Subject: [PATCH] cygwin: timer_delete: Fix return value
> 
> timer_delete() always returned failure.  This issue has been
> detected by 'stress-ng --hrtimers 1'.
> 

Please add

  Fixes: 229ea3f23c015 ("Cygwin: posix timers: reimplement using OS timer")

> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/posix_timer.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/posix_timer.cc b/winsup/cygwin/posix_timer.cc
> index 9d832f201..a336b2bc2 100644
> --- a/winsup/cygwin/posix_timer.cc
> +++ b/winsup/cygwin/posix_timer.cc
> @@ -530,6 +530,7 @@ timer_delete (timer_t timerid)
>  	  __leave;
>  	}
>        delete in_tt;
> +      ret = 0;
>      }
>    __except (EFAULT) {}
>    __endtry
> -- 
> 2.45.1
> 

Also add an entry for the release/3.5.5 file, please.


Thanks,
Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 951D23858C74; Thu, 13 Jul 2023 10:19:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 951D23858C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689243544;
	bh=BkqiwSPVs8KBedkg/l0LPvDzxCADMnhokYYf43O8zUo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=MaNBUH1vYJ7A5CUe8fAk1nALerf36u/CvjubSRAyHWVUQVUsYtwLNWnWiEJLF1b+n
	 DtARRK+HQCMuBb6XJFeKuHnlwUOaPWliixVOxLn42Vurd2cHOL4LQdXC9jI/NwFyxx
	 chuSmDxxlmmvOtEYcZ9ZnF1PVZ5ZQWeN2hVGRqpc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9C41AA80F7B; Thu, 13 Jul 2023 12:19:02 +0200 (CEST)
Date: Thu, 13 Jul 2023 12:19:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Update release/3.4.8 for latest <sys/cpuset.h>
 commit
Message-ID: <ZK/PlmQHs2CcaaJM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713053659.379-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713053659.379-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 12 22:36, Mark Geisert wrote:
> ---
>  winsup/cygwin/release/3.4.8 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/release/3.4.8 b/winsup/cygwin/release/3.4.8
> index d1e34ce3c..3113be8cb 100644
> --- a/winsup/cygwin/release/3.4.8
> +++ b/winsup/cygwin/release/3.4.8
> @@ -3,3 +3,6 @@ Bug Fixes
>  
>  - Make <sys/cpuset.h> safe for c89 compilations.
>    Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
> +
> +- Make gcc-specific code in <sys/cpuset.h> compiler-agnostic.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2023-July/253927.html
> -- 
> 2.39.0

Pushed.


Thanks,
Corinna

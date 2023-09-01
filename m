Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C36EE3858D20; Fri,  1 Sep 2023 19:12:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C36EE3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1693595550;
	bh=9Hg6NzA8829Ukwm3PxC4sVaIR8wgbvlCdt2Z0MAh6So=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BW9jetpQxeAGBKHsjGpNwPFvvQoaBlrFm8wRNQ/hNtcij6DuolN+6iFlQvgXbA2sP
	 5kBfZmvD1yR6p3iC6o+raGdp0JUO03RKPmV9WM2gQYB/5AqfFxXky+x3nGRyXW3Bsf
	 rbzhlSdRV6RdgjvNWL26HttZpfG9IXAiXvAY1xcg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 17268A8041A; Fri,  1 Sep 2023 21:12:29 +0200 (CEST)
Date: Fri, 1 Sep 2023 21:12:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: cpuinfo: Linux 6.5 additions
Message-ID: <ZPI3nUfXDwJdKlQ+@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <eee1b0143719407f8db6cb2767d093bc12efd738.1693589725.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eee1b0143719407f8db6cb2767d093bc12efd738.1693589725.git.Brian.Inglis@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

On Sep  1 11:42, Brian Inglis wrote:
> add AMD 0x8000001f EAX 14 debug_swap SEV-ES full debug state swap
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
> ---
>  winsup/cygwin/fhandler/proc.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
> index cbc49a12a417..be107cb8eacc 100644
> --- a/winsup/cygwin/fhandler/proc.cc
> +++ b/winsup/cygwin/fhandler/proc.cc
> @@ -1652,7 +1652,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  /*	  ftcprint (features2, 11, "sev_64b");*//* SEV 64 bit host guest only */
>  /*	  ftcprint (features2, 12, "sev_rest_inj");   *//* SEV restricted injection */
>  /*	  ftcprint (features2, 13, "sev_alt_inj");    *//* SEV alternate injection */
> -/*	  ftcprint (features2, 14, "sev_es_dbg_swap");*//* SEV-ES debug state swap */
> +	  ftcprint (features2, 14, "debug_swap");   /* SEV-ES full debug state swap */
>  /*	  ftcprint (features2, 15, "no_host_ibs");    *//* host IBS unsupported */
>  /*	  ftcprint (features2, 16, "vte");    *//* virtual transparent encryption */
>  	}
> -- 
> 2.39.0

Pushed.

Thanks,
Corinna

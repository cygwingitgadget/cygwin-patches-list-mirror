Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9A9703858D37; Thu, 31 Aug 2023 09:08:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9A9703858D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1693472885;
	bh=d0Kk6a2Qz1s5nKZBBrSgPBb2u/4pU0388W52rOUzonU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Uj0z+/epG4VwcXCdAMgl6Q3OKoT8mBQRc/JiUICkX9OWy2zDXVXNUZcM/NRf7Cc3p
	 UCxjefzk16AfBuG/shjyzvNonBvz3BFF/3DaH5SVGhaGWzodRjP53vURljTqenPfkp
	 kwvnFNJ4whhtLpjsdMsmQlZLrFTs73Rw4JSiD7jM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8BC6AA807AC; Thu, 31 Aug 2023 11:08:03 +0200 (CEST)
Date: Thu, 31 Aug 2023 11:08:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cpuinfo: Linux 6.5: add AMD 0x8000001f EAX 14
 debug_swap SEV-ES full debug state swap
Message-ID: <ZPBYc2ut2HAIWZCw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55a6a662221998fa93a01eeb0832e39e510b9cd2.1693454909.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55a6a662221998fa93a01eeb0832e39e510b9cd2.1693454909.git.Brian.Inglis@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

nothing against the patch as such, but your subject line is not so nice.
As it becomes the commit message first line, it should be shorter.  Add
more descriptive text instead, please, and make sure that it tells the
reader what you're really doing, i. e.:

You write "add <something>", but your patch is actually exchanging one
<somthing> with another <something>.

The reader of the commit message would probably like to know why you're
doing that. Partially copying the original Linux kernel commit message
should be ok.

Also, given that changes a string, does it qualify for a "Fixes:" tag?


Thanks,
Corinna


On Aug 30 22:10, Brian Inglis wrote:
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

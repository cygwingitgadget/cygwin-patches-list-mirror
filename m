Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 901934BA2E20; Thu, 15 Jan 2026 09:57:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 901934BA2E20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1768471052;
	bh=UMG1IvhQuVJJ0frcCzOY9f4QviQyCzo8T6sSwJMbtBI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mptXDhxNPOVE8st9nQEnXKhLkDT5IlMfNuBQ+fFVOJG1oqxDm59QZ2dKUsA0JLCrl
	 oh+fx73xIqe/I/0YS/QN6gG5EYYzmDBRGXVjevZI2emJ7fv/T8rj9tdAgXLIrE68jP
	 YmByFsa0PBml1t0Z1Q18l9gJR+Ji7cLaCzCdk4ck=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 893D7A80C88; Thu, 15 Jan 2026 10:57:30 +0100 (CET)
Date: Thu, 15 Jan 2026 10:57:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: gendef: Implement _sigfe function for TLS
 handling on AArch64
Message-ID: <aWi6CvAx4PNPJexK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082B91F52855CCC343FEEF99FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB3082B91F52855CCC343FEEF99FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,


I was just trying to apply your gendef patches, but this patch here
doesn't apply cleanly due to context diffs:

On Dec 19 17:34, Thirumalai Nagalingam wrote:
> Hi all,
> 
> Please find the attached patch which adds an ARM64 stub for the `_sigfe` routine
> in the gendef script.
> 
> Any feedback or nits are very welcome. The changes are documented with inline
> comments intended to be self-explanatory. please let me know if any part
> of this patch should be adjusted.
> 
> Thanks for your time and review.
> 
> Thanks & regards
> Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> 
> In-lined patch:
> [...skipping to the end of the patch...]
> +    br      x9                         // Branch to real function
> +    .seh_endproc
> +
>  _sigbe:
>         .global sigdelayed
>         .seh_proc sigdelayed
> 

After appling the first two patches

 0001-Cygwin-gendef-add-ARM64-stub-for-fe-in-gendef.patch
 0002-Cygwin-gendef-add-_sigfe_maybe-for-TLS-initializatio.patch

the above sigdelayed context looks like this:

> _sigbe:
>         .global sigdelayed
> sigdelayed:
> _sigdelayed_end:

Is there anything missing here?  Another patch which should be
applied boefore this one?


Thanks,
Corinna

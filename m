Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 631354BA2E2A; Fri, 19 Dec 2025 11:01:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 631354BA2E2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766142089;
	bh=KASadNLKSgyuWFyRk5W563HWQo/avLtwemHW+Qgz61Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XonQIlRm+XlrStgXZPx9uq8PQLz0zhKeM1Cj9jV+u1KqVbvMKf9SUISFAkOF7NSTq
	 9Jo2WYB+ZYIgdhRfdkeOB72KXym6Vz5ifRcToTB2Zd9/WJD8/EIArgbs4+Io6u8VnS
	 JhnzAUOGNapP1QNdjDC9FfbUnQtLGFl0SA4zPVmU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 13048A80BEF; Fri, 19 Dec 2025 12:01:27 +0100 (CET)
Date: Fri, 19 Dec 2025 12:01:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [WIP::PATCHES] [RFC] Preliminary ARM64 compilation support for
 Cygwin
Message-ID: <aUUwh5EFke-rrQTV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082C051C4E43AB64AD4B9959FA2A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aTmvvwfClr2suB2R@calimero.vinschen.de>
 <MA0P287MB30824A7CD2D09D49825C01809FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB30824A7CD2D09D49825C01809FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

On Dec 19 10:04, Thirumalai Nagalingam wrote:
> 
> > Just one nit for now.  The first patch contains newlib/Makefile.in but not newlib/Makefile.am.  
> > Please make sure to change Makefile.am instead.
> 
> Hi Corinna,
>  
> Thank you for the review.
>  
> The changes in Makefile.in is directly due to the Cygwin build workflow[1] (cygwin.yml), which does not run a configure step for
> the newlib subtree, unlike what is done for the winsup directory. 
> As a result, the changes made in Makefile.inc (as in this case) would not propagate into the build.
>  
> The functional changes themselves are confined to newlib/libm/Makefile.inc, which is included by newlib/Makefile.am,
> and therefore, would normally be reflected in the generated newlib/Makefile.in.
> However, since the newlib subtree is not reconfigured in workflow, the corresponding updates
> were applied directly to Makefile.in which were regenerated using automake in local setup.
>  
> [1]- https://github.com/cygwin/cygwin/blob/9fac993ba74bd6ab3fc638a169ffdc92b78bd679/.github/workflows/cygwin.yml#L150

Ok, got it.  But, as for the workflow:

You should create patches for newlib separately from patches for Cygwin
and send them to the newlib mailing list.  Given the order in which
things are built in the repo, it's usually better to send the newlib
stuff prior to sending any changes to Cygwin which are affected by the
newlib change.

The patch changing the affected Makefile.inc files should contain only
the changes to the inc file.  Jeff or I will then regenerate the
Makefile.in and configure files as necessary.

The advantage is that you can seperate the newlib stuff out and nobody
has to review generated files, only the input files.


Thanks,
Corinna

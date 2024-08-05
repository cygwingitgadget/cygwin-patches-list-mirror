Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BE46E385841C; Mon,  5 Aug 2024 10:18:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BE46E385841C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1722853132;
	bh=HY77zvg58d0Vm2QOFpX5g5oo0b41Cf0haL5fRSwbc/Q=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=oK/U6MAuFbfS1k0W+JPFxdITpwdOBPIxu/2pznFobE8U5BSZhPkJEBfdsL9Qhc2DG
	 Kn74n+AtzgpvY+2r2CGYYje30Skxi0TNUCc4wwWzl4eRb7dM0NHoQjcXBxoEtZLp6s
	 D3yGZqosRcdfmSQL/x1dSjRxQc8/L5L2pLe9XK1g=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9FCE6A80571; Mon,  5 Aug 2024 12:18:50 +0200 (CEST)
Date: Mon, 5 Aug 2024 12:18:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/6] Cygwin: Fix warning about narrowing conversions in
 tape options
Message-ID: <ZrCnCswBFvV3Olf0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-5-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804214829.43085-5-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Aug  4 22:48, Jon Turney wrote:
> Fix a gcc 12 warning about a narrowing conversion in case labels for
> tape options.
> 
> > In file included from /wip/cygwin/src/winsup/cygwin/include/sys/mtio.h:14,
> >                  from ../../../../src/winsup/cygwin/fhandler/tape.cc:13:
> > ../../../../src/winsup/cygwin/fhandler/tape.cc: In member function ‘int mtinfo_drive::set_options(HANDLE, int32_t)’:
> > ../../../../src/winsup/cygwin/fhandler/tape.cc:965:12: error: narrowing conversion of ‘4026531840’ from ‘unsigned int’ to ‘int’ [-Wnarrowing]
> ---
>  winsup/cygwin/fhandler/tape.cc        | 4 ++--
>  winsup/cygwin/local_includes/mtinfo.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

With Signed-off-by, LGTM.


Thanks,
Corinna

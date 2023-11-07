Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A3C4E3858C53; Tue,  7 Nov 2023 15:23:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A3C4E3858C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699370630;
	bh=cgrL/kwZMi2hTdwR+huiriRc/Tcox6g62H/BXnmqjhw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JxDVGaLv35R9b7Yh+jkfoa1nUDx0ZOK7Vsqul2UdOEjbp+gWffSwKov8UUH7OVKMX
	 RRclnRNikKHvW5tC/KhKcmODYCVSoe5AIMY37PgPxI+ngSqNVKoj72Faqtsf/6TVQz
	 15S7hW/8164aSpg94KPs0yvBoP3iVybKOKzqsCGA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EF086A807B8; Tue,  7 Nov 2023 16:23:48 +0100 (CET)
Date: Tue, 7 Nov 2023 16:23:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUpWhB6TO09hgF3P@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <1133d1d3-e6d9-4a52-a595-89ee338f8d2f@t-online.de>
 <ZUYQPPsrxf5yp1Ir@calimero.vinschen.de>
 <ZUYVeeYDcAKC74wg@calimero.vinschen.de>
 <c82507ab-193a-4a85-7ef0-64f7a7f30705@t-online.de>
 <ZUautCVKk4bXD4q4@calimero.vinschen.de>
 <eeee1473-7902-6ef7-9fab-cfc3f4eb2785@t-online.de>
 <ZUf0DwCsxbuPR3iL@calimero.vinschen.de>
 <3074268d-edb9-6eef-f486-c9caedb6d54c@t-online.de>
 <ZUo7ydnzBK8HM8FI@calimero.vinschen.de>
 <31771842-9012-b781-6197-84fae3570a24@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31771842-9012-b781-6197-84fae3570a24@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  7 15:30, Christian Franke wrote:
> Corinna Vinschen wrote:
> > ..
> > Looking forward to it. We'll just need an entry for the release text
> > in winsup/cygwin/release/3.5.0 and doc/new-features.xml in the end :)
> 
> Attached for now as implementing the remaining subdirs is not yet scheduled.
> Docbook formatting not tested.

Looks good, pushed.


Thanks,
Corinna

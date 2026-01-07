Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E6BF14BA2E05; Wed,  7 Jan 2026 10:35:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E6BF14BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1767782133;
	bh=GtwgvnMfTsKay54LXo3dJoHxtpWVeSE2GCdWP48DceE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QFdSSqPi+jhQf5sLfN5b0h4Ogz8ZpjufEyYZeSrP+Z7uxoCmBjyvRQmyR83x/Q0LT
	 np8ne23mNpUKu+NBY5060sVP54cKo56e3NOlRQCQNSl7J6L9HNbOnG81wCccdUBVMd
	 0GsD/FeQT2XLrNxFU4hlJB4iFQexuaR2bu7NnBng=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0E8C3A80D4B; Wed, 07 Jan 2026 11:35:32 +0100 (CET)
Date: Wed, 7 Jan 2026 11:35:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: Re: [PATCH] Cygwin: gendef: add ARM64 stub for $fe in gendef
Message-ID: <aV429H_JwfdwyPvX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	Jeremy Drake <cygwin@jdrake.com>
References: <MA0P287MB3082D3D7B7FBAE7E1009D6989FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aUkmocusEY_fkro9@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUkmocusEY_fkro9@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

Oh drat, I just realized that I said I CC Jeremy and then forgot.
Now he's CCed, sorry!

On Dec 22 12:08, Corinna Vinschen wrote:
> [CC Jeremy, would be nice if you could take a look into the assembler
>  code.  Thanks!]
> 
> On Dec 19 17:17, Thirumalai Nagalingam wrote:
> > Hi all,
> > 
> > Please find the attached patch which adds an ARM64 stub for the $fe routine in
> > the gendef script.
> > 
> > Any feedback or nits are very welcome. The changes are documented with inline
> > comments and is intended to be self-explanatory. please let me know if any part
> > of this patch should be adjusted.
> 
> The comments explain nicely, thanks.  The same goes for your other three
> patches to the gendef script.  I just can't check reliably on the
> correctness of the assembler code, that's why I'm CCing Jeremy.
> 
> The only minor nit I have: There's a TODO comment prior to this code
> snippet.  This patch should probably remove it, given it adds the
> missing code.
> 
> 
> Thanks,
> Corinna

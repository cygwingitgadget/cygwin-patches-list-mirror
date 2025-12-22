Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C51294BA2E25; Mon, 22 Dec 2025 11:08:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C51294BA2E25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766401699;
	bh=uKzDT7BhDSIN9kc6FVvtgM2j4bd0usQYqKH+tzUWPoQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=V+7wqF0JxQUVPvhpOGgcN11mFceazhqhssOMq4iluqfYVKs8C/9/b2jhCsVR+t2Gl
	 KYNznZvuyAhURVj1mmgf+Ylu1GPQR4NHbZeNziworuRNNvQw4QGPfxK4LPcKmUIB6H
	 vYC+kF5l6qpiwqJlkdXIXC5gUlv25QejAhF6Edc4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B02F3A80D4B; Mon, 22 Dec 2025 12:08:17 +0100 (CET)
Date: Mon, 22 Dec 2025 12:08:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: Re: [PATCH] Cygwin: gendef: add ARM64 stub for $fe in gendef
Message-ID: <aUkmocusEY_fkro9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	Jeremy Drake <cygwin@jdrake.com>
References: <MA0P287MB3082D3D7B7FBAE7E1009D6989FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB3082D3D7B7FBAE7E1009D6989FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

[CC Jeremy, would be nice if you could take a look into the assembler
 code.  Thanks!]

On Dec 19 17:17, Thirumalai Nagalingam wrote:
> Hi all,
> 
> Please find the attached patch which adds an ARM64 stub for the $fe routine in
> the gendef script.
> 
> Any feedback or nits are very welcome. The changes are documented with inline
> comments and is intended to be self-explanatory. please let me know if any part
> of this patch should be adjusted.

The comments explain nicely, thanks.  The same goes for your other three
patches to the gendef script.  I just can't check reliably on the
correctness of the assembler code, that's why I'm CCing Jeremy.

The only minor nit I have: There's a TODO comment prior to this code
snippet.  This patch should probably remove it, given it adds the
missing code.


Thanks,
Corinna

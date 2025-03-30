Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BD0073857B9E; Sun, 30 Mar 2025 21:39:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BD0073857B9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743370788;
	bh=F0YNw3QrUMUojjWHTZNrTmkZ0UaJZSKUatHyrv+VPLU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Mg/3f4FDnnU6HpnoshYUne8g7lVXvJHzsbD7+OKio0Rkxrj+G0les6bGfJSPnu4fR
	 hW8Acy9S4Idej35aD+pGGb0D0ikN2d4ONjwQhhZnyhoTlsILVM8TMhGt8F1Efg0Aru
	 4uR/oESHX3Rn5uQNG1U2rYNVCit6R3YS1fl4WTtA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BFB76A80961; Sun, 30 Mar 2025 23:39:45 +0200 (CEST)
Date: Sun, 30 Mar 2025 23:39:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-m6ISyTeTULAWXf@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

Series looks good to me, just one question to clarify:

On Mar 29 18:54, Jeremy Drake via Cygwin-patches wrote:
> v4:
> fixes x86_64-on-aarch64 on Windows 11 22000.

Does aarch64 use entirely different build numbers?  Just asking because
22000 looks unusually low.  The latest release build of x86_64 Windows
11 has build id 26100...


Thanks,
Corinna

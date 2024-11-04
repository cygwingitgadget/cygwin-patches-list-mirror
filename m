Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 67BBD3858C2B; Mon,  4 Nov 2024 14:42:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 67BBD3858C2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730731337;
	bh=eF01mJ9LTg3Fy/P5emH0ACqAZrlpo4ZP9UlvlD8v2pI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=iyM5LSNROCFR0w3mJxKDQ8dh6foDfuLH+8QHc7urzqBxRyh+imKX+U3lkI3YH9riC
	 ikjzr5Tvlz6gePIKZyBy0mzXl1DfYGG4Y2Jpdj81nPpDRBvot7C9QjbtOcJ7Ryy/+9
	 5d4Z/ZdVaNRnOHr9Rr3/L/ZQAd6hQZmKeGrsfHxU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 551A9A80C4D; Mon,  4 Nov 2024 15:42:15 +0100 (CET)
Date: Mon, 4 Nov 2024 15:42:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
Message-ID: <ZyjdR399oojfY8r8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
 <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
 <63c03788-6b71-44b3-abc3-5de29e79971e@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63c03788-6b71-44b3-abc3-5de29e79971e@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 18:02, Mark Geisert wrote:
> also looks like something Cygwin API version bumps are for.

Yes, CYGWIN_VERSION_API_MINOR needs a bump, thanks for pointing
this out!


Corinna

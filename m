Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C58DC3857830; Wed, 25 Jun 2025 11:45:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C58DC3857830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750851914;
	bh=v6VF6EaMdmeFF2GV1oioN7bGcxxljGHslUrTAyfqhTg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=S3BRrTKrYG0vRSiJ12W7GidjyEzCSPWO3DXhsD9zNaVeg7a14wcbd92v4OOPBV8Xv
	 4EzDx/jv5moGZcVI0q5gFMi/+Qtc719GTdhMFsi2wEx7HwF6mSg047aIzrbWMQXtPi
	 BBWzyTe5qjJ5AN3uMvRN2NceVHgc+ploGPhtL7SI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BB043A80B69; Wed, 25 Jun 2025 13:45:12 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:45:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: stack base initialization for AArch64
Message-ID: <aFvhSLsisB-rdAKI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
 <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com>
 <DB9PR83MB0923E495EA001D0887EC80469279A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFj-bZ28sTEOvVqj@calimero.vinschen.de>
 <DB9PR83MB0923D30C1D31D3B74457118C9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFufJb2PZg1pQ5Ha@calimero.vinschen.de>
 <DB9PR83MB09238E68F3977CC064F2EDC1927BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB09238E68F3977CC064F2EDC1927BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 25 07:23, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Missed that, sorry.
> 
> Thank you for noticing.
> 
> Radek
> ---
> >From 68edd69104961961013f506593b5ccbb2ad0e61a Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 5 Jun 2025 13:15:22 +0200
> Subject: [PATCH v4] Cygwin: stack base initialization for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/dcrt0.cc | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Pushed.


Thanks,
Corinna



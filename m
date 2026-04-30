Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BCF174BA2E0B; Thu, 30 Apr 2026 16:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BCF174BA2E0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1777565447;
	bh=PDP8WQT7ok24da6ccce+LsIYccJ1q/ND0JXaGisUBpI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=b5/9OYmLWPykP4FmiI7x6zDwBYrrSGAqzytF2iI1ORnuRexprk4eJ6KDS2DzWfd8O
	 yTUjTqZwXjRSb9yQXX2eFf9slmMYOp4sQzlEV7j4A8X/P99Ccv+ZsqzVvidHGtK3rL
	 wlvzpjAzASuZH9L8eIsEAop9vUQgKQbbgHRvRGtY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D3A08A80886; Thu, 30 Apr 2026 18:10:45 +0200 (CEST)
Date: Thu, 30 Apr 2026 18:10:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: Adapt math functions to use 64bit long double on
 aarch64
Message-ID: <afN_BQKqRayvKhx2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <PN0P287MB029594AE234FC6A4B7F6B23A92342@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PN0P287MB029594AE234FC6A4B7F6B23A92342@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Chandru,

On Apr 29 11:33, Chandru Kumaresan wrote:
> Hi Corinna,
> The previously mentioned changes are not the only ones required. A few additional files also need to be modified to ensure that Cygwin works correctly on aarch64.
> The approach taken is consistent with mingw-w64. mingw-w64 uses the __SIZEOF_LONG_DOUBLE__ == __SIZEOF_DOUBLE__ macro to implement aarch64-specific code for math functions.
> For reference, a similar approach is used in this upstream mingw-w64 commit:
> https://github.com/mingw-w64/mingw-w64/commit/dbb60ad07c2983027cd09f0f7221505400391caa

Pushed, thank you!


Corinna






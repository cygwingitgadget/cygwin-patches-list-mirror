Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 99FC63858D20; Fri,  1 Sep 2023 11:01:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 99FC63858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1693566069;
	bh=ARhcDuSjrBBybGKpQ08coryj3IHUpa5d/zldkYPKouw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=aIBqq67cMsa95esqxdci41aO8WH5Zr19e3KXFiDwDXKGfVXXMcorxmZKrshDre5/L
	 K0g76zfG9TUvG+cYNzJKDuoSsup4/H9YXUh5bmfK/u1dIBNvxAtrbTl51sEOkQp0nT
	 7tKYRv5P0bFDMIeeu78L9w/BKmQEoQEFbmIx/1RA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A4DB6A803AE; Fri,  1 Sep 2023 13:01:07 +0200 (CEST)
Date: Fri, 1 Sep 2023 13:01:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Implement sound mixer device.
Message-ID: <ZPHEc0sPrZGrSLk7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230901100430.58560-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901100430.58560-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Sep  1 19:04, Takashi Yano wrote:
> This patch adds implementation of OSS-based sound mixer device. This
> allows applications to change the sound playing volume.

Cool!  Go ahead, that's a nice addition.

> NOTE: Currently, the recording volume cannot be changed.

I guess you're already hacking on adding that :)


Thanks,
Corinna

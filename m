Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 838C33858D34; Tue, 19 Nov 2024 19:32:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 838C33858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732044769;
	bh=U9gWQ94edCDBCq+pKtokYzMiK4v8i7F4UHU0oT5ez5c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RUTS4N2N6KvVGyTTEd02sgt2o3TaJppm7PUoGZIYeN71fBD0cqZLn3NU8xtHzkav6
	 Xk+IIy2Dev+TQBjppI4HyJz7nKZHdlCo8lEPUdfjqi2fLEsU5jxU9QFEDVjGkGR9/5
	 Rp4KIXTzoDCTRg+wGLol6WJPS0ZP5rwjI7YpjStg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D3DA2A80D6C; Tue, 19 Nov 2024 20:31:45 +0100 (CET)
Date: Tue, 19 Nov 2024 20:31:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add libaio to SUBLIBS built for Cygwin
Message-ID: <ZzznoWJXU0E-sfWI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241119081133.57253-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119081133.57253-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Nov 19 00:11, Mark Geisert wrote:
> Provide libaio.a for those projects (such as stress-ng) checking for
> POSIX aio support by looking for this library at configure time.
> A release note is provided for Cygwin 3.6.0.
> 
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: N/A (new code)
> 
> ---
>  winsup/cygwin/Makefile.am   | 6 +++++-
>  winsup/cygwin/release/3.6.0 | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Pushed.


Thanks,
Corinna

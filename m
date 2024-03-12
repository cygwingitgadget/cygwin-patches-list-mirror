Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 568F63858D32; Tue, 12 Mar 2024 10:53:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 568F63858D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1710240810;
	bh=BN8qDhoAv6TBe+OhstK7LFuk/+7CeKvs2KxHzjFnXM8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lD1+SEP0bWLKNiN9wRNF+v3u5YOGwYdbbG/i5AYVve+JJsC+YUucFmkKwXuDzJbep
	 VvUf/5lbk6PRRHAgMLShL7ge66QqJ68MeonBJNRdn7ApX3CvCn6i0JFI55Zf+INs9a
	 +oeKDBmNT5/XXtQMxwlacRo6q1Tp63Iva52CEQIo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 61FE6A8096C; Tue, 12 Mar 2024 11:53:28 +0100 (CET)
Date: Tue, 12 Mar 2024 11:53:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore non-blocking mode which was reset
 for non-cygwin app.
Message-ID: <ZfA0KI2lcNEPrbm6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240310103202.3753-1-takashi.yano@nifty.ne.jp>
 <Ze7hRBVYCClZg-Kq@calimero.vinschen.de>
 <20240311204237.bb2ffef477328542a63b148d@nifty.ne.jp>
 <20240311221857.7b5175cc76b5c4be7d81896b@nifty.ne.jp>
 <Ze9qgPIptT3EasMm@calimero.vinschen.de>
 <20240312080316.51a75358db94bcfe5c8c2c13@nifty.ne.jp>
 <20240312081722.511ba60494e73f2fadff1880@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312081722.511ba60494e73f2fadff1880@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 12 08:17, Takashi Yano wrote:
> Subject: [PATCH v4] Cygwin: pipe: Make sure to set read pipe non-blocking for
>  cygwin apps.
> 
> If pipe reader is a non-cygwin app first, and cygwin process reads
> the same pipe after that, the pipe has been set to bclocking mode
> for the cygwin app. However, the commit 9e4d308cd592 assumes the
> pipe for cygwin process always is non-blocking mode. With this patch,
> the pipe mode is reset to non-blocking when cygwin app is started.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-March/255644.html
> Fixes: 9e4d308cd592 ("Cygwin: pipe: Adopt FILE_SYNCHRONOUS_IO_NONALERT flag for read pipe.")
> Reported-by: wh <wh9692@protonmail.com>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc          | 63 +++++++++++++++++++++++++
>  winsup/cygwin/local_includes/fhandler.h |  3 ++
>  winsup/cygwin/spawn.cc                  | 34 +------------
>  3 files changed, 68 insertions(+), 32 deletions(-)

Looks good, please push.


Thanks,
Corinna


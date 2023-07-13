Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AA6D83858D32; Thu, 13 Jul 2023 18:05:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA6D83858D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689271533;
	bh=a9jhFmi2+LaQBe46CCDXhCmifZ0oEDLK0ra0+2M0MGM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WXO5JdINh6WeJQjZ1ySdQoe9Aao4Qc2hT4CwoN6h3odwdsvU0tSDum1cOynmWz5V9
	 yzxFTVJx5sWX8VonP32N/HRR7cUtisO8dHlPvbetuZiBKfMWI5jOfz+4DDSEdTdqo6
	 tupmwI2+uyRpPcgROwTDmws2qL+ahyD4xcdV/3+w=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DA6F9A80B9C; Thu, 13 Jul 2023 20:05:31 +0200 (CEST)
Date: Thu, 13 Jul 2023 20:05:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/11] More testsuite fixes
Message-ID: <ZLA866x5ZVUV3wt2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 13 12:38, Jon Turney wrote:
> This gets us from :
> 
> FAIL: cygload
> FAIL: devdsp.c
> FAIL: ltp/access05.c
> FAIL: ltp/fcntl07.c
> FAIL: ltp/symlink01.c
> FAIL: ltp/symlink03.c
> FAIL: ltp/umask03.c
> FAIL: pthread/cancel11.c
> FAIL: pthread/cancel3.c
> FAIL: pthread/cancel5.c
> FAIL: pthread/inherit1.c
> FAIL: pthread/priority1.c
> FAIL: pthread/priority2.c
> FAIL: systemcall.c
> 
> to:
> 
> FAIL: cygload
> FAIL: devdsp.c
> FAIL: ltp/umask03.c
> FAIL: pthread/cancel11.c
> FAIL: pthread/priority1.c
> 
> Notes on the remaining failures:

Please add Signed-off-by tags to your patches.

Thanks,
Corinna

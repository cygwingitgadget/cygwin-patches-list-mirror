Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C10013858418; Sat,  9 Sep 2023 21:29:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C10013858418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1694294963;
	bh=cgrXSStdcYgypufz/zmH7tZVhY8/beDCoiUwYTD9ikc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=uUMH3zQ+NUVm+ZgRZoYyJPfp/aNualZcSFI4qAFp07D+lYY7pefOEKRko9nEPUOdC
	 CtOn/tcwtxvUDbY/VPiC/YbwkevNoUd0JYS5kqEgcQUoSDjBnVFfPWoTlAjfo4/21s
	 JzBmWsdgqZkX6gQYE1EEd2lKrLq4CnHiP7Afe8H4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 234D3A80851; Sat,  9 Sep 2023 23:29:22 +0200 (CEST)
Date: Sat, 9 Sep 2023 23:29:22 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix __cpuset_zero_s prototype
Message-ID: <ZPzjskmDV+RIynoS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230908053639.5689-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908053639.5689-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Sep  7 22:36, Mark Geisert wrote:
> Add a missing "void" to the prototype for __cpuset_zero_s().
> 
> Reported-by: Marco Mason <marco.mason@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2023-September/254423.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: c6cfc99648d6 (Cygwin: sys/cpuset.h: add cpuset-specific external functions)
> 
> ---
>  winsup/cygwin/include/sys/cpuset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pushed, including doc fix.


Thanks,
Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6B1193858D26; Fri, 29 Nov 2024 09:57:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6B1193858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732874277;
	bh=sdHuJc8QDNZw62CsKTGaRFF8hTYw66tevbRw/toIYmM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cN4c6z1oRPRqd9clB0C3cOcVvuOO6u9ZnqcHszW9ul73k/N1ocZD6mwArwbwn4Nyp
	 Gfyj4zfd47NES6qaFse6V9TV2IcpEqUlCaSB3jkbfbXAjMq+pB3Z7g5Oa+mI4sPK6X
	 Ukuv2M7r2GwF1Gpa/1q4EY6LkTFcc9YdzHNVzxCE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 638AFA80984; Fri, 29 Nov 2024 10:57:55 +0100 (CET)
Date: Fri, 29 Nov 2024 10:57:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: nice: align return value and errno with POSIX
 and Linux
Message-ID: <Z0mQIwOMpM4gjh91@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <c1fcf5de-517d-64cb-093b-ad65ca6e87de@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1fcf5de-517d-64cb-093b-ad65ca6e87de@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 18:58, Christian Franke wrote:
> No "Fixes:" in comment because the current behavior emulates old Linux
> behavior which is possibly not a bug.
> 
> SUS 1997 to POSIX 2024 require to return the new nice value.
> https://pubs.opengroup.org/onlinepubs/007908799/xsh/nice.html
> https://pubs.opengroup.org/onlinepubs/9799919799/functions/nice.html
> https://man7.org/linux/man-pages/man2/nice.2.html
> 
> FreeBSD still returns 0:
> https://man.freebsd.org/cgi/man.cgi?query=nice&sektion=3
> 
> Ancient Unix returned nothing :-)
> http://man.cat-v.org/unix_10th/2/nice
> 
> -- 
> Regards,
> Christian
> 

> From 40d17d32e4c0a7dc69f39e57f3d0f9f07fca5c75 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Wed, 27 Nov 2024 18:54:37 +0100
> Subject: [PATCH] Cygwin: nice: align return value and errno with POSIX and
>  Linux
> 
> Return new nice value instead of 0 on success.
> Set errno to EPERM instead of EACCES on failure.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/release/3.6.0 |  4 ++++
>  winsup/cygwin/syscalls.cc   | 11 ++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)

Pushed.


Thanks,
Corinna


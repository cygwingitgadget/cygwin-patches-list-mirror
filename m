Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 03E42382E284; Thu, 27 Mar 2025 11:48:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03E42382E284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743076098;
	bh=gFyzFYYy6tLz6PKZS5SgM6v3OQZe47vRyeyNPqZY+XI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=MSKxXCIvHTzpLYOD5qLP2QIdJWcx4QGZG7yBaTVYbjh7jPD4l7fxkM2M+qlpUvR2U
	 jrVGznxvmeRhk4N9TlSyn5212ezvE6NIhPMpOXzIlTVf8qpexHvQSw2JAYzZQ5TmnK
	 sZeWh/2hM2IwS+UJmXdrz7Js2R/IUEQBfFTZoqd4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E4617A806F0; Thu, 27 Mar 2025 12:48:15 +0100 (CET)
Date: Thu, 27 Mar 2025 12:48:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 5/5] Cygwin: add find_fast_cwd_pointer_aarch64.
Message-ID: <Z-U6_zrqfandDmqr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <24fa8928-2133-b73a-8c1c-28459f48b2da@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24fa8928-2133-b73a-8c1c-28459f48b2da@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 26 16:53, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> This works for aarch64 hosts when the target is aarch64, x86_64, or i686,
> with only a small #if block in one function that needs to care.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/Makefile.am        |   1 +
>  winsup/cygwin/fastcwd_aarch64.cc | 203 +++++++++++++++++++++++++++++++
>  winsup/cygwin/path.cc            |  27 +++-
>  3 files changed, 225 insertions(+), 6 deletions(-)
>  create mode 100644 winsup/cygwin/fastcwd_aarch64.cc

Naah, I don't know.

If you ask me, I would introduce a new directory aarch64 and
move the fastcwd_aarch64.cc file into that dir.  Then rename
them both to fastcwd.cc.

Makefile.am should add the file to TARGET_FILES= for x86_64, i.e.

if TARGET_X86_64
TARGET_FILES= \
        x86_64/bcopy.S \
	x86_64/fastcwd.cc \
	aarch/fastcwd.cc \
	[...]
#endif

If/when we later add a native aarch64 target, you should have
only one file aarch/fastcwd.cc, which is built into Cygwin if
TARGET_X86_64 and in a second block defining TARGET_FILES= for
TARGET_AARCH64.

Make sense?


Thanks,
Corinna

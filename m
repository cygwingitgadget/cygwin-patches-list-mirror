Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 318CA3858C60; Fri, 12 Jan 2024 18:41:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 318CA3858C60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1705084907;
	bh=lUO1xpeJ50Bf5Ys+ffHKrJdoks1gGCVXvO4DFcPqjEo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OW9KGW+rE9bhWoUraIP8jXJzo/z6FoGUWToGAB3MO31oGJpPI9rM2qlovpzedcOfx
	 Qkj5NNQkxbWD5+StVXe24JTz3Z+4lcbejoL+wZNlzSWsPTutbYwwJkr/6yWS6mfJ4J
	 GmOZqiQGIiczxft2xl/XHympo9DQTiBhBo1/uBQs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 59590A807B2; Fri, 12 Jan 2024 19:41:45 +0100 (CET)
Date: Fri, 12 Jan 2024 19:41:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Coredump under 'ulimit -c' control (v2)
Message-ID: <ZaGH6fKiGx6dBjdO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 12 14:09, Jon Turney wrote:
> Write a coredump under 'ulimit -c' control and related changes.
> 
> The idea here is to make debugging using a coredump work as usual on a unix,
> e.g.:
> 
> $ ulimit -c unlimited
> 
> $ ./segv-program
> *** starting '"C:\cygwin64\bin\dumper.exe" "C:\cygwin64\work\segv-program.exe" 16156' for pid 1398, tid 7136
> 
> $ gdb segv-program.exe segv-program.exe.core
> [...]
> 
> Jon Turney (5):
>   Cygwin: Make 'ulimit -c' control writing a coredump
>   Cygwin: Disable writing core dumps by default.
>   Cygwin: Define and use __WCOREFLAG
>   Cygwin: Treat api_fatal() similarly to a core-dumping signal
>   Cygwin: Update documentation for cygwin_stackdump
> 
>  winsup/cygwin/dcrt0.cc                |   6 +-
>  winsup/cygwin/environ.cc              |   1 +
>  winsup/cygwin/exceptions.cc           | 122 ++++++++++++++++++++++----
>  winsup/cygwin/include/cygwin/wait.h   |   5 +-
>  winsup/cygwin/local_includes/winsup.h |   2 +
>  winsup/cygwin/mm/cygheap.cc           |   2 +-
>  winsup/cygwin/release/3.5.0           |   7 ++
>  winsup/doc/cygwinenv.xml              |  25 ++++--
>  winsup/doc/misc-funcs.xml             |   4 +
>  winsup/doc/new-features.xml           |  12 +++
>  winsup/doc/utils.xml                  |  43 +++++----
>  11 files changed, 180 insertions(+), 49 deletions(-)
> 
> -- 
> 2.43.0

This patchset looks good to me, except one typo in the last patch
of the series...

Thanks,
Corinna

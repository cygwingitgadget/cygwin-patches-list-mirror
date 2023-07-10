Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5431E3858D35; Mon, 10 Jul 2023 08:43:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5431E3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688978593;
	bh=OWBnGtkU735/7Sp0nqo8u0+Wi8W5cV6lRaC2xxjpcMc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=II+O4xHRtfiDOeqYEqcjJm7Hg/WWvPIrE5oiWJT7G90pdRXO0UhMMhk4Fm1hP4eak
	 M62w5BgllA61TFOjc0aA3j6DA5KL3RXR+umZzHrm23Zuh9HN8CovjiJXCu/rE1oarO
	 SFY4oEM2O9LreHvRNzcSBAzODLAHZ5y895auHleY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8FAC1A80CD6; Mon, 10 Jul 2023 10:43:11 +0200 (CEST)
Date: Mon, 10 Jul 2023 10:43:11 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
Message-ID: <ZKvEn17628r8CDLa@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230709075922.8599-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230709075922.8599-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  9 00:59, Mark Geisert wrote:
> The current version of <sys/cpuset.h> cannot be compiled by Clang due to
> the use of builtin versions of malloc, free, and memset.  Their presence
> here was a dubious optimization anyway, so their usage has been
> converted to standard library functions.
> 
> The use of __builtin_popcountl remains because Clang implements it just
> like gcc does.  If/when some other compiler (Rust? Go?) runs into this
> issue we can deal with specialized handling then.
> 
> The "#include <sys/cdefs>" here to define __inline can be removed since
> both of the new includes sub-include it.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2023-July/253927.html
> Fixes: 9cc910dd33a5 (Cygwin: Make <sys/cpuset.h> safe for c89 compilations)
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> 
> ---
>  winsup/cygwin/include/sys/cpuset.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Pushed.

Thanks,
Corinna

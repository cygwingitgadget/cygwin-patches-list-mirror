Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9B02B385840F; Mon,  5 Aug 2024 10:11:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9B02B385840F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1722852713;
	bh=NEOSy9FlUaCrja6cqyyU3SpgtwLQSxRrWbJR26aSV0I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=T0Y35Pcz64aT101SirHqJMl290wM/zmJ2jEUeuJRXgIYxRR4V4c5x08Wo2PRQIDWu
	 L9whfJ0j1anYV+PM5TCga8H/7aze06+niXIoo+1wZttFlpC12t0qbkK0vnpXZW+7zE
	 QYrTcn96ecWJl/Wn5Ru8ppQ3n2qCeUMItndKdD6M=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 89032A807E3; Mon,  5 Aug 2024 12:11:51 +0200 (CEST)
Date: Mon, 5 Aug 2024 12:11:51 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/6] Cygwin: Fix warnings about narrowing conversions of
 NTSTATUS constants
Message-ID: <ZrClZ-x3xtEWzVwQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-3-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804214829.43085-3-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Aug  4 22:48, Jon Turney wrote:
> Fix warnings with gcc 12 about narrowing conversions of NTSTATUS
> constants when used as case labels, e.g:
> 
> > ../../../../src/winsup/cygwin/exceptions.cc: In static member function ‘static int exception::handle(EXCEPTION_RECORD*, void*, CONTEXT*, PDISPATCHER_CONTEXT)’:
> > ../../../../src/winsup/cygwin/exceptions.cc:670:10: error: narrowing conversion of ‘-1073741682’ from ‘NTSTATUS’ {aka ‘int’} to ‘unsigned int’ [-Wnarrowing]
> 
> See also: c5bdf60ac46401a51a7e974333d9622966e22d67
> ---
>  winsup/cygwin/exceptions.cc          | 2 +-
>  winsup/cygwin/local_includes/ntdll.h | 2 +-
>  winsup/cygwin/pinfo.cc               | 2 +-
>  winsup/cygwin/sigproc.cc             | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 28d0431d5..74e5905d5 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -665,7 +665,7 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
>    siginfo_t si = {};
>    si.si_code = SI_KERNEL;
>    /* Coerce win32 value to posix value.  */
> -  switch (e->ExceptionCode)
> +  switch ((NTSTATUS)e->ExceptionCode)

I'd prefer a space after the closing parenthesis of the cast, but
we didn't enforce this in the past, so, please push.

Thanks,
Corinna

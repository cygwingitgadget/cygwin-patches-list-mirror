Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 280773858C01; Mon, 13 Nov 2023 16:42:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 280773858C01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699893774;
	bh=0u2b8Jcf0MwmaHbnFJ/8Blx318BSafCyqPpYs6OLs/k=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cKP5zWniHazJAhGV1nhnjHp/puoYg+Sr4wXEmKWORb5CXXF7njRtclPFoarJhTm+P
	 0TzHWSnFPAZyFO4G9vRSUSU9asYCP1uDmRDMXfXGEOdFz1YlCgswtgBTy7NjJ4gZJv
	 ZTSjJxpsjPEDFVKuoI5DzfPIy25vyoG0DhO+2wHY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 33B8FA80A3D; Mon, 13 Nov 2023 17:42:52 +0100 (CET)
Date: Mon, 13 Nov 2023 17:42:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix(libc): Fix handle of %E & %O modifiers at end of
 format string
Message-ID: <ZVJSDAyKK/h8bZa/@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20231109190441.2826-1-pedroluis.castedo@upm.es>
 <4801ab90-2958-4fa2-87f2-21efdb41bbf4@Shaw.ca>
 <ZU4C+UIcYTtvWrrJ@calimero.vinschen.de>
 <27a7257d-1e06-40ff-89ec-f100b8734802@upm.es>
 <5cd4b96f-cad1-456c-b4d9-a6a649d36e3a@Shaw.ca>
 <ac7355c3-7b25-4410-94eb-9bd2f602f4ac@upm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac7355c3-7b25-4410-94eb-9bd2f602f4ac@upm.es>
List-Id: <cygwin-patches.cygwin.com>

Hi Pedro,

On Nov 11 18:29, Pedro Luis Castedo Cepeda wrote:
> OK. It's not a newlib problem but a GLib one as it is relaying on common but
> non-standard strftime implementation details.
> 
> I attach a short program more focused in g_date_strftime implementation so
> it can be evaluated if it worths addressing this corner case.

Tricky.  I wonder what the GLib test is actually trying to accomplish.

POSIX has this to say:

  RETURN VALUE
    If the total number of resulting bytes including the  terminating
    null byte  is not more than maxsize, these functions shall return
    the number of bytes placed into the array pointed to by s, not
    including the  terminating NUL character. Otherwise, 0 shall be
    returned and the contents of the array are unspecified.

  ERRORS
    No errors are defined.

But, and that's the big problem, POSIX does *not* provide for the
error case, because it doesn't allow an error like using an incorrect
format string to occur.  Using an incorrect or undefined format code
is just not part of the standard.

And the Linux man page has an interesting extension to the above
POSIX RETURN VALUE section:

    Note  that  the  return value 0 does not necessarily indicate an
    error.  For example, in many locales %p yields an empty string.  An
    empty  format string will likewise yield an empty string.

and additionally in the BUGS section:

    If the output string would exceed max bytes, errno is  not  set.
    This makes it impossible to distinguish this error case from cases
    where the format  string  legitimately  produces  a  zero-length
    output  string.  POSIX.1-2001 does not specify any errno settings
    for strftime().

So the below case tested by GLib is entirely out of scope of the
standard.


Corinna

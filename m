Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0F844385842C; Fri, 10 Nov 2023 10:16:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0F844385842C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699611387;
	bh=3vcIiWj1iy3hC6jM0KZh8Y+CxbJ7MooLnfS5xmS+UA8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=eMYvmwGrLFMwZHQMPBcv8eKCB4qOe8gWJmRRkipf1K6v413pxPeLnvRFhUU6Egcwq
	 oCXup1x2CsaqeEDgpXc8rdmEnNjy/CIlbehFWWHyRzYnmWtThAke3ydYMnVyIFKMb3
	 MlIZ1JmiX9ge/3QxP5tHnTBwpI/UUCG8EcLHGrDE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2053AA80BA6; Fri, 10 Nov 2023 11:16:25 +0100 (CET)
Date: Fri, 10 Nov 2023 11:16:25 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix(libc): Fix handle of %E & %O modifiers at end of
 format string
Message-ID: <ZU4C+UIcYTtvWrrJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20231109190441.2826-1-pedroluis.castedo@upm.es>
 <4801ab90-2958-4fa2-87f2-21efdb41bbf4@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4801ab90-2958-4fa2-87f2-21efdb41bbf4@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

On Nov  9 23:17, Brian Inglis wrote:
> On 2023-11-09 12:04, Pedro Luis Castedo Cepeda wrote:
> > - Prevent strftime to parsing format string beyond its end when
> >    it finish with "%E" or "%O".
> > ---
> >   newlib/libc/time/strftime.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/newlib/libc/time/strftime.c b/newlib/libc/time/strftime.c
> > index 56f227c5f..c4e9e45a9 100644
> > --- a/newlib/libc/time/strftime.c
> > +++ b/newlib/libc/time/strftime.c
> > @@ -754,6 +754,8 @@ __strftime (CHAR *s, size_t maxsize, const CHAR *format,
> >         switch (*format)
> >   	{
> > +	case CQ('\0'):
> > +	  break;
> >   	case CQ('a'):
> >   	  _ctloc (wday[tim_p->tm_wday]);
> >   	  for (i = 0; i < ctloclen; i++)
> 
> These cases appear to already be taken care of by setting and using
> (depending on the config parameters) the "alt" variable for those modifiers,
> and the default: return 0; for the format *character* (possibly wide) not
> matching following any modifiers.
> 
> Patches to newlib should go to the newlib mailing list at sourceware dot org.

Also, a simple reproducer would be nice.


Thanks,
Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 293FA3857820; Mon, 13 Jan 2025 13:26:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 293FA3857820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736774766;
	bh=B/GhlgJFr2ib2kPzz/98vnhHR1UeOm353SQyXPsC63w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=eiLfJGol6/ecg/G/b6d3kJENG2BRJXMYBmgBqtiBQIh6V1l4pzKitsaD1Hs2lvbPF
	 kafWQbJJoppzA4goozdUqOtveXWmAB2hV8xFWK8UXDjdyUrVxq97nhMWDyfHQ46fS5
	 e4A+zdRm94+QykX2KW/tJbaL8X/gQIPqF0qnPHeA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8865DA80A67; Mon, 13 Jan 2025 14:26:04 +0100 (CET)
Date: Mon, 13 Jan 2025 14:26:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 4/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
Message-ID: <Z4UUbF2tRqE5zAUL@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5888275d7f48a4418cded1b292b8951506240073.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <32ee8a55-416f-407f-8c33-655718b667bc@dronecode.org.uk>
 <f714ff40-1b35-42fa-bd26-7eb0c1ebc9fc@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f714ff40-1b35-42fa-bd26-7eb0c1ebc9fc@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 12 13:00, Brian Inglis wrote:
> On 2025-01-12 11:04, Jon Turney wrote:
> > On 11/01/2025 00:01, Brian Inglis wrote:
> > > Move entries no longer in POSIX from the SUS/POSIX section to
> > > Deprecated Interfaces section and mark with (SUSv4).
> > > Remove entries no longer in POSIX from the NOT Implemented section.
> > > 
> > [...]
> > > -<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in
> > > POSIX.1-2008 or deprecated:</title>
> > > +<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in
> > > POSIX.1-2024, or deprecated:</title>
> > 
> > Maybe we've reached the point where this could be split into "System
> > interfaces deprecated in POSIX.1-2024" and "Other UNIX system
> > interfaces, not in POSIX.1-2024"?
> 
> Or just drop "deprecated" as these interfaces have been dropped from POSIX
> 2024, which is why I moved getdomainname to Solaris/SunOS and added "(NIS)"!

You both have a point.  There are two or more problems with the section.
For instance, it contains entries like bcmp, bcopy, bzero, which, yes,
have been deprecated from POSIX, but are actually 4.3BSD functions.
So those would have to be moved to the std-bsd section.

Just as gethostbyaddr, gethostbyname, ftime, etc.

cuserid was System V.

ecvt/fcvt/gcvt are old as dirt, probably System 7.

on_exit is SunOS, so why the heck did I add it to the std-deprec
section 10 years ago?

ETC

So, is there really any of them, which have been first added as part of
the POSIX standard and then have been deprecated again, or were all of
them part of an older or different OS?  If so, the expression
"deprecated" wouldn't make much sense, and the section would only
contain a few SVID functions and the really exotic stuff like

  clock_setres                (QNX, VxWorks)
  pthread_getsequence_np      (Tru64)
  gethostbyname2              (first defined in BIND 4.9.4)


Corinna

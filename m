Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7DE8F384A46B; Fri, 17 Jan 2025 11:06:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7DE8F384A46B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737111999;
	bh=o2f7XfQ1yo1a+zFXxEoc7Bkpmkgk3D5leo8HCm0dRc0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fUGv7Icx76o8HzwDyfrGgG7iShvtfqjNnB02iAiKBBa7dk7JC5t9CWpODHozKKWno
	 j4fBuAXR2ZS6qztP6oL5h4fjcBF7dNzPI2LrlKxCIKcetdSqqOk3DsHz9Rh9ALa9kV
	 60l+Rb7i+5+cgbtApKhYc/H3tTcW7x11XaE/qLp0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E0604A80A5D; Fri, 17 Jan 2025 12:06:37 +0100 (CET)
Date: Fri, 17 Jan 2025 12:06:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Message-ID: <Z4o5vYIrzyZHchn0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <a216df577267a5e8b61b220969da57691f6a341f.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4lS5SKVFB4FdcLq@calimero.vinschen.de>
 <ffca5f19-325a-4c83-bd41-1deb313c279e@systematicsw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffca5f19-325a-4c83-bd41-1deb313c279e@systematicsw.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 16 15:54, brian.inglis@systematicsw.ab.ca wrote:
> On 2025-01-16 11:41, Corinna Vinschen wrote:
> > On Jan 15 12:39, Brian Inglis wrote:
> > > Add unavailable POSIX additions to Not Implemented section,
> > > with mentions of headers and packages where they are expected.
> > > 
> > > Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> > > ---
> > >   winsup/doc/posix.xml | 20 ++++++++++++++++++--
> > >   1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> > > index 0b23a2251028..89728e050bef 100644
> > > --- a/winsup/doc/posix.xml
> > > +++ b/winsup/doc/posix.xml
> > > @@ -1681,9 +1681,14 @@ ISO/IEC DIS 9945 Information technology
> > >   </sect1>
> > > -<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
> > > +<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
> > >   <screen>
> > > +    _Fork			(not available in "(sys/)unistd.h" header)
> > > +    dcgettext_l			(not available in external gettext "libintl" library)
> > > +    dcngettext_l		(not available in external gettext "libintl" library)
> > > +    dgettext_l			(not available in external gettext "libintl" library)
> > > +    dngettext_l			(not available in external gettext "libintl" library)
> > 
> > Sorry, but they are not available.  It doesn't matter *where* they are
> > not available.  Please drop the hints.
> 
> Intended as reminders of work needed for support:
> 
> _Fork needs to be async safe and does not call pthread_atfork fork handlers:
> could it not be specialized from _fork?
> 
> Ask if gettext project is working on adding those.

Yeah, but this info doesn't belong in the posix.xml file.  I have _Fork
on my private list of TODO and I'm sure the gettext project has the
foo_l functions on some TODO list as well.


Corinna

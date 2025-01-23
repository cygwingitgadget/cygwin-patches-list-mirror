Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BB71B3858C52; Thu, 23 Jan 2025 09:59:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BB71B3858C52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737626389;
	bh=JtcjmMKKh2iDjkIctRG4x9L5PgEGiCIYkAsth2RsB+U=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WvRIgno9XH17RztPiqkuWreLIqPd1jE5VYFuaVTMse6VaVJM4Z4KtjeSaEJdi143H
	 vk4anEwp8uQVYp201qUp2cGbDaBFOCkIAK0HVZKTCA3WJSXf6RyPK97xeCT/ink2oj
	 ROy0f3KKxxZ0sN4ZCTOdePJp/K1dl9WKPNYNETvU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 611E9A80B66; Thu, 23 Jan 2025 10:59:47 +0100 (CET)
Date: Thu, 23 Jan 2025 10:59:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 4/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
Message-ID: <Z5ITE54yxFUAJK9l@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <7c1df0773801655e35abbfb28c4428df9b4854ee.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z5DVKOrVtnXunSvK@calimero.vinschen.de>
 <d0d4373e-9564-40b9-96f2-1bb908ea8875@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0d4373e-9564-40b9-96f2-1bb908ea8875@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 22 17:37, Jon Turney wrote:
> On 22/01/2025 11:23, Corinna Vinschen wrote:
> > On Jan 17 10:01, Brian Inglis wrote:
> > > Move entries no longer in POSIX from the SUS/POSIX section to
> > > Deprecated Interfaces section and mark with (SUSv4).
> > > Remove entries no longer in POSIX from the NOT Implemented section.
> > 
> > This looks good, but I just realized that a bunch of functions are
> > missing.
> > 
> > > -<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
> > > +<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in POSIX.1-2024, or deprecated:</title>
> > 
> > When I introduced the ACL functions from the abandoned POSIX.1e draft,
> > I missed to add them to the docs.
> > 
> > Well, fortunately I'm now noticing this a mere 8 years later... *facepalm*
> > 
> > Sigh.  I'll create a patch to add them on top of your patches later on.
> > 
> I happen to notice the other day that we don't mention eaccess() (which the
> glibc extension euidaccess() is a synonym for) here, which I think belongs
> in this section.

Yay!  I'll add it later together with the POSIX.1e functions.

Thanks,
Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3F0C03858C50; Wed, 19 Feb 2025 20:39:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3F0C03858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739997569;
	bh=3SF2xC4QL7/Z36/vut/SDo+onCOD6rJB/xNHk2qbK1c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ivA2GVsdh2/kZgcjJUkJkE2BxaBhRHk390yHMRXfSGyzp6itQBgfGoCRT+xvxRFZh
	 sE6XXwiONZ5PGcNDPl0nlGyFtbQeZFtTRIb2It+PdKJiIC1weSCtN87RXo1SrJQn5Y
	 EKC8eKBWk2vk9qFyw0Jd+htw/KaxRX9xb5W9BVrw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D76B7A8093F; Wed, 19 Feb 2025 21:39:21 +0100 (CET)
Date: Wed, 19 Feb 2025 21:39:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: skip floppy drives in cygdrive_getmntent.
Message-ID: <Z7ZBeUs3wt-IJJiD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9b20134b-c892-edbd-eac3-d2781bcec039@jdrake.com>
 <Z7WtIsNZb7Fqnmxg@calimero.vinschen.de>
 <33a7b714-0f8e-d640-143b-2fd624372f51@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33a7b714-0f8e-d640-143b-2fd624372f51@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 19 10:14, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 19 Feb 2025, Corinna Vinschen wrote:
> 
> > Hi Jeremy,
> >
> > just a minor thingy:
> >
> > On Feb 18 17:51, Jeremy Drake via Cygwin-patches wrote:
> > > +  dos_drive_mappings (bool with_floppies = true);
> >
> > I would rather not make this a default parameter, but call it elsewhere
> > with an argument "true".  Or even better with an explicit value, like
> >
> > enum {
> >   NO_FLOPPIES = false,
> >   WITH_FLOPPIES = true
> > };
> >
> > I have a local tweak along these lines.  Would you mind if I
> > amend your patch with this tiny change?
> 
> OK.

Thank you!  Both patches pushed.


Corinna

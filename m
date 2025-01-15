Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D0A0B3853545; Wed, 15 Jan 2025 12:25:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D0A0B3853545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736943912;
	bh=391IPIfzScSIGkwGLti3y/7eisdQ5oEZu82HeJqtosk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=E1/vjxZ903DtzfBpbRpkB83lr2izyfWC9urEActnkcfXcK6yj2/aOWaOUX0Uvj9yo
	 AZT3QR5+KTKzB8jYX6XbAPAqq8NCz10mdqYaP9MJ3iXx466n+d9JlENpgtjNx87qGb
	 B0ruv5/cS8fZxi4JF2F8gpEj6Uw0NMNEEanoV52c=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1A80DA80D2F; Wed, 15 Jan 2025 13:25:11 +0100 (CET)
Date: Wed, 15 Jan 2025 13:25:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Message-ID: <Z4epJ_p-b5jMxRG6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <b02f73ea85c1a9e6cd1a7ebc116fde12f5f6ccc4.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UN78IouepuUwme@calimero.vinschen.de>
 <ba870968-a3ce-4732-8276-7dabd7a167b2@SystematicSW.ab.ca>
 <6e984ebd-7f38-4a44-bf2f-0986d5a49ef7@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e984ebd-7f38-4a44-bf2f-0986d5a49ef7@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 14 16:44, Brian Inglis wrote:
> Looking at the end/get/set...ent groups, endhostent and sethostent are
> implemented and gethostent is not implemented - should we keep them separate
> or combine in one section?

Separate, given their state as implemented/not implemented.


Corinna

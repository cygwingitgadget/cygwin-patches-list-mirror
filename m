Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9ED054BA2E05; Mon, 22 Dec 2025 10:24:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9ED054BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766399079;
	bh=7lZ0/yF4XVDcyGIIACsM09tuKfhM8aMv4on8/ce6RYE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=PKwZcIyQWjIeS7Yjo3Y97Zz8SksdKDmxaLQuswkrxm35SGtaMCpj0XINrY6X/GM/b
	 lz3EBE8P0yv6E94aZE5rhHQaxPyi9/0ndIIWRjSM80eBZOKtzCXwF26wNMqlDBJkau
	 Gffh8QALYf6yKx8bsVt0CVOKG27bQ0SlofU3tANg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BDC5BA80D4B; Mon, 22 Dec 2025 11:24:37 +0100 (CET)
Date: Mon, 22 Dec 2025 11:24:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/4] Cygwin: uinfo: correctly check and override
 primary group
Message-ID: <aUkcZYbpqlAb5S2B@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
 <20251218112308.1004395-2-corinna-cygwin@cygwin.com>
 <20251221192038.25aa53bf2575e30a79a8a505@nifty.ne.jp>
 <a8f84af2-409a-4afa-a78a-94727071f672@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8f84af2-409a-4afa-a78a-94727071f672@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Dec 21 17:32, Mark Geisert wrote:
> Hi folks,
> A small spelling correction is needed; shown below...
> 
> On 12/21/2025 2:20 AM, Takashi Yano wrote:
> > On Thu, 18 Dec 2025 12:23:05 +0100
> > Corinna Vinschen wrote:
> > > From: Corinna Vinschen <corinna@vinschen.de>
> > > 
> > > Commit dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
> > > broke the code overriding the primary group in two different ways:
> > > 
> > > - It changed the way myself->gid was set before checking its value.
> > > 
> > >    Prior to dc7b67316d01, myself->gid was always set to the primary group
> > >    from the passwd entry (pw_gid).  With the patch, it was set to the
> > >    primary group from the Windows user token (token_gid) in the first
> > >    place.
> > > 
> > >    The following condition checking if pw_gid is different
> > >    from token_gid did so, by checking token_gid against myself->gid,
> > >    rather than against pw_gid.  After dc7b67316d01 this was always
> > >    false and the code block overriding the primary group in Cygwin and
> > >    the Windows user token with pw_gid was never called anymore.
> > > 
> > >    The solution is obvious: Do not check token_gid against myself->gid,
> > >    but against the desires primary GID value in pw_gid instead.
> > > 
> > > - The code block overriding the primary group simply assumed that
> > >    myself->gid was already set to pw_gid, but, as outlined above,
> > >    this was not true anymore after dc7b67316d01.
> > > 
> > >    This is a subtil error, because it leads to having the wrong primary
>                 ^^^^^^
>                 subtle

Thanks!  Fixed and following Takashi's suggestion, I'll add an
Addreses: tag.


Corinna

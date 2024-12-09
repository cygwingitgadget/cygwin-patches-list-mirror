Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 629B43858432; Mon,  9 Dec 2024 15:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 629B43858432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733758015;
	bh=wqU9PcEQZc1yrJMsYBK7AQjvdqJWgCHF+DVgINpXwrI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ThVbVjsN7xV84uNzcUR0ZzD8UGjbH5IBFZw8aDCRDGeBJGtmaBzFSQavR3Y5VhPgb
	 pQ2D7n+0K0NNsb8KDEEJuAbAciUylMrxV/mUTOh4Svz9u7Pm41C/YZ7e1px4c3cTQ9
	 uX8/VSqQKyP0xpOrb7yrPdhGqO1lt8yomGCyqdbQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4BA2AA8093F; Mon,  9 Dec 2024 16:26:53 +0100 (CET)
Date: Mon, 9 Dec 2024 16:26:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-ID: <Z1cMPRDvfIqZAsL3@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CANV9t=TLh8xD7KBsF-MucZWNjP-L0KE04xUv2-2e=Z5fXTjk=w@mail.gmail.com>
 <20241114010807.99f46760b2240d472440c329@nifty.ne.jp>
 <20241116002122.3f4fd325a497eb4261ad80f4@nifty.ne.jp>
 <ZztqpBESgcTXcd3d@calimero.vinschen.de>
 <20241119175806.321cdb7e65a727a2eb58c8a6@nifty.ne.jp>
 <Zzz7FJim9kIiqjyy@calimero.vinschen.de>
 <20241208081338.e097563889a03619fc467930@nifty.ne.jp>
 <Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
 <20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
 <20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  9 22:57, Takashi Yano wrote:
> On Mon, 9 Dec 2024 22:44:00 +0900
> Takashi Yano wrote:
> > On Mon, 9 Dec 2024 12:11:56 +0100
> > Corinna Vinschen wrote:
> > > init_reopen_attr() uses the "open by handle" functionality as in the
> > > Win32 API ReOpenFile().  It only does so if the filesystem supports it.
> > > Samba usually does, so it's not clear to me why pc.init_reopen_attr()
> > > fails for you.
> > 
> > I didn't mean pc.init_reopen_attr() failed. Just I was no idea
> > for what handle to be passed.
> > 
> > > > What handle should I pass to pc.init_reopen_attr()?
> > > 
> > > You could pass pc.handle().  Is pc.handle() in this scenario NULL,
> > > perhaps?
> > 
> > I have tried pc.handle() and suceeded. Thanks for advice!
> 
> No! pc.handle() sometimes seems to be NULL....

Can you please figure out in which scenario it's NULL?  Theoretically
the function shouldn't even be called in this case.


Corinna

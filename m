Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D701A4BA2E20; Thu, 18 Dec 2025 10:33:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D701A4BA2E20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766053988;
	bh=hn7Hm3uAQOha7+uTgY71ZBWQozm85wjOklHeBpf8uGw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VHe7x19zhsbRC55DDXx/o4AcuH1fGmhgwoh3pyhtQ+AGiCJFtofHUx2+BVAY1TJmB
	 4iJtmbPPbo3FttBzt12X+ifWGBHwK1l0JFFDEo2ctW6aCIHUG3jsXQhQ3OIDwkAls3
	 PC/DumJ/7fHXLPwfyE/At3YQALW9pgeJ+HoVbUZQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CFC87A80797; Thu, 18 Dec 2025 11:33:06 +0100 (CET)
Date: Thu, 18 Dec 2025 11:33:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix overriding primary group
Message-ID: <aUPYYuQRj2BanVO0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
 <aUAn8aPCHHOWpEoO@calimero.vinschen.de>
 <20251218163835.5d4025edb00001e28677398d@nifty.ne.jp>
 <aUPXYyOzZdGcTwtJ@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUPXYyOzZdGcTwtJ@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec 18 11:28, Corinna Vinschen wrote:
> On Dec 18 16:38, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Mon, 15 Dec 2025 16:23:29 +0100
> > Corinna Vinschen wrote:
> > > On Dec  5 17:38, Corinna Vinschen wrote:
> > > > From: Corinna Vinschen <corinna@vinschen.de>
> > > > 
> > > > Fix broken code overriding primary group at process tree startup.  THis
> > > > is fallout frokm the newgrp(1) introduction which showed a problem with
> > > > this code.  The fix from commit dc7b67316d01 ("Cygwin: uinfo: prefer
> > > > token primary group") broke this differently, so here we go, trying to
> > > > fix the second problem without breaking the first again.
> > > > 
> > > > Corinna Vinschen (3):
> > > >   Cygwin: uinfo: correctly check and override primary group
> > > >   Cygwin: uinfo: allow to override user account as primary group
> > > >   Cygwin: add release note for primary group override fix
> > > 
> > > Ping?  Anybody willing to review?
> > 
> > I would like to review them for you, but I don’t understand what
> > the problem is or how these patches are supposed to solve it...
> 
> I actually hoped my commit messages would explain that.  Is it
> not adequate?

Yes, I think I see where the problem is.  I'll send a v2 with improved
commit message.


Thanks,
Corinna

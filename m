Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BD9793858D28; Wed,  8 Jan 2025 15:17:33 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C653FA805BC; Wed,  8 Jan 2025 16:17:31 +0100 (CET)
Date: Wed, 8 Jan 2025 16:17:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: access: Fix X_OK behaviour for administrator
Message-ID: <Z36XCyZb8frtKXxl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241226123410.126087-1-takashi.yano@nifty.ne.jp>
 <Z31a-_lO1hs4yc5I@calimero.vinschen.de>
 <20250108061424.066e0e3bc0c911b3b4c3bc97@nifty.ne.jp>
 <20250108193925.b484833e85c61435b67333d5@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108193925.b484833e85c61435b67333d5@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jan  8 19:39, Takashi Yano wrote:
> On Wed, 8 Jan 2025 06:14:24 +0900
> Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Tue, 7 Jan 2025 17:48:59 +0100
> > Corinna Vinschen wrote:
> > > So... given how this is supposed to work, we must not use the
> > > FILE_OPEN_FOR_BACKUP_INTENT flag when checking for execute permissions
> > > and the result should be the desired one.  I tested this locally, and I
> > > don't see a regression compared to 3.5.4.
> > > 
> > > Patch attached.  Please review.
> > 
> > Thanks for reviewing and the counter patch.
> > 
> > With your patch, access(_, X_OK) returns -1 for a directory without 'x'
> > permission even with Administrator.
> > This seems due to lack of FILE_OPEN_FOR_BACKUP_INTENT.
> > 
> > How about simpler patch attached?
> 
> Revised a bit.

Nice change.  At first I thought the addition of FILE_READ_DATA for
files is over the top, but yeah, it seems we really have to do it to get
reliable results.

I pushed a variation of this to both branches.


Thanks,
Corinna

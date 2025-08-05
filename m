Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AF8B93858436; Tue,  5 Aug 2025 15:12:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AF8B93858436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1754406759;
	bh=sM4xBQ9MuixUMBwiYhZvIQ07FLxv0A/PP4iY7FqORxY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=G3PK/TCU0dQAXEG56JKDS/C0UoW1vQ7SkBBUWpjAV4gcoqEsRJB5aJLaU2EaJ1RaQ
	 qc88+xn/JWikrtiL5aA+xEpnoQg0I7IgFNNiszRZ9VAryRxhnU/TSY5928kkhDtkAO
	 va2jR4NC9eirM2j/gkXC9fDGf8nZL965Lx9w1zXA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E75D3A80CB7; Tue, 05 Aug 2025 17:12:37 +0200 (CEST)
Date: Tue, 5 Aug 2025 17:12:37 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: add api version check to c++ malloc struct
 override.
Message-ID: <aJIfZbdwYbMAxy4c@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>,
	cygwin-patches@cygwin.com
References: <ff5e8cb0-205b-4d08-7eba-51f112e9619c@jdrake.com>
 <aI42aRxXOsYFOzpq@calimero.vinschen.de>
 <4f3bd8e1-b32c-9e9e-bc94-5dc0d0bd52a9@jdrake.com>
 <aI5Va0_O8rg0VCbh@calimero.vinschen.de>
 <72ca7654-451c-b8a0-dfd9-f2f82a63fc6c@jdrake.com>
 <aJBwy4ScyIQPS5kY@calimero.vinschen.de>
 <e2c92437-eec7-c7f7-5eae-3500e574bd78@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2c92437-eec7-c7f7-5eae-3500e574bd78@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Aug  4 11:07, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 4 Aug 2025, Corinna Vinschen wrote:
> 
> > On Aug  2 11:18, Jeremy Drake via Cygwin-patches wrote:
> > > This prevents memory corruption if a newer app or dll is used with an
> > > older cygwin dll.  This is an unsupported scenario, but it's still a
> > > good idea to avoid corrupting memory if possible.
> > >
> > > Fixes: 7d5c55faa1 ("Cygwin: add wrappers for newer new/delete overloads")
> > > Co-authored-by: Corinna Vinschen <corinna@vinschen.de>
> > > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > > ---
> > >  winsup/cygwin/globals.cc                 |  4 +--
> > >  winsup/cygwin/include/cygwin/version.h   |  3 ++
> > >  winsup/cygwin/lib/_cygwin_crt0_common.cc | 38 +++++++++++++-----------
> > >  3 files changed, 26 insertions(+), 19 deletions(-)
> >
> > LGTM, please push.
> 
> Pushed.

Can you add a oneliner to release/3.7.0, please?


Thanks,
Corinna

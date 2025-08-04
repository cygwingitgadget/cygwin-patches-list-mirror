Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 879EA385780C; Mon,  4 Aug 2025 18:49:35 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 06BACA809F3; Mon, 04 Aug 2025 20:49:33 +0200 (CEST)
Date: Mon, 4 Aug 2025 20:49:32 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: add api version check to c++ malloc struct
 override.
Message-ID: <aJEAvIpViSmK0-65@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
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
> 
> > Now for the question if we should keep this with 3.7, or if it makes
> > sense to backport to the 3.6 branch.
> >
> > I'm not sure.
> >
> > Theoretically this change doesn't change anything as long as libstdc++
> > and gcc didn't catch up.  So it's no functional change for existing
> > apps, but it would prepare newly build apps to the new compiler and
> > libstdc++ lib builds.
> >
> > OTOH, as long as it's only in the non-released build, we have still time
> > to fix things.  The fixes necessary due to introducing this right with a
> > bug in 1.7.0-49 were not much fun.  It would be great if we already had
> > a gcc/libstdc++ build to test against before a release...
> >
> > What do you think?
> 
> My gut feeling is that this is a "major version"-type change.  The missing
> export failures on downgrade and the api version bump (which iirc would
> conflict if backported to 3.6, I think there was another api version
> before this on 3.7 that is not in 3.6).

Good point.


Thanks,
Corinna

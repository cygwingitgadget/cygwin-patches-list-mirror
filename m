From: Matt <matt@use.net>
To: DJ Delorie <dj@delorie.com>
Cc: cygwin-patches@sources.redhat.com
Subject: Re: cinstall patches
Date: Tue, 26 Dec 2000 17:01:00 -0000
Message-id: <Pine.NEB.4.10.10012261651060.16114-100000@cesium.clock.org>
References: <200012262309.SAA24871@envy.delorie.com>
X-SW-Source: 2000-q4/msg00066.html

On Tue, 26 Dec 2000, DJ Delorie wrote:

> > In order for focus to be able to reach the group of radio buttons,
> > one must be selected.
> 
> Is there any way around this?  It sounds like a bug.

You got me, this is the first time I've coded anything like this.


> > The worst case scenario is that now the user will change from the
> > default selection,
> 
> Unfortunately, the worst case scenario is that clueless newbies flood
> the cygwin list with complaints that the setup program didn't work,
> when the real problem is that they didn't think about those
> selections.  I'm much more concerned with people getting it right the
> first time, than with convenience.  Making them stop and think at
> those spots makes sense in that case.

The default selection (Install from Internet) is ideal for this, since it
requires the least amount of thought/interaction. This is what I had in
mind when I made that decision.

Direct Connection was chosen as a default for maximum compatibility across
systems (users mat not have IE5 installed). If someone has a proxy, and
even knows the information necessary, I don't think we'd have to worry
about them as a "newbie". It might make more sense to use the IE5 Settings
since that would include proxy configuration as well -- that is something
I could agree with.

My purpose here was that most users can click Next (or hit enter)
throughout the install and get a new/updated cygwin installation. If
people are confused, perhaps we need more descriptive text in the dialogs.
I know that package selection screen still confuses the hell out of me :)

In any event, I don't see how these changes decrease usability. Perhaps
this is my limitation, but this isn't worth much more back and forth.
Perhaps we should put it up for vote on cygwin-developers?

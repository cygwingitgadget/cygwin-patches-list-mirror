From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]choose.cc: Simplify set_action(), wrap long lines, and correct problems in setup.log.full
Date: Sun, 24 Jun 2001 22:55:00 -0000
Message-id: <20010625015559.A9754@redhat.com>
References: <001501c0fc2b$fd137d00$6464648a@ca.boeing.com>
X-SW-Source: 2001-q2/msg00330.html

On Sat, Jun 23, 2001 at 02:31:10PM -0700, Michael A. Chase wrote:
>Some time between setup.exe 2.57 and 2.75, the ability to set the checkbox
>for downloading or installing source was lost.  It was caused by clearing
>pkg->srcpicked in set_action().  Set_action() was apparently intended to
>manage setting pkg->action when the action column was clicked, but it is now
>also used to make sure pkg->action is valid in other places.  I removed
>"pkg->srcpicked = 0;" from set_action() and added it to default_trust() so
>it would only be cleared when setting the default trust level.

I checked in the cleanup half of your changes but, as promised, I was already
working on setup.cc last week on the plane and at random times during the
week.  I'd already fixed the "Skipped" problem, among other things, and just
accomodated the existing code to (hopefully) fix the source problem.

Thanks,
cgf

From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cinstall patches
Date: Mon, 07 May 2001 21:32:00 -0000
Message-id: <20010507234505.A3313@redhat.com>
References: <200012262309.SAA24871@envy.delorie.com> <Pine.NEB.4.10.10012261651060.16114-100000@cesium.clock.org>
X-SW-Source: 2001-q2/msg00198.html

FWIW, I've added these changes to cinstall.  I'd already taken the step
of defaulting some of the "standard" options so Matt's other changes
make sense in this light.

When this discussion first came up last December, I agreed with DJ's
thinking on the issue.  I've since heard too many complaints from
people who think that setup.exe is "hard to figure out".  I'm hoping
that by providing some defaults we'll be able to satisfy most of
the user community.

It will be interesting to see if these changes cause more complaints
when a new version of setup is released or less.  If they do, there
is no problem reverting them and reissuing a new version of setup.exe.

cgf

On Tue, Dec 26, 2000 at 05:01:32PM -0800, Matt wrote:
>On Tue, 26 Dec 2000, DJ Delorie wrote:
>
>> > In order for focus to be able to reach the group of radio buttons,
>> > one must be selected.
>> 
>> Is there any way around this?  It sounds like a bug.
>
>You got me, this is the first time I've coded anything like this.
>
>
>> > The worst case scenario is that now the user will change from the
>> > default selection,
>> 
>> Unfortunately, the worst case scenario is that clueless newbies flood
>> the cygwin list with complaints that the setup program didn't work,
>> when the real problem is that they didn't think about those
>> selections.  I'm much more concerned with people getting it right the
>> first time, than with convenience.  Making them stop and think at
>> those spots makes sense in that case.
>
>The default selection (Install from Internet) is ideal for this, since it
>requires the least amount of thought/interaction. This is what I had in
>mind when I made that decision.
>
>Direct Connection was chosen as a default for maximum compatibility across
>systems (users mat not have IE5 installed). If someone has a proxy, and
>even knows the information necessary, I don't think we'd have to worry
>about them as a "newbie". It might make more sense to use the IE5 Settings
>since that would include proxy configuration as well -- that is something
>I could agree with.
>
>My purpose here was that most users can click Next (or hit enter)
>throughout the install and get a new/updated cygwin installation. If
>people are confused, perhaps we need more descriptive text in the dialogs.
>I know that package selection screen still confuses the hell out of me :)
>
>In any event, I don't see how these changes decrease usability. Perhaps
>this is my limitation, but this isn't worth much more back and forth.
>Perhaps we should put it up for vote on cygwin-developers?

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/

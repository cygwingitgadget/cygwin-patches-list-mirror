From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>, <cygwin-patches@cygwin.Com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Mon, 12 Nov 2001 18:20:00 -0000
Message-ID: <001401c16bea$107a89f0$0200a8c0@lifelesswks>
References: <OE65oDk9X2VFyBUMeEk0000ecac@hotmail.com> <01fe01c16916$a920a350$0200a8c0@lifelesswks> <3BEBC8F6.3B150BA3@yahoo.com> <021401c16976$7a591380$0200a8c0@lifelesswks> <3BEFCB8E.C0507FBD@yahoo.com> <02c901c16bca$1a7e5fa0$0200a8c0@lifelesswks> <20011112224913.GA25415@redhat.com> <VA.000009d3.0210da6e@thesoftwaresource.com>
X-SW-Source: 2001-q4/msg00209.html
Message-ID: <20011112182000.T-tGH3rIhC8ICv5d_ooHQm3IzdIEfMTkDP-LEbruoCg@z>

----- Original Message -----
From: "Brian Keener" <bkeener@thesoftwaresource.com>


>
> Just to throw my two cents worth in - I kind of like the keep/skip and
the spin
> control.  The keep/skip makes perfect sense to me - I have a package
listed in
> the installed column of choose and I select keep - I want to keep that
version
> installed.  I have nothing displayed in the installed column - I
select skip -
> I still want nothing installed, in my way of thinking.  I would not
select
> "keep" if I had nothing of that package installed anyways.  I am not
saying you
> should ever have both options, that is a definite no-no but one or the
other in
> the right cases makes seems right to me.  I would/could select "skip"
if I did
> have the package installed and it would make sense but I think if
something is
> installed then "keep" really makes better sense.  It is still all
semantics -
> ultimately behind the scenes they accomplish the same thing, but we do
need to
> think of the clarity for the novice.

Well, behind the scenes they are treated differently right now - one is
ACTION_foo, one is ACTION_SAME_foo.

As for labels, skip in both cases makes intuitive sense to me.
nothing installed - skip this package.
something installed - skip changing this package.

> As to the spin control, I like it - but everyone elses discontent with
it makes
> me ask - what do you envision in its place - I might like that better.

A drop-down box. Why?
two reasons.
1) spin controls are hard for non-mouse users to control. And there's
nothing for a screen reader to read out in terms of options, other than
spinning around.
2) I would love to be able to go straight to the version I want, and to
use keyboard controls completely within choose.cc...

Rob

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-developers@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: hierarchy in setup (category stuff)
Date: Fri, 29 Jun 2001 18:42:00 -0000
Message-id: <034701c10106$34f6b6e0$806410ac@local>
References: <04e801c0faa2$f9008260$0200a8c0@lifelesswks> <20010621222615.C13746@redhat.com> <3B3324A7.49FFC98A@yahoo.com> <054c01c0fbef$5f600e20$0200a8c0@lifelesswks> <06a001c0fc51$7a87e210$0200a8c0@lifelesswks> <20010629114004.A6990@redhat.com> <VA.00000842.01fd0b44@thesoftwaresource.com> <20010629172912.A8991@redhat.com> <032001c100fe$d62310c0$806410ac@local> <20010629205735.K9607@redhat.com>
X-SW-Source: 2001-q2/msg00371.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>


> >> >> Robert, if you are still interested, then I think that this is
> >definitely the
> >> >> way to go.  If you have something worth checking in, then please do
so.
> >
> >I'll draw up change log stuff and send something to cygwin-patches... or
did
> >you want me to hit CVS directly?
>
> Go ahead and check it in.  We can tweak it later.

Committed.

> I was just thinking of using the directories as an organizational method
> for the packages on sourceware.  The alternative is to somehow get the
> information into the setup.hint file there or to add some other file to
> the directory.  That's a lot of work and it's error-prone.  I can easily
> foresee erroneously having a Development and a Devlopment (misspelled)
> category if we do this on a per-package basis.

I'm in favour of having that data in the package file itself, and a scanning
tool that buils setup.ini. This is useful for home users as well, and allows
a semi-automated "package verification" so that you don't have to check for
Devlopment. I don't think I'll have time to address that just yet :], but it
is a standard mechanism for .deb, .rpm, and .pkg files..

> As far as the layout on the user's side, I don't really care, except
> that we could almost forgo setup.ini completely and just rely on the
> directory layout for "Install From Current Directory".
>
> The next thing we have to do is add descriptions.  That will involve
> another chooser change.

pick_line:: paint and the package_headers global are all that needs
modification for a bare bones "add description column after the package name
column".

Rob

>
> cgf
>

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-developers@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: hierarchy in setup (category stuff)
Date: Fri, 29 Jun 2001 18:59:00 -0000
Message-id: <035d01c10108$902207c0$806410ac@local>
References: <20010621222615.C13746@redhat.com> <3B3324A7.49FFC98A@yahoo.com> <054c01c0fbef$5f600e20$0200a8c0@lifelesswks> <06a001c0fc51$7a87e210$0200a8c0@lifelesswks> <20010629114004.A6990@redhat.com> <VA.00000842.01fd0b44@thesoftwaresource.com> <20010629172912.A8991@redhat.com> <032001c100fe$d62310c0$806410ac@local> <20010629205735.K9607@redhat.com> <034701c10106$34f6b6e0$806410ac@local> <20010629214637.A10975@redhat.com>
X-SW-Source: 2001-q2/msg00373.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>

> We already have a scanning tool for this.  It builds setup.ini by scanning
> the directories.
>
> I guess it could open each tar file and look there, too, but that seems
like
> overkill for now.

the advantage of tying the meta data to the files is that local copies of
setup.exe & .ini & packages retain the metadata for new files even if
setup.ini isn't updated. I.e. locally scanned files.

> >This is useful for home users as well, and allows a semi-automated
> >"package verification" so that you don't have to check for Devlopment.
>
> How would this allow for verification?  Would there be a global list
> of accepted categories somewhere?

For ones going onto cygwin.com I think that is absolutely appropriate.
Likewise for dependencies - spelling errors could be fatal(), so the
verifier needs to catalog all the files dependencies in whatever fashion,
and check there are no unsatisfied dependencies.

Rob

> cgf
>

From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup Makefile.common ChangeLog
Date: Thu, 22 Feb 2001 05:02:00 -0000
Message-id: <20010222140020.J908@cygbert.vinschen.de>
References: <20010221200320.B7330@redhat.com> <Pine.HPP.3.96.1010221210751.20219D-100000@hp2.xraylith.wisc.edu>
X-SW-Source: 2001-q1/msg00107.html

On Wed, Feb 21, 2001 at 09:14:51PM -0600, Mumit Khan wrote:
> On Wed, 21 Feb 2001, Christopher Faylor wrote:
> 
> > On Wed, Feb 21, 2001 at 07:01:11PM -0500, Earnie Boyd wrote:
> > >
> > >Are you positive about this patch?  I thought that problems existed
> > >unless all libraries were compiled -fvtable-thunks.
> > 
> > Huh.  I just asked Corinna to discuss this here to see if anyone had
> > any idea if this would cause problems.  It sounds like it might be
> > a potential speedup for cygwin, though?
> 
> Thunks allow *some* optimization, and makes the vtable layout compatible
> with MS COM objects, so it's a big plus. It's the default for Linux.
> However, there are a two primary considerations, and these are primarily
> why I resisted making it the default when it was discussed the last time
> (I believe just before gcc-2.95 was first released for Cygwin/Mingw):
> 
> 1 Binary incompatibility: *everything* must be build accordingly. 
> 2 There are bugs in vtable thunks implementation that causes trouble with
>   certain types of multiple inheritance. I had to redesign some of our 
>   code so that it would work under Linux. It's supposedly fixed for 
>   gcc-2.95.3 (backported from the mainline). Fortunately, most user 
>   codes don't make extensive use of multiple inheritance, and it hasn't 
>   been that big of an issue.
> 
> If you mix and match code compiled with -fvtable-thunks, it'll fail
> mysteriously, and a debugger won't help you there either. However, I
> don't know if building Cygwin with it will impact user code (it really
> shouldn't, but that's not based on hard evidence).
> 
> I have not observed appreciable speedup with -fvtable-thunks except for
> some specific cases.

To short-circute any problems which could be related to using
`-fvtable-thunks' I have changed the new symlink code to use
the C interface to COM instead of the C++ interface.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

From: Corinna Vinschen <corinna@vinschen.de>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cinstall ChangeLog download.cc
Date: Mon, 19 Feb 2001 10:56:00 -0000
Message-id: <20010219195553.G908@cygbert.vinschen.de>
References: <20010219180219.3323.qmail@sourceware.cygnus.com> <3A916118.A043FFBD@yahoo.com>
X-SW-Source: 2001-q1/msg00086.html

On Mon, Feb 19, 2001 at 01:08:24PM -0500, Earnie Boyd wrote:
> corinna@sourceware.cygnus.com wrote:
> > 
> > CVSROOT:        /cvs/src
> > Module name:    src
> > Changes by:     corinna@sources.redhat.com      2001-02-19 10:02:19
> > 
> > Modified files:
> >         winsup/cinstall: ChangeLog download.cc
> > 
> > Log message:
> >         * download.cc (get_file_size): New function. Eliminates the need
> >         to call `stat'.
> >         (download_one): Call `get_file_size' instead of `stat'. This
> >         workarounds a problem with mingw's `stat' call.
> > 
> 
> Corinna,
> 
> Can you please elaborate on the problem with MinGW's `stat' call?

I haven't investigated the problem in mingw. I only saw that
mingw's stat returns the wrong size in st_size. I needed a quick
solution so I decided to create a solution without using stat
instead of debugging.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
mailto:vinschen@redhat.com

From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: unlink() patch (was Cygwin CVS breaks PostgreSQL drop table)
Date: Wed, 18 Jul 2001 05:44:00 -0000
Message-id: <20010718144433.I730@cygbert.vinschen.de>
References: <20010717221042.A426@dothill.com> <20010718130154.E730@cygbert.vinschen.de> <3B559AB3.B93C5DA5@yahoo.com>
X-SW-Source: 2001-q3/msg00018.html

On Wed, Jul 18, 2001 at 08:18:27AM -0600, Earnie Boyd wrote:
> Corinna Vinschen wrote:
> > 
> > BTW, I have a naive question related to unlink. I had just another
> > look into SUSv2 and to my surprise it defines the following error
> > code:
> > 
> > [EBUSY]    The file named by the path argument cannot be unlinked
> >            because it is being used by the system or another process
> >            and the implementation considers this an error.
> > 
> > which basically means, if we try to unlink a file and that fails,
> > we wouldn't have to force it by ugly tricks (delqueue) but just
> > return EBUSY and Cygwin would still be SUSv2 compliant.
> > 
> > All: Would that be ok to change or would you like to keep the current
> >      behaviour?
> > 
> 
> I vote for EBUSY.  The delqueue has the potential to be more harmful
> than good.

I just realized that this question has to be combined with another
question:

Is anybody aware of an application which would really miserably
fail if unlink() returns EBUSY? Besides `rm' of course ;-)

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, <cygwin@cygwin.com>
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Wed, 27 Jun 2001 16:00:00 -0000
Message-id: <037401c0ff5c$ed60ebc0$806410ac@local>
References: <20010627023524.S19058@redhat.com> <00aa01c0ff1b$44106960$a300a8c0@nhv> <20010627112321.A21615@redhat.com>
X-SW-Source: 2001-q2/msg00360.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
> >>I bet it would improve even more if we replaced the VirtualQuery
> >>in path.cc, too.
> >
> >With Rob's new patch that does this,
> >there actually isn't very much difference
> >
> >real    7m10.729s
> >user    2m50.963s
> >sys     1m11.721s
> >
> >Thanks !
>
> Huh.  I wonder why it makes such a big difference for pthreads.
>

Volume of calls :}. openening files doesn't occur quite as often as (say)
locking a mutex.

I'd like to publicly thank Greg Smith for his excellent profiling work in
identifying the bottleneck here. I know how time consuming that can be :}.

Thanks Greg!

Rob

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, <newlib@sources.redhat.com>
Subject: Re: pthread_atfork
Date: Fri, 13 Apr 2001 14:59:00 -0000
Message-id: <049001c0c465$07589240$0200a8c0@lifelesswks>
References: <025f01c0c418$0994a690$0200a8c0@lifelesswks> <20010413111257.A3103@redhat.com> <20010413111902.A3242@redhat.com>
X-SW-Source: 2001-q2/msg00057.html

Thanks Chris.
    It's my fond hope that sometime soon I'lll submit a cygwin directory
patch that you can just apply :]

Mind coding was never so easy !

Rob

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>; <newlib@sources.redhat.com>
Sent: Saturday, April 14, 2001 1:19 AM
Subject: Re: pthread_atfork


> On Fri, Apr 13, 2001 at 11:12:57AM -0400, Christopher Faylor wrote:
> >On Fri, Apr 13, 2001 at 10:48:26PM +1000, Robert Collins wrote:
> >>Here's pthread_atfork.
> >>
> >>Friday Apr 13 2001  Robert Collins <rbtcollins@hotmail.com>
> >>        * fork.cc (fork): Call the pthread_atfork* functions.
> >
> >Please don't modify the fork() call.  Make your modifications to
> >the appropriate fork_parent and fork_child calls.  That's what
> >they're there for.
>
> Hmm.  I once again forgot that you probably won't see this for
> some time.
>
> In the interests of getting this into the source, I'll make the
> change right now and check it in.
>
> cgf
>

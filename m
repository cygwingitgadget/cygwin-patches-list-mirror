From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Thu, 21 Jun 2001 15:27:00 -0000
Message-id: <047001c0faa1$a8315d60$0200a8c0@lifelesswks>
References: <3B3181E5.E6F0D06A@nc.rr.com> <01da01c0fa5f$1bfe6d70$0200a8c0@lifelesswks> <20010621142602.A9643@redhat.com>
X-SW-Source: 2001-q2/msg00326.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, June 22, 2001 4:26 AM
Subject: Re: Deadly embrace between pthread_cond_wait and
pthread_cond_signal


> On Fri, Jun 22, 2001 at 12:33:15AM +1000, Robert Collins wrote:
> >Correct a deadlock situation...
> >Changelog:
> >2001-06-22  Robert Collins  rbtcollins@hotmail.com
> >
> >    * thread.cc (__pthread_cond_timedwait): Lock the waiting mutex
> >before the condition protect mutex to avoid deadlocking.
> >    (__pthread_cond_wait): Ditto.
> >
> >
> >Greg, as far as speed goes, there is a major optimisation I want to
> >make, which is to make all process private mutex's critical sections,
> >instead of system wide mutex's. This should be a lot faster... when I
> >get that done :].
>
> Looks good.
> I'm somewhat computer handicapped this week.  Can you check this in
yourself,
> Robert?

No problem. Done.

Rob

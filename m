From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: hang in pthread_cond_signal
Date: Thu, 14 Jun 2001 17:07:00 -0000
Message-id: <001101c0f52f$550a99c0$0200a8c0@lifelesswks>
References: <3B290FE5.22678B61@trex.rtpnc.epa.gov> <03cb01c0f529$7b826020$0200a8c0@lifelesswks> <20010614195350.D13587@redhat.com>
X-SW-Source: 2001-q2/msg00307.html

----- Original Message ----- 
From: "Christopher Faylor" <cgf@redhat.com>
>
> >Fri June 15 09:25:00  Robert Collins <rbtcollins@hotmail.com>
> >
> > * thread.cc (pthread_cond::Signal): Release the condition access
> > variable correctly.
> 
> Patch applied.

Yes! I finally got a ChangeLog that was ok!
woohoo!

Rob

> 
> cgf
> 

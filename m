From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "egor duda" <cygwin-patches@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: PTHREAD_COND_INITIALIZER support
Date: Thu, 15 Nov 2001 04:20:00 -0000
Message-ID: <030601c16dd0$1a48ac40$0200a8c0@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F28E@itdomain002.itdomain.net.au> <92602986318.20011109105819@logos-m.ru> <17285934467.20011115142602@logos-m.ru>
X-SW-Source: 2001-q4/msg00227.html
Message-ID: <20011115042000.v6lS1Rn2XEM12CYAIc3-qPBvX7iZEX9Xi1AMSnMPp4o@z>

----- Original Message -----
From: "egor duda" <deo@logos-m.ru>
..
> ed> yes. i'm going to add a bunch of pthread tests after this checkin.
>
> done too.
>
> Robert, can you please take a look at winsup.api/pthread/condvar3_1.c
> test? it looks like when condition variable is signalled, two threads
> wake on it instead of one. it's quite stable effect, so i don't think
> we have a race here.

Ok, it's probably the wakeup code. Do you have a sinlge or dual machine?

Rob

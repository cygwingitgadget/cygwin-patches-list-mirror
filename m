From: Christopher Faylor <cgf@redhat.com>
To: newlib-patches@sources.redhat.com, cygwin-patches@cygwin.com
Subject: Re: Pthread support in cygwin
Date: Wed, 11 Apr 2001 17:06:00 -0000
Message-id: <20010411200704.A30651@redhat.com>
References: <038901c0c2e3$794e6740$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00033.html

On Thu, Apr 12, 2001 at 09:59:24AM +1000, Robert Collins wrote:
>This patch and attached changelog (my mailer stuffs up the formatting)
>are a resubmission of the previosuly discussed patches for pthreads &
>cygwin in newlib. I will look into a larger rearrangement as
>discussed... but that will be much later. I won't shed any tears if the
>rtems folk get there first :]
>
>This patch is self-contained: committing it now should not cause any
>problems with the existing pthread support in cygwin. (However I haven't
>tried to mix and match so...)
>
>==
>2001-04-12  Robert Collins <rbtcollins@hotmail.com>
>
> * libc/include/sys/features.h: Add appropriate defines for Cygwin
>pthread support.
> * libc/include/sys/signal.h: Remove unneeded __CYGWIN__ protection.
> * libc/include/sys/types.h: Protect __CYGWIN__ from the rtems pthreads
>types.
> Include <cygwin/types.h> for the cygwin specific typedefs.

I've committed these since they only affected Cygwin-specific code.

Thank you for seeing this through, Robert.

cgf

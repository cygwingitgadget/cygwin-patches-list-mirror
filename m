From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin/newlib types patchs
Date: Wed, 21 Mar 2001 06:09:00 -0000
Message-id: <20010321090936.G3149@redhat.com>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00223.html

On Wed, Mar 21, 2001 at 08:10:00PM +1100, Robert Collins wrote:
>    * include/cygwin/types.h: Add pthread_*_t typedefs for user code and
>for building cygwin.

I'm not comfortable with adding a new file with such a generic name here.
Shouldn't this just be cygwin/pthread.h, or something?

cgf

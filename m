From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin/newlib types patchs
Date: Wed, 21 Mar 2001 14:01:00 -0000
Message-id: <20010321170214.B9775@redhat.com>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090936.G3149@redhat.com> <001501c0b24c$90458e30$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00227.html

On Thu, Mar 22, 2001 at 08:19:05AM +1100, Robert Collins wrote:
>
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Thursday, March 22, 2001 1:09 AM
>Subject: Re: cygwin/newlib types patchs
>
>
>> On Wed, Mar 21, 2001 at 08:10:00PM +1100, Robert Collins wrote:
>> >    * include/cygwin/types.h: Add pthread_*_t typedefs for user code
>and
>> >for building cygwin.
>>
>> I'm not comfortable with adding a new file with such a generic name
>here.
>> Shouldn't this just be cygwin/pthread.h, or something?
>
>You're not adding. It was already there, just absolutely bare bones.
>Corinna suggested that we include a cygwin/file for types that are
>included into user apps via sys/types.h, but specific to newlib - that
>file seemed most appropriate to me.

Actually, checking the history, it looks like I added this but it was
a mistake.  I probably did a massive 'cvs add' and ended up adding this.
I probably thought I needed it at some point and then changed my mind.

However, I guess it makes sense to have something like this.

cgf

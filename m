From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-developers@cygwin.com
Subject: Re: Egor's daemon
Date: Wed, 12 Sep 2001 09:13:00 -0000
Message-id: <20010912121322.A17887@redhat.com>
References: <1000295535.30404.67.camel@lifelesswks> <20010912115511.A17668@redhat.com> <1000310370.30375.141.camel@lifelesswks>
X-SW-Source: 2001-q3/msg00130.html

On Thu, Sep 13, 2001 at 01:59:29AM +1000, Robert Collins wrote:
>On Thu, 2001-09-13 at 01:55, Christopher Faylor wrote:
>> On Wed, Sep 12, 2001 at 09:52:14PM +1000, Robert Collins wrote:
>> >Attached is a slightly reworked daemon that will not impact 95 in speed
>> >(well at dll load for non-forked process's it will, but not after that
>> >first request).
>> >
>> >Egors original message with changelogs describing this beast is
>> >available
>> > http://sources.redhat.com/ml/cygwin-patches/2001-q1/msg00260.html here.
>> >
>> >I've altered the layout slightly - I consider the daemon more core than
>> >(say) cygcheck, so I placed it all in cygwin.
>> 
>> I don't recall the original layout but if it created a new directory then
>> that is correct.  This shouldn't be in the cygwin directory.  I made a concerted
>> effort to make it one directory per "thing" a while ago.  cygserver is another
>> "thing".
>
>The original layout put it in utils, which didn't really fit either.
>
>Ok, I'll move it out. Do you wnat the shared functions (like
>set_os_type) duplicated;put into a convenience library; or link straight
>to the .o in the cygwin directory?

I'm not sure since set_os_type is undergoing a radical rewrite in 1.3.4.

It sounds like cygserver needs its own directory.

If it is using non-exported functions from cygwin then we have to design
how the two entities communicate with each other.

cgf

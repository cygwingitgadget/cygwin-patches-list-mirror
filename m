From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Egor's daemon
Date: Wed, 12 Sep 2001 09:31:00 -0000
Message-id: <20010912123116.A18008@redhat.com>
References: <1000295535.30404.67.camel@lifelesswks> <20010912115511.A17668@redhat.com> <1000310370.30375.141.camel@lifelesswks> <20010912121322.A17887@redhat.com> <6611059312.20010912202029@logos-m.ru>
X-SW-Source: 2001-q3/msg00133.html

On Wed, Sep 12, 2001 at 08:20:29PM +0400, egor duda wrote:
>Hi!
>
>Wednesday, 12 September, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>>>> I don't recall the original layout but if it created a new directory then
>>>> that is correct.  This shouldn't be in the cygwin directory.  I made a concerted
>>>> effort to make it one directory per "thing" a while ago.  cygserver is another
>>>> "thing".
>>>
>>>The original layout put it in utils, which didn't really fit either.
>>>
>>>Ok, I'll move it out. Do you wnat the shared functions (like
>>>set_os_type) duplicated;put into a convenience library; or link straight
>>>to the .o in the cygwin directory?
>
>CF> I'm not sure since set_os_type is undergoing a radical rewrite in 1.3.4.
>
>CF> It sounds like cygserver needs its own directory.
>
>CF> If it is using non-exported functions from cygwin then we have to design
>CF> how the two entities communicate with each other.
>
>daemon itself doesn't use non-exported functions. Actually, it doesn't
>use cygwin1.dll at all -- it should be built with -mno-cygwin
>
>the client part -- which is linked into dll does use functions like
>api_fatal, but i think it belongs to winsup/cygwin/ directory.

If the client part is linked into the DLL, it should be in the cygwin
directory, sure.

I think we are not at the point where we include this in the cygwin
directory, though.  I'd like to discuss how we are going to be interfacing
the client code with the cygwin DLL, though.

I'm not yet comfortable with making it an integral part of the DLL.

cgf

From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: Egor's daemon
Date: Wed, 12 Sep 2001 09:21:00 -0000
Message-id: <6611059312.20010912202029@logos-m.ru>
References: <1000295535.30404.67.camel@lifelesswks> <20010912115511.A17668@redhat.com> <1000310370.30375.141.camel@lifelesswks> <20010912121322.A17887@redhat.com>
X-SW-Source: 2001-q3/msg00131.html

Hi!

Wednesday, 12 September, 2001 Christopher Faylor cgf@redhat.com wrote:

>>> I don't recall the original layout but if it created a new directory then
>>> that is correct.  This shouldn't be in the cygwin directory.  I made a concerted
>>> effort to make it one directory per "thing" a while ago.  cygserver is another
>>> "thing".
>>
>>The original layout put it in utils, which didn't really fit either.
>>
>>Ok, I'll move it out. Do you wnat the shared functions (like
>>set_os_type) duplicated;put into a convenience library; or link straight
>>to the .o in the cygwin directory?

CF> I'm not sure since set_os_type is undergoing a radical rewrite in 1.3.4.

CF> It sounds like cygserver needs its own directory.

CF> If it is using non-exported functions from cygwin then we have to design
CF> how the two entities communicate with each other.

daemon itself doesn't use non-exported functions. Actually, it doesn't
use cygwin1.dll at all -- it should be built with -mno-cygwin

the client part -- which is linked into dll does use functions like
api_fatal, but i think it belongs to winsup/cygwin/ directory.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

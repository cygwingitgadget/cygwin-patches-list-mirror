From: Christopher Faylor <cgf@redhat.com>
To: Cygwin-Patches@Cygwin.Com
Subject: Re: patch for cygpath
Date: Tue, 07 Aug 2001 10:23:00 -0000
Message-id: <20010807132314.B29241@redhat.com>
References: <C2D7D58DBFE9D111B0480060086E963504AC52AD@mail.gft.de>
X-SW-Source: 2001-q3/msg00071.html

On Tue, Aug 07, 2001 at 06:54:03PM +0200, Schaible, Jorg wrote:
>>-----Original Message-----
>>From: Earnie Boyd [ mailto:earnie_boyd@yahoo.com ]
>>Sent: Tuesday, August 07, 2001 8:13 PM
>>To: cygwin-patches@Cygwin.Com
>>Subject: Re: patch for cygpath
>>
>>
>>Christopher Faylor wrote:
>>> 
>>> I don't have much of an opinion on this patch however it seems to
>>> needlessly complicate cygpath for minimal gain.
>>> 
>>
>>Ditto.
>
>Well, it just ensures that the physical name is the delivered one.

But it really doesn't matter since Windows is case insensitive and
we're using Windows' mechanism for retrieving the name anyway.  It
just seems like "busy work".

>>
>>> I also don't see why cygpath would need to output the 
>>windows version of
>>> windows/system.  That sort of bypasses the "cyg" part of things.
>>> 
>>
>>Ditto.
>
>I did it just for a continuous option support. It is handy dealing with
>non-Cygwin apps, e.g. using Cygwin environment developing Java (all those
>CLASSPATH issues).
>
>But I don't mind, if you won't accept. Was just my point of view.
>:)

I'd like to get some opinions on it.  So far we've just heard from Earnie.

cgf

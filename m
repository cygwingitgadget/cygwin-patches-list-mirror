From: Christopher Faylor <cgf@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: New terminal capability in fhandler_console.cc
Date: Sat, 31 Mar 2001 10:39:00 -0000
Message-id: <20010331133947.B3098@redhat.com>
References: <20010330131541.P16622@cygbert.vinschen.de> <20010330104728.E12718@redhat.com> <20010330192244.X16622@cygbert.vinschen.de> <20010330170201.A29301@redhat.com> <20010331015252.A16622@cygbert.vinschen.de> <20010330193658.F31805@redhat.com> <20010331113118.A8711@cygbert.vinschen.de> <20010331124602.A2693@redhat.com> <20010331201712.G16622@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00282.html

On Sat, Mar 31, 2001 at 08:17:12PM +0200, Corinna Vinschen wrote:
>>How about insert character (\E[%p1%d@) and delete character
>>(\E[%p1%dP)?
>>
>>They should be trivial now as well, shouldn't they?
>
>They are the most trivial ones.  They already exist ;-)

I guess that shows that I have to eat my own dog food.  I didn't check
the source.

Sorry.

cgf

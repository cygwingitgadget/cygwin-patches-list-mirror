From: Robert Collins <robert.collins@itdomain.com.au>
To: cygwin-patches@cygwin.com
Subject: Re: Exception using GDB
Date: Wed, 25 Jul 2001 17:57:00 -0000
Message-id: <996109235.18583.6.camel@lifelesswks>
References: <047f01c114ee$38e66600$0300a8c0@ufo> <996096632.17154.7.camel@lifelesswks> <20010725173223.A11993@redhat.com>
X-SW-Source: 2001-q3/msg00036.html

On 25 Jul 2001 17:32:23 -0400, Christopher Faylor wrote:
> On Thu, Jul 26, 2001 at 07:30:32AM +1000, Robert Collins wrote:
> >On 25 Jul 2001 19:12:05 +0930, Trevor Forbes wrote:
> >> A fix for the bad pointer exception when a debugger is attached. 
> >> 
> >>  * thread.cc (verifyable_object_isvalid): Don't validate
> >> PTHREAD_MUTEX_INITIALIZER pointer as it will cause an exception in
> >> IsBadWritePtr() when running GDB.
> >> 
> >> Note, Insight has a bug and it will not work without this patch.... 
> >> 
> >> Trevor
> >> 
> >Thanks Trevor, that looks good.
> >
> >Chris - can you do the honours, or would you like me to?
> 
> Go ahead, Rob.
> 
> cgf
Done.

Rob

From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Wed, 27 Jun 2001 08:22:00 -0000
Message-id: <20010627112321.A21615@redhat.com>
References: <20010627023524.S19058@redhat.com> <00aa01c0ff1b$44106960$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00355.html

On Wed, Jun 27, 2001 at 11:10:13AM -0400, Norman Vine wrote:
>Christopher Faylor writes:
>>
>>On Wed, Jun 27, 2001 at 02:20:08AM -0400, Norman Vine wrote:
>>>
>>>I tried Rob's proposed  IsBadWritePtr(...) patch 
>>>< see cygwin list [RE:] pthreads works ,sorta  thread >
>>>
>>>And running the Python regression suite is an 
>>>ORDER of MAGNITUDE FASTER
>>>with this patch applied :-))
>>>
>>>real    7m5.712s
>>>user    2m50.883s
>>>sys     1m15.236s
>>
>>I bet it would improve even more if we replaced the VirtualQuery
>>in path.cc, too.
>
>With Rob's new patch that does this, 
>there actually isn't very much difference
>
>real    7m10.729s
>user    2m50.963s
>sys     1m11.721s
>
>Thanks !

Huh.  I wonder why it makes such a big difference for pthreads.

cgf

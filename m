From: "Norman Vine" <nhv@cape.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Wed, 27 Jun 2001 08:04:00 -0000
Message-id: <00aa01c0ff1b$44106960$a300a8c0@nhv>
References: <20010627023524.S19058@redhat.com>
X-SW-Source: 2001-q2/msg00354.html

Christopher Faylor writes:
>
>On Wed, Jun 27, 2001 at 02:20:08AM -0400, Norman Vine wrote:
>>
>>I tried Rob's proposed  IsBadWritePtr(...) patch 
>>< see cygwin list [RE:] pthreads works ,sorta  thread >
>>
>>And running the Python regression suite is an 
>>ORDER of MAGNITUDE FASTER
>>with this patch applied :-))
>>
>>real    7m5.712s
>>user    2m50.883s
>>sys     1m15.236s
>
>I bet it would improve even more if we replaced the VirtualQuery
>in path.cc, too.

With Rob's new patch that does this, 
there actually isn't very much difference

real    7m10.729s
user    2m50.963s
sys     1m11.721s

Thanks !

Norman

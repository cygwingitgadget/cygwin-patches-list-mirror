From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Tue, 26 Jun 2001 23:34:00 -0000
Message-id: <20010627023524.S19058@redhat.com>
References: <006a01c0fe7b$7f0d8980$a300a8c0@nhv> <008e01c0fed1$371ad820$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00347.html

On Wed, Jun 27, 2001 at 02:20:08AM -0400, Norman Vine wrote:
>Norman Vine  wrote:
>>
>>Jason Tishler writes:
>>
>>>How long does it take to run the regression tests (sans test_poll)?
>>
>>A long time :-( < several hours >
>>the re, sre and various unicode tests seem to take forever
>>I will add a timer to the python regression test to time each
>>module tested and post the results.
>
>I tried Rob's proposed  IsBadWritePtr(...) patch 
>< see cygwin list [RE:] pthreads works ,sorta  thread >
>
>And running the Python regression suite is an 
>ORDER of MAGNITUDE FASTER
>with this patch applied :-))
>
>real    7m5.712s
>user    2m50.883s
>sys     1m15.236s

I bet it would improve even more if we replaced the VirtualQuery
in path.cc, too.

cgf

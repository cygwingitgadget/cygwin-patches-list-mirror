From: "Norman Vine" <nhv@cape.com>
To: "'Jason Tishler'" <Jason.Tishler@dothill.com>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Tue, 26 Jun 2001 23:14:00 -0000
Message-id: <008e01c0fed1$371ad820$a300a8c0@nhv>
References: <006a01c0fe7b$7f0d8980$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00346.html

Norman Vine  wrote:
>
>Jason Tishler writes:
>
>>How long does it take to run the regression tests (sans test_poll)?
>
>A long time :-( < several hours >
>the re, sre and various unicode tests seem to take forever
>I will add a timer to the python regression test to time each
>module tested and post the results.

I tried Rob's proposed  IsBadWritePtr(...) patch 
< see cygwin list [RE:] pthreads works ,sorta  thread >

And running the Python regression suite is an 
ORDER of MAGNITUDE FASTER
with this patch applied :-))

real    7m5.712s
user    2m50.883s
sys     1m15.236s

Cheers

Norman


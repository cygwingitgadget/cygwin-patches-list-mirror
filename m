From: "Norman Vine" <nhv@cape.com>
To: "'Jason Tishler'" <Jason.Tishler@dothill.com>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Tue, 26 Jun 2001 13:00:00 -0000
Message-id: <006a01c0fe7b$7f0d8980$a300a8c0@nhv>
References: <20010626103350.P296@dothill.com>
X-SW-Source: 2001-q2/msg00343.html

Jason Tishler writes:
>
>
>On Tue, Jun 26, 2001 at 10:27:49AM -0400, Norman Vine wrote:
>> Since my last correspondance with Jason I have tested this with
>> the 'stock'  Python-2.1 tarball and all seems to be OK
>
>How long does it take to run the regression tests (sans test_poll)?

A long time :-( < several hours >
the re, sre and various unicode tests seem to take forever
I will add a timer to the python regression test to time each
module tested and post the results.

>> I am experiencing an occasional 'hang' in the make process
>> this is on WIn2k sp2 and the 'very latest' Cygwin files.
>> Usually a 'ctrl-C' will abort the make and a subsequent make
>> will  run to completion.  This make behaviour is not isolated to the
>> Python build but I have not been able to find a situation that will
>> reliably reproduce it.
>
>FWIW, I am experiencing the "hang" under Windows NT 4.0 SP5.  However,
>for me, the hang is with Python (with threads) and not make itself.
>
>IIRC, during the make I see two python processes.  After killing the
>make, I still see one python process that needs to be manually killed.
>Please do a ps before and after you kill the make.  Are you observing
>this behavior or something different?

FYI
I have rebuilt the Python-2.1 tarball several times today and the make never
hung
This is using today's CVS Cygwin files.

I wonder if the difference is because I am on Win2k and you are on NT ?

Cheers

Norman

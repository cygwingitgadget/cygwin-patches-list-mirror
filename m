From: "Norman Vine" <nhv@cape.com>
To: "'Robert Collins'" <robert.collins@itdomain.com.au>, "'Jason Tishler'" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Sat, 29 Sep 2001 08:34:00 -0000
Message-id: <002201c148fc$ec7c1d80$a300a8c0@nhv>
References: <038301c148cb$7cf7a550$01000001@lifelesswks>
X-SW-Source: 2001-q3/msg00237.html

Robert Collins writes:

>----- Original Message -----
>From: "Jason Tishler" <jason@tishler.net>
>>
>> On Fri, Sep 28, 2001 at 05:48:16PM +1000, Robert Collins wrote:
>> > Well this patch should make evreything good -  fixing the critical
>> > section induced race.
>>
>> At the risk of appearing dense...  Should this patch fix the pthreads
hang
>> trigger by Python's test_threadedtempfile regression test?
>
>I've checked in my completed code. I -cannot- tickle this bug via my
>test suite at all now. (I found that one of my test scripts was slightly
>buggy in that it made an incorrect assumption - it was passing when this
>bug was tickled - correcting that let me hit this bug nearly every time
>:]).
>
>So please, give it a go and see how it fares.

This now causes a hard crash in any of the Python threading tests
with an attempt to read memory at 0x00000018 failure.

Note I believe this started, for me at least, with the second piece of this
patch.
Also note that I could not tickle this bug before.
Win2k sp2  Cygwin=ntsec   python src 2-1.1-2 from cygwin distribution

FYI
gdb does attach to the failed python process
Is there any further info I can send.
Being a bit of a gdb tweeb I may need fairly detailed instructions
as to the gdb commands to issue

Cheers

Norman Vine

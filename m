From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <nhv@cape.com>, "'Jason Tishler'" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Sat, 29 Sep 2001 21:58:00 -0000
Message-id: <04f101c1496c$bfb636d0$01000001@lifelesswks>
References: <002201c148fc$ec7c1d80$a300a8c0@nhv>
X-SW-Source: 2001-q3/msg00240.html

----- Original Message -----
From: "Norman Vine" <nhv@cape.com>
To: "'Robert Collins'" <robert.collins@itdomain.com.au>; "'Jason
Tishler'" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
Sent: Sunday, September 30, 2001 1:39 AM
Subject: RE: fix cond_race... was RE: src/winsup/cygwin ChangeLog
thread.cc thread.h ...


> Robert Collins writes:
>
> >----- Original Message -----
> >From: "Jason Tishler" <jason@tishler.net>
> >>
> >> On Fri, Sep 28, 2001 at 05:48:16PM +1000, Robert Collins wrote:
> >> > Well this patch should make evreything good -  fixing the
critical
> >> > section induced race.
> >>
> >> At the risk of appearing dense...  Should this patch fix the
pthreads
> hang
> >> trigger by Python's test_threadedtempfile regression test?
> >
> >I've checked in my completed code. I -cannot- tickle this bug via my
> >test suite at all now. (I found that one of my test scripts was
slightly
> >buggy in that it made an incorrect assumption - it was passing when
this
> >bug was tickled - correcting that let me hit this bug nearly every
time
> >:]).
> >
> >So please, give it a go and see how it fares.
>
> This now causes a hard crash in any of the Python threading tests
> with an attempt to read memory at 0x00000018 failure.
>
> Note I believe this started, for me at least, with the second piece of
this
> patch.
> Also note that I could not tickle this bug before.

Interesting. Well I can drop you an updated test case which I'm sure
will tickle the older .dll. Also I found that backgrounding the window
the test is running in took the chance of hitting the bug from "very
likely" to "sure thing" - if you'll excuse the technical talk :].

> Win2k sp2  Cygwin=ntsec   python src 2-1.1-2 from cygwin distribution
>
> FYI
> gdb does attach to the failed python process
> Is there any further info I can send.

Yes. I don't have python build environment, nor much interest in having
one - so you'll need to find what bit of cygwin code is dying, and then
I'll come up with a fix for you.

> Being a bit of a gdb tweeb I may need fairly detailed instructions
> as to the gdb commands to issue

Start with bt, to get a back trace. From there look to see which
function has died. If for example the crash occured in
__pthread_cond_signal, then you would do a info locals to get local
data, and send me the bt and the info local output.

If the crash occured somewhere more detailed, like check_null_address,
then going up a frame or two would help. Lastly, if there is a class
method and a pthread wrapper both in the stack frame, info locals from
both is very useful. In the class method be sure to include the output
of
p *this
as well.

Rob

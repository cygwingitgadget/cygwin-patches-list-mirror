From: Warren Young <warren@etr-usa.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Wed, 28 Nov 2001 15:31:00 -0000
Message-ID: <3C0573DE.349B65DA@etr-usa.com>
References: <3C035977.BF151D0A@syntrex.com> <000601c17772$7c5ecfd0$2101a8c0@d8rc020b> <20011127184223.GA24028@redhat.com> <1006899141.2048.2.camel@lifelesswks> <20011127230925.GA5830@redhat.com>
X-SW-Source: 2001-q4/msg00283.html
Message-ID: <20011128153100.8CXmm75EqhvRUdkLwSgt-cCsmwGbIDOc86EjAYPQvkU@z>

Christopher Faylor wrote:
> 
> References?  A simple google search for 'NULL C++ deprecated' didn't
> unearth this information.

This controversy officially started with the ARM, IIRC.  In it, I recall
that the authors made some comments saying that NULL should die.  I
don't keep the ARM here at work any more, though, so I have no reference
to back that recollection up.

In section 5.1.1 of the more current Stroustrup 3/e he says, "Because of
C++'s tighter type checking, the use of plain 0, rather than any
suggested NULL macro, leads to fewer problems."

I don't know what problems Stroustrup is referring to.  In section 18.1
of the current C++ Standard, footnote 180 says: "Possible definitions
[of NULL] include 0 and 0L, but not (void*)0."  This implies that NULL
is most likely to expand to a literal 0, and not the distasteful casted
pointer you see in C compilers' standard libraries.  Of course there are
old systems with NULL still defined to (void*)0, but Cygwin's g++/newlib
system isn't one of these.

Okay, "NULL" is fine to use, then.  As for "0", the C++ standard
guarantees that if you use 0 in a pointer context, it will be converted
to whatever that platform uses for the "null pointer", even if it
happens not to have a bit pattern of all zeroes.  (Section 4.10) 
Therefore, it's safe to use 0 to mean "the null pointer".

Personally, I prefer 0 to NULL, though I leaned the other way before C++
evolved to where it is today, since the C standard did not guarantee
that 0 would convert to the null pointer.  In practice, with a
conforming C++ implementation, it probably doesn't matter either way --
it's now just a style issue.
-- 
= ICBM Address: 36.8274040 N, 108.0204086 W, alt. 1714m

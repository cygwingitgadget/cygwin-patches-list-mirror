From: Christopher Faylor <cgf@redhat.com>
To: cygwin-developers@sources.redhat.com, cygwin-patches@cygwin.com
Subject: Re: hierarchy in setup (category stuff)
Date: Fri, 29 Jun 2001 08:39:00 -0000
Message-id: <20010629114004.A6990@redhat.com>
References: <04e801c0faa2$f9008260$0200a8c0@lifelesswks> <20010621222615.C13746@redhat.com> <3B3324A7.49FFC98A@yahoo.com> <054c01c0fbef$5f600e20$0200a8c0@lifelesswks> <06a001c0fc51$7a87e210$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00368.html

On Sun, Jun 24, 2001 at 12:00:43PM +1000, Robert Collins wrote:
>----- Original Message -----
>From: "Robert Collins" <robert.collins@itdomain.com.au>
>
>
>>
>> I've attached my current sandbox changes. The code _is not finished_.
>(I
>> am _looking_ at adding the prev/curr/exp capability to whole
>categories
>> as well as the code cleanliness I mention below).
>>
>
>Still not 100%, but much cleaner and easier to read:
>
>Known bugs:
>1) The partial view when you enter the package list has a scroll bar one
>line too many long.
>2) The category view always shows _all_ packages. There's no
>category-partial view. Do we need one?

I just played with this and I like what I see.

I had a hard time getting all of the changes into the current CVS, though,
and the view was sort of screwed up.

Robert, if you are still interested, then I think that this is definitely the
way to go.  If you have something worth checking in, then please do so.

One thing I noticed is that the Category view is not the default and I think
it should be.  Or, maybe that was just a botched patch.

Thanks,
cgf

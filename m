From: Christopher Faylor <cgf@redhat.com>
To: cygwin-developers@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: hierarchy in setup (category stuff)
Date: Fri, 29 Jun 2001 19:25:00 -0000
Message-id: <20010629222604.A11444@redhat.com>
References: <06a001c0fc51$7a87e210$0200a8c0@lifelesswks> <20010629114004.A6990@redhat.com> <VA.00000842.01fd0b44@thesoftwaresource.com> <20010629172912.A8991@redhat.com> <032001c100fe$d62310c0$806410ac@local> <20010629205735.K9607@redhat.com> <034701c10106$34f6b6e0$806410ac@local> <036501c10108$b55383c0$806410ac@local> <20010629221309.A11334@redhat.com> <038301c1010a$bab7e840$806410ac@local>
X-SW-Source: 2001-q2/msg00378.html

On Sat, Jun 30, 2001 at 12:16:52PM +1000, Robert Collins wrote:
>
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>To: <cygwin-developers@cygwin.com>; <cygwin-patches@cygwin.com>
>Sent: Saturday, June 30, 2001 12:13 PM
>Subject: Re: hierarchy in setup (category stuff)
>
>
>> On Sat, Jun 30, 2001 at 12:02:24PM +1000, Robert Collins wrote:
>> >Michael,
>> >    I think I trashed some of your src related patches, CVS didn't report
>> >any errors merging, but I just have this nasty suspicion.
>>
>> You did.  All of my changes are gone, too.
>>
>> I'd like to revert CVS to pre-your-change and try again.  Is that ok?
>
>It's possibly easier just to grab the diffs that you committed before and
>apply those again. (ie cvs rdiff -r 2.33 -r 2.35 choose.cc )

I'd tried that (or cvs diff, actually).  There are a lot of rejections
when I do that.

Do you know the revisions of the files that you had in your sandbox?  I
had done checkins to two files on 2001-06-25.  I assume that you were
probably up-to-date with the 2001-06-17 versions of those files previously,
right?

cgf

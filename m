From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@Cygwin.Com
Subject: Re: winsup/cygwin/lib/getopt.c -mno-cygwin
Date: Fri, 21 Sep 2001 16:27:00 -0000
Message-id: <20010921192814.D4475@redhat.com>
References: <3BAB474A.36883B32@yahoo.com> <20010921135147.C32224@redhat.com> <3BAB8D40.D1DF3161@yahoo.com> <20010921152059.A3866@redhat.com> <3BABA188.22A9FCE7@yahoo.com> <20010921171526.E4067@redhat.com> <3BABB4CA.C36ED3F4@yahoo.com>
X-SW-Source: 2001-q3/msg00180.html

On Fri, Sep 21, 2001 at 05:44:42PM -0400, Earnie Boyd wrote:
>Christopher Faylor wrote:
>> 
>> On Fri, Sep 21, 2001 at 04:22:32PM -0400, Earnie Boyd wrote:
>> >Christopher Faylor wrote:
>> >>
>> >> On Fri, Sep 21, 2001 at 02:56:00PM -0400, Earnie Boyd wrote:
>> >> >Did you try `strace -j'?  The valid options work the invalid option
>> >> >brings up Dr. Watson.
>> >>
>> >> Yes.  I tried using options that didn't exist since that is the reason
>> >> for the _argv patch.
>> >>
>> >
>> >Strange!?  Differences between NT4 and W2K?  Should I apply the patch?
>> 
>> I tried this on W2K and Windows 95.  It's odd that it would work on
>> both of those.
>> 
>> I just tried a fresh rebuild from CVS.  It still works fine.  Odd.
>> 
>
>You're saying you don't need the patch????!!  You're saying that you
>don't get:

Earnie, I try not to check in changes which don't build for me.  So,
no, I do not need your changes.  I guess when I said:

"This does not crash for me.  It builds and runs fine on both linux and
windows."

I should have added "without any patching".

However, if I did need something like your changes, I would not just
check something in that just allows strace to build but results in a
segv.

cgf

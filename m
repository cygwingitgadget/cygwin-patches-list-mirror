From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix for pthread_broadcast
Date: Sun, 06 May 2001 15:09:00 -0000
Message-id: <20010506180724.A15983@redhat.com>
References: <027501c0d5fd$19ffca90$0200a8c0@lifelesswks> <20010506120610.B6923@redhat.com> <005701c0d677$3de1bbb0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00195.html

On Mon, May 07, 2001 at 07:55:17AM +1000, Robert Collins wrote:
>
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Monday, May 07, 2001 2:06 AM
>Subject: Re: fix for pthread_broadcast
>
>
>> On Sun, May 06, 2001 at 05:13:25PM +1000, Robert Collins wrote:
>> >pthread_broadcast was broken. This patch fixes it for the testcase
>> >reported by Greg Smith. I've also introduced per-cond variable
>locking
>> >to make broadcasts atomic. There are still races present, however the
>> >worst case is an occasional dropped signal. (And note that to trigger
>> >the race, the users code must be such that the signal could be missed
>> >_anyway_ ).
>>
>> This looks good except for two formatting problems.
>>
>> 1) Please submit a ChangeLog entry, not a diff of a ChangeLog entry.
>This
>>    is pretty much a standard requirement for any GNU program
>submission.
>
>The one in the email was a entry, I mucked up and attached the diff.
>Sorry.

No problem.  I always feel like an pedantic idiot for even bothering
to mention this but I'm playing for the archives...

Thanks,
cgf

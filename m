From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: fix for pthread_broadcast
Date: Sun, 06 May 2001 14:57:00 -0000
Message-id: <005701c0d677$3de1bbb0$0200a8c0@lifelesswks>
References: <027501c0d5fd$19ffca90$0200a8c0@lifelesswks> <20010506120610.B6923@redhat.com>
X-SW-Source: 2001-q2/msg00194.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Monday, May 07, 2001 2:06 AM
Subject: Re: fix for pthread_broadcast


> On Sun, May 06, 2001 at 05:13:25PM +1000, Robert Collins wrote:
> >pthread_broadcast was broken. This patch fixes it for the testcase
> >reported by Greg Smith. I've also introduced per-cond variable
locking
> >to make broadcasts atomic. There are still races present, however the
> >worst case is an occasional dropped signal. (And note that to trigger
> >the race, the users code must be such that the signal could be missed
> >_anyway_ ).
>
> This looks good except for two formatting problems.
>
> 1) Please submit a ChangeLog entry, not a diff of a ChangeLog entry.
This
>    is pretty much a standard requirement for any GNU program
submission.

The one in the email was a entry, I mucked up and attached the diff.
Sorry.

> 2) There are some formatting problems.  This block illustrates two:
>
> +  if ((temperr=pthread_mutex_init(&this->cond_access, NULL)))
>        ^                  ^
>        missing spaces  here
> +    {
> +      system_printf("couldn't init mutex, this = %0p
errno=%d\n",this,temperr);
> +      /* we need the mutex for correct behaviour */
> +      magic = 0;
>
> And, just a very minor nit, which you can take or leave.  I have tried
to
> avoid using foo = %s in debugging output in favor of foo %s, which I
> think is equally clear to a human and results in less output in an
> strace log file.

I'm not worried either way... I'll pull it back to foo 0x00000223

> It isn't a universal constant, of course.  I don't know if Corinna
follows
> this rule or not.  It's just an opinion that you can either take or
leave.
>
> If you make the formatting changes above, feel free to check this in.

Thanks,
Rob

> cgf
>

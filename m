From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-xfree@cygwin.com
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 22:26:00 -0000
Message-id: <20010417012658.F28358@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EEF0@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00087.html

On Tue, Apr 17, 2001 at 02:57:58PM +1000, Robert Collins wrote:
>> I won't disagree with the thought of getting rid of passwd_sem since
>> that is what I've been saying from the start.  I don't like the
>> idea of allowing a one-off parse of /etc/passwd, though.
>
>Why not? I'm suggesting that we actually get to check security on
>/etc/passwd in calls to getpwnam. Or is that a bad thing?

Not in general, but I know from experience that adding /etc/passwd
parsing slows down things badly and people complain.  I still have a
nagging feeling that we should be able to do this without resorting to
double parsing, too...  It's too late for me to do creative thinking,
though.

>Other than that, it looks good. I presume the cygheap-> changes are
>related issues/general code tidyup?

Oops.  Yes.  Those were unrelated.  I edited them out of my first
two attempts to send this email but forgot to do so on the third
attempt.

I'm attempting to get vfork working correctly for 1.3.0 and am finding
that I have to do some rearranging of some of Cygwin's "heap" to
accomodate this.

cgf

From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Console codepage
Date: Sun, 28 Jan 2001 14:21:00 -0000
Message-id: <20010128172112.A21847@redhat.com>
References: <u7l3fv26h.fsf@mail.epost.de> <20010128154852.A20701@redhat.com> <m3vgqztllj.fsf@benny-ppc.crocodial.de>
X-SW-Source: 2001-q1/msg00041.html

On Sun, Jan 28, 2001 at 10:26:00PM +0100, Benjamin Riefenstahl wrote:
>Hi Christopher,
>
>Christopher Faylor <cgf@redhat.com> writes:
>> Please look at the "Contributing" link on the Cygwin web page.  I've
>> gone to some pains to update it lately by showing examples of common
>> problems with patch submissions.  Unfortunately, there were several
>> problems with this submission.
>
>O.k., I hope this one is better (see below). 

It is better, but not quite right.  I hate to be picky, but if you look
at other entries in the Cygwin ChangeLog, you'll see that this
has some differences.

New functions look like this:

	* foo.c (somefunc): New function.

And, you shouldn't list more than one file or function on a line.

If the feedback is positive for this patch, I'll make those corrections
when it is checked in.

cgf

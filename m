From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: memory leak in cygheap -- tester needed
Date: Sun, 30 Sep 2001 21:13:00 -0000
Message-id: <20011001001356.A18727@redhat.com>
References: <15294469449.20010927205156@logos-m.ru> <20010927140039.A32577@redhat.com> <15899509507.20010927221556@logos-m.ru> <20010928014713.G32646@redhat.com> <20010930210446.A4405@redhat.com>
X-SW-Source: 2001-q3/msg00258.html

On Sun, Sep 30, 2001 at 09:04:46PM -0400, Christopher Faylor wrote:
>I just wiped out big chunks of the fhandler code which dealt with the
>names allocation.  It was quite satisfying.
>
>Corinna's idea of calling patch_conv "early" is really proving to
>simplify a lot of things -- most notably stat_worker().
>
>I'm running the test suite now and fixing some last minute glitches but
>I expect to have something to check in tomorrow.

I just checked this in.  It passes the test suite.  I can login using
ssh and telnet.  I can run rxvt.  I'm sure I've missed something,
though.

The one thing that I didn't check was raw device handling.  I could have
conceivably broken that.

Can anyone test that raw device handling of floppies, tapes, and hard
disks still works?  Corinna won't be available to test this so I must
rely on the kindness of you all...

I'd like to verify that the memory leak is gone, too.  It seems to be because
I saw it when I was copying a large directory recursively but my changes
eliminated the problem.

cgf

From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]Sample setup.ini
Date: Sat, 30 Jun 2001 20:21:00 -0000
Message-id: <20010630232153.B2590@redhat.com>
References: <000201c1014a$19cf53b0$6464648a@ca.boeing.com> <04c901c10160$4005e1a0$806410ac@local> <20010630120243.D12695@redhat.com> <20010630153329.A16134@redhat.com> <01a301c101bf$61839840$6464648a@ca.boeing.com>
X-SW-Source: 2001-q2/msg00392.html

On Sat, Jun 30, 2001 at 04:49:38PM -0700, Michael A. Chase wrote:
>The precinstall version doesn't have the rule necessary to accept multiple
>categories for a package.  I think that is one of the desired features the
>upcoming version will provide.

Huh.  I forgot that Robert had added the multi-category capability.  And,
I asked for it.

I chose to use the same technique that I'd used previously and check in
the current state of Robert's parsing, from the trunk, into the branch.
So, there are some energetic stubs in the code, but the code for parsing
categories is the same in both branches.

>The interim version seems to have forgotten how to handle locally
>available source archives, but that should be acceptable pending the
>new setup.exe.  It handles source archives fine when installing from
>the net.

Thanks for noticing this.  I think this should be fixed now.  I had
erroneously eliminated a test for sources in scan2.

cgf

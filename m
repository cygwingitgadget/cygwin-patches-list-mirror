From: Jason Tishler <Jason.Tishler@dothill.com>
To: Norman Vine <nhv@cape.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Thu, 28 Jun 2001 10:16:00 -0000
Message-id: <20010628131633.F488@dothill.com>
References: <00aa01c0ff1b$44106960$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00364.html

Norman,

On Wed, Jun 27, 2001 at 11:10:13AM -0400, Norman Vine wrote:
> Christopher Faylor writes:
> >I bet it would improve even more if we replaced the VirtualQuery
> >in path.cc, too.
> 
> With Rob's new patch that does this, 
> there actually isn't very much difference
> 
> real    7m10.729s
> user    2m50.963s
> sys     1m11.721s

Using Cygwin CVS from this morning, with Rob's latest pthreads patch
(i.e., virtualquery.patch) as committed by Chris very early this morning
(or very, very late last night), I get the following with threads:

    real    4m11.221s
    user    2m8.634s
    sys     0m43.902s

versus the following without threads:

    real    2m16.416s
    user    1m27.465s
    sys     0m8.210s

FWIW, the above timings are for the full Python 2.1 regression test (sans
test_poll) running on Windows NT 4.0 SP5, PIII 500 MHz, and 256 MB RAM.

Unfortunately, the following additional regression tests fail with the
threaded version of Python:

    test___all__
    test_popen2
    test_socket
    test_sundry

See attached for details.  Are you getting the same or similar failures?

And finally, I'm still getting the same hangs that I previously reported 
during the Distutils part of the build.  The workaround was to use a
non-threaded version of Python:

    $ PYTHONPATH= /usr/bin/python ../setup.py build
    ...

Are you sure that your environment is a *stock* Python 2.1?

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com

From: Jason Tishler <Jason.Tishler@dothill.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: sys/stat.h constants patch
Date: Tue, 27 Mar 2001 19:24:00 -0000
Message-id: <20010327222942.A1918@dothill.com>
X-SW-Source: 2001-q1/msg00257.html

The attached patch "properly" initializes sys/stat.h constants such as
S_IXUSR.  I quote properly because I'm not sure what is the best way to
correct this problem.  I tried a couple of permutations and ended up
with this one.

Nevertheless, without this patch the interesting lines in
winsup/cygwin/lib/_cygwin_S_IEXEC.cc end up as follows after cpp:

    const unsigned _cygwin_S_IEXEC = _cygwin_S_IEXEC ;
    const unsigned _cygwin_S_IXUSR = _cygwin_S_IXUSR ;
    const unsigned _cygwin_S_IXGRP = _cygwin_S_IXGRP ;
    const unsigned _cygwin_S_IXOTH = _cygwin_S_IXOTH ;
    const unsigned _cygwin_X_OK = _cygwin_X_OK ;

instead of:

    extern const unsigned _cygwin_S_IEXEC = 0000100 ;
    extern const unsigned _cygwin_S_IXUSR = 0000100 ;
    extern const unsigned _cygwin_S_IXGRP = 0000010 ;
    extern const unsigned _cygwin_S_IXOTH = 0000001 ;
    extern const unsigned _cygwin_X_OK = 1 ;

Hence, the above constants are set to 0 instead of their expected values.

The attached small test program demonstrates the issue.  Built against
1.1.8-2, I get the following:

    $ j
    S_IXUSR = 64

But, when built against the 2001-03-25 snapshot, I get the following:

    $ j
    S_IXUSR = 0

BTW, this problem prevents PostgreSQL built against a Cygwin with this
issue from functioning properly.  postgres.exe declares that it *itself*
is an invalid executable even though it is running!

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: +1 (732) 264-8770 x235
Dot Hill Systems Corp.               Fax:   +1 (732) 264-8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com

From: Jason Tishler <Jason.Tishler@dothill.com>
To: Jon Ericson <Jonathan.L.Ericson@jpl.nasa.gov>
Cc: cygwin-patches@cygwin.com
Subject: Re: ispell package
Date: Wed, 28 Feb 2001 13:35:00 -0000
Message-id: <20010228163439.Y449@dothill.com>
References: <86ofvmjyvz.fsf@jon_ericson.jpl.nasa.gov>
X-SW-Source: 2001-q1/msg00135.html

Jon,

On Wed, Feb 28, 2001 at 09:12:00PM +0000, Jon Ericson wrote:
> Inspired by the recent call for contributors
> ( http://sources.redhat.com/ml/cygwin/2001-02/msg01512.html ), I
> contacted Pierre A. Humblet, who maintains a Cygwin binary of ispell:
> ftp://ftp.franken.de/pub/win32/develop/gnuwin32/cygwin/porters/Humblet_Pierre_A
> 
> He kindly gave me the go-ahead to contribute an "official" ispell
> package, but expressed the following:

Before you go too far, I would really recommend aspell/pspell over ispell
because they are *much* better.  I just switched a few weeks ago and I am
extremely happy.

For more info, check out the following:

    http://sourceforge.net/projects/aspell/
    http://sourceforge.net/projects/pspell/

Note that aspell/pspell build OOTB under Cygwin.  See attached for my
build recipes sans tar commands -- you may find them useful.

Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: +1 (732) 264-8770 x235
Dot Hill Systems Corp.               Fax:   +1 (732) 264-8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com

From: Jason Tishler <Jason.Tishler@dothill.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: unlink() patch (was Cygwin CVS breaks PostgreSQL drop table)
Date: Tue, 17 Jul 2001 19:12:00 -0000
Message-id: <20010717221042.A426@dothill.com>
X-SW-Source: 2001-q3/msg00012.html

On Fri, Jul 13, 2001 at 12:12:29PM -0400, Jason Tishler wrote:
> I will try to dig some more and devise a patch (if I can), but I wanted
> to at least give a heads up in the meantime.

The first attachment, utest.c, demonstrates the root cause of the problem:

    $ date > duda
    $ utest duda
    s = 0, errno = 0
    $ ls -l duda
    ls: duda: No such file or directory
    $ utest duda
    s = 0, errno = 0

After the following commit:

    http://www.cygwin.com/ml/cygwin-cvs/2001-q2/msg00276.html

Cygwin no longer correctly handles the case when the file passed to
unlink() does not exist -- unlink() incorrectly returns 0.

The second and third attachments are a patch and the corresponding
ChangeLog entry that fix this problem.

BTW, this bug caused PostgreSQL to spin while dropping tables because
as part of its clean up algorithm (which I do not fully grok), it would
continue to delete files foo, foo.1, foo.2, ... until unlink() returned
with an error.

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com

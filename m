From: Jason Tishler <Jason.Tishler@dothill.com>
To: Norman Vine <nhv@cape.com>
Cc: "'Python-Dev'" <python-dev@python.org>, cygwin-patches@cygwin.com
Subject: Re: Threaded Cygwin Python Import Problem
Date: Sat, 30 Jun 2001 08:20:00 -0000
Message-id: <20010630112019.B626@dothill.com>
References: <015601c10166$eb79bb00$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00388.html

Norman,

On Sat, Jun 30, 2001 at 09:16:48AM -0400, Norman Vine wrote:
> Jason Tishler
> >The one that I would like to address in this posting prevents a threaded
> >Cygwin Python from building the standard extension modules (without some
> >kind of intervention).  :,(  Specifically, the build would frequently
> >hang during the Distutils part when Cygwin Python is attempting to execvp
> >a gcc process.
> I was experiencing the same problems as Jason with Win2k sp1 and
> had used the same work-around successfully.
> < I believe Jason is working with NT 4.0 sp 5 >
> 
> Curiously after applying the Win2k sp2 I no longer need to do this
> and the original Python code works fine.
> 
> Leading me to believe that this may be but a symptom of a another
> Windows mystery.

After further reflection, I feel that I have found another race/deadlock
issue with the Cygwin's pthreads implementation.  If I'm correct, this
would explain why you experienced it intermittently with Windows 2000
SP1 and it is "gone" with SP2.  Probably SP2 slows down your machine so
much that the problem is not triggered. :,)

I am going to reconfigure --with-pydebug and set THREADDEBUG.  Hopefully,
the hang will still be reproducible under these conditions.  If so,
then I will attempt to produce a minimal C test case for Rob to use to
isolate and solve this problem.

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com

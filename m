From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jason Tishler" <Jason.Tishler@dothill.com>, <cygwin-patches@cygwin.com>
Cc: "Norman Vine" <nhv@cape.com>
Subject: RE: Threaded Cygwin Python Import Problem
Date: Mon, 09 Jul 2001 20:34:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF7A19@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q3/msg00008.html

> -----Original Message-----
> From: Jason Tishler [ mailto:Jason.Tishler@dothill.com ]
> Sent: Tuesday, July 10, 2001 7:13 AM
> To: cygwin-patches@cygwin.com
> Cc: Norman Vine
> Subject: Re: Threaded Cygwin Python Import Problem
> 
> 
> Rob,
> 
> [Note python-dev@python.org has been trimmed from the CC list.]
> 
> On Sat, Jun 30, 2001 at 11:20:19AM -0400, Jason Tishler wrote:
> > On Sat, Jun 30, 2001 at 09:16:48AM -0400, Norman Vine wrote:
> > > Jason Tishler
> > > >The one that I would like to address in this posting 
> prevents a threaded
> > > >Cygwin Python from building the standard extension 
> modules (without some
> > > >kind of intervention).  :,(  Specifically, the build 
> would frequently
> > > >hang during the Distutils part when Cygwin Python is 
> attempting to execvp
> > > >a gcc process.
> > > I was experiencing the same problems as Jason with Win2k sp1 and
> > > had used the same work-around successfully.
> > > < I believe Jason is working with NT 4.0 sp 5 >
> > > 
> > > Curiously after applying the Win2k sp2 I no longer need to do this
> > > and the original Python code works fine.
> > > 
> > > Leading me to believe that this may be but a symptom of a another
> > > Windows mystery.
> > 
> > After further reflection, I feel that I have found another 
> race/deadlock
> > issue with the Cygwin's pthreads implementation.  If I'm 
> correct, this
> > would explain why you experienced it intermittently with 
> Windows 2000
> > SP1 and it is "gone" with SP2.  Probably SP2 slows down 
> your machine so
> > much that the problem is not triggered. :,)
> > 
> > I am going to reconfigure --with-pydebug and set 
> THREADDEBUG.  Hopefully,
> > the hang will still be reproducible under these conditions.  If so,
> > then I will attempt to produce a minimal C test case for 
> Rob to use to
> > isolate and solve this problem.
> 
> Although I have not arrived at a minimal C test case, I have attached
> two gdb sessions that exhibit the hang.  The first one is produced by:

In gdb, the BadWritePtr function generates a illegal address exception -
deliberately. This is to allow developers to tell when bad address's are
being passed around. As already discussed the cygwin pthreads code
actually expects that to happen if nonsense initial values are passed to
the threads code. IIRC it does check for NULL separately, so memseting
or bzeroing your pthread_t variables should avoid the exception. It's
safe to cont after that exception (a bt may show the test function
check_valid_pointer or verifyable_object_isvalid).

Your test cases don't look like that to me  though :}.
 
>     python test.py

gdb.out: the event handle is clearly wrong. Can you include the output
of print *this ? and list (so I know what the lines actually are :])>
 
> and the second by:
> 
>     ./python test.py

Ditto for the above... but - the handle looks like it may be valid to
me. From the bt of both outputs I suspect that it's the access mutex to
the cond variable that is causing the grief. I'll glance at the code
tonight.

Can you give me the following as well?
for pthread_cond::Signal 
list
print *this

> I find it curious that the hang occurs in different places 
> dependent on
> how python is invoked -- via PATH or full pathname.  I'm also 
> at a lose
> as to why sometimes I get "Cannot access memory at address 
> ..." errors.
> Can anyone explain what is going on?

If the "cannot access memory at address" error is a windows popup, it's
an exception unhandled by cygwin for some reason. If it's in gdb, see my
description above - it _may_ be the normal
first-access-test-with-random-data for BadWritePointer.
 
> Note that the hang does not occur with test2.py which does 
> not fork/exec.
> This seems to imply that the problem is tickled only in child 
> processes.

Quite possibly. I don't claim to grok fork properly, but I'm willing to
try :}.
 
> Is the information provided in this email useful in helping you find
> the problem?  If not, what else can I provide to assist you?

Just what I've asked for. I'll have a look and see if anything obvious
appears, otherwise it'll be back to minimising the variables.
 
Rob

> Alternatively, you can use the attached patch to build a 
> threaded Cygwin
> Python to try to reproduce the problem yourself.  Once built, you need
> to reverse the patch to exhibit the problem.  The procedure 
> is as follows:
> 
>     $ wget -P /tmp -nd 
ftp://mirrors.rcn.net/mirrors/sources.redhat.com/cygwin/contrib/python/p
ython-2.1-1-src.tar.gz
    $ # save os.py patch to /tmp
    $ # save test.py attachment to /tmp
    $ tar -xzf /tmp/python-2.1-1-src.tar.gz
    $ cd Python-2.1/Lib
    $ patch </tmp/os.py.patch
    $ cd ..
    $ configure
    $ make
    $ patch -R </tmp/os.py.patch
    $ ./python /tmp/test.py

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com

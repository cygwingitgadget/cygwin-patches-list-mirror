From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: Norman Vine <nhv@cape.com>
Subject: Re: Threaded Cygwin Python Import Problem
Date: Mon, 09 Jul 2001 14:30:00 -0000
Message-id: <20010709173039.A22329@redhat.com>
References: <20010630112019.B626@dothill.com> <20010709171242.D434@dothill.com>
X-SW-Source: 2001-q3/msg00006.html

I don't see a cygwin patch in this message...  Perhaps you meant
to use another mailing list.

cgf

On Mon, Jul 09, 2001 at 05:12:42PM -0400, Jason Tishler wrote:
>Rob,
>
>[Note python-dev@python.org has been trimmed from the CC list.]
>
>On Sat, Jun 30, 2001 at 11:20:19AM -0400, Jason Tishler wrote:
>> On Sat, Jun 30, 2001 at 09:16:48AM -0400, Norman Vine wrote:
>> > Jason Tishler
>> > >The one that I would like to address in this posting prevents a threaded
>> > >Cygwin Python from building the standard extension modules (without some
>> > >kind of intervention).  :,(  Specifically, the build would frequently
>> > >hang during the Distutils part when Cygwin Python is attempting to execvp
>> > >a gcc process.
>> > I was experiencing the same problems as Jason with Win2k sp1 and
>> > had used the same work-around successfully.
>> > < I believe Jason is working with NT 4.0 sp 5 >
>> > 
>> > Curiously after applying the Win2k sp2 I no longer need to do this
>> > and the original Python code works fine.
>> > 
>> > Leading me to believe that this may be but a symptom of a another
>> > Windows mystery.
>> 
>> After further reflection, I feel that I have found another race/deadlock
>> issue with the Cygwin's pthreads implementation.  If I'm correct, this
>> would explain why you experienced it intermittently with Windows 2000
>> SP1 and it is "gone" with SP2.  Probably SP2 slows down your machine so
>> much that the problem is not triggered. :,)
>> 
>> I am going to reconfigure --with-pydebug and set THREADDEBUG.  Hopefully,
>> the hang will still be reproducible under these conditions.  If so,
>> then I will attempt to produce a minimal C test case for Rob to use to
>> isolate and solve this problem.
>
>Although I have not arrived at a minimal C test case, I have attached
>two gdb sessions that exhibit the hang.  The first one is produced by:
>
>    python test.py
>
>and the second by:
>
>    ./python test.py
>
>I find it curious that the hang occurs in different places dependent on
>how python is invoked -- via PATH or full pathname.  I'm also at a lose
>as to why sometimes I get "Cannot access memory at address ..." errors.
>Can anyone explain what is going on?
>
>Note that the hang does not occur with test2.py which does not fork/exec.
>This seems to imply that the problem is tickled only in child processes.
>
>Is the information provided in this email useful in helping you find
>the problem?  If not, what else can I provide to assist you?
>
>Alternatively, you can use the attached patch to build a threaded Cygwin
>Python to try to reproduce the problem yourself.  Once built, you need
>to reverse the patch to exhibit the problem.  The procedure is as follows:
>
>    $ wget -P /tmp -nd ftp://mirrors.rcn.net/mirrors/sources.redhat.com/cygwin/contrib/python/python-2.1-1-src.tar.gz
>    $ # save os.py patch to /tmp
>    $ # save test.py attachment to /tmp
>    $ tar -xzf /tmp/python-2.1-1-src.tar.gz
>    $ cd Python-2.1/Lib
>    $ patch </tmp/os.py.patch
>    $ cd ..
>    $ configure
>    $ make
>    $ patch -R </tmp/os.py.patch
>    $ ./python /tmp/test.py
>
>Thanks,
>Jason
>
>-- 
>Jason Tishler
>Director, Software Engineering       Phone: 732.264.8770 x235
>Dot Hill Systems Corp.               Fax:   732.264.8798
>82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
>Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com

>(gdb) bt
>#0  0x77f6829b in ?? ()
>#1  0x77f04f41 in ?? ()
>#2  0x6105f36a in pthread_mutex::Lock (this=0xa010a58)
>    at ../../../../src/winsup/cygwin/thread.cc:644
>#3  0x61060e26 in __pthread_mutex_lock (mutex=0xa012230)
>    at ../../../../src/winsup/cygwin/thread.cc:1917
>#4  0x6103b3ae in pthread_mutex_lock (mutex=0xa012230)
>    at ../../../../src/winsup/cygwin/pthread.cc:240
>#5  0x61d99e37 in PyThread_acquire_lock (lock=0xa012228, waitflag=0)
>    at ../Python/thread_pthread.h:298
>#6  0x61d8cebd in lock_import () at ../Python/import.c:159
>..
>(gdb) f 2
>#2  0x6105f36a in pthread_mutex::Lock (this=0xa010a58)
>    at ../../../../src/winsup/cygwin/thread.cc:644
>644       return WaitForSingleObject (win32_obj_id, INFINITE);
>Current language:  auto; currently c++
>(gdb) p win32_obj_id
>Cannot access memory at address 0x6

>(gdb) bt
>#0  0x77f6829b in ?? ()
>#1  0x77f04f41 in ?? ()
>#2  0x6105f36a in pthread_mutex::Lock (this=0xa011108)
>    at ../../../../src/winsup/cygwin/thread.cc:644
>#3  0x61060e26 in __pthread_mutex_lock (mutex=0xa0151b8)
>    at ../../../../src/winsup/cygwin/thread.cc:1917
>#4  0x6103b3ae in pthread_mutex_lock (mutex=0xa0151b8)
>    at ../../../../src/winsup/cygwin/pthread.cc:240
>#5  0x6105ed17 in pthread_cond::Signal (this=0xa0151a8)
>    at ../../../../src/winsup/cygwin/thread.cc:443
>#6  0x61060560 in __pthread_cond_signal (cond=0xa010a5c)
>    at ../../../../src/winsup/cygwin/thread.cc:1628
>#7  0x6103b58e in pthread_cond_signal (cond=0xa010a5c)
>    at ../../../../src/winsup/cygwin/pthread.cc:355
>#8  0x61d9a02b in PyThread_release_lock (lock=0xa010a58)
>    at ../Python/thread_pthread.h:344
>#9  0x61d8cf78 in unlock_import () at ../Python/import.c:179
>(gdb) f 2
>#2  0x6105f36a in pthread_mutex::Lock (this=0xa011108)
>    at ../../../../src/winsup/cygwin/thread.cc:644
>644       return WaitForSingleObject (win32_obj_id, INFINITE);
>Current language:  auto; currently c++
>(gdb) p win32_obj_id
>$1 = 0xa028b18
>(gdb) x win32_obj_id
>0xa028b18:      0x0a080bc4

>import os
>
>cmd = ['ls', '-l']
>
>pid = os.fork()
>
>if pid == 0:
>	print 'child execvp-ing'
>	os.execvp(cmd[0], cmd)
>else:
>	(pid, status) = os.waitpid(pid, 0)
>	print 'status =', status
>	print 'parent done'

>import os
>
>cmd = ['ls', '-l']
>
>os.execvp(cmd[0], cmd)

>--- os.py.orig	Thu Jun 28 16:14:28 2001
>+++ os.py	Thu Jun 28 16:30:12 2001
>@@ -329,8 +329,9 @@ def _execvpe(file, args, env=None):
>             try: unlink('/_#.# ## #.#')
>             except error, _notfound: pass
>         else:
>-            import tempfile
>-            t = tempfile.mktemp()
>+            #import tempfile
>+            #t = tempfile.mktemp()
>+            t = '/mnt/c/TEMP/@279.3'
>             # Exec a file that is guaranteed not to exist
>             try: execv(t, ('blah',))
>             except error, _notfound: pass


-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/

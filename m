From: Jason Tishler <Jason.Tishler@dothill.com>
To: Norman Vine <nhv@cape.com>
Cc: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Thu, 28 Jun 2001 11:41:00 -0000
Message-id: <20010628144115.J488@dothill.com>
References: <00f301c0fffa$c7baf840$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00365.html

Norman,

On Thu, Jun 28, 2001 at 01:50:11PM -0400, Norman Vine wrote:
> Hmm I haven't tried timing without threads
> but you are quite a bit faster then I am.
> 
> Maybe ntsec makes that much difference
> I am running a PIII 733 256meg win2k 

You remembered correctly -- I am *not* running with ntsec.

> I am including the poll test with the line 65 commented out
> #    poll_unit_tests()

I see that you have further isolated where test_poll is hanging.  Can
you debug why something in poll_unit_tests() is hanging?
> >
> >Unfortunately, the following additional regression tests fail with the
> >threaded version of Python:

Actually, I realized that my workaround for the build hanging produced a
"bad" Python distribution.  By "bad," I mean that the standard extension
modules were linked against a non-threaded libpython2.1.dll.a.  This
caused amongst other things to prevent _socket.dll from linking
successfully (which I didn't notice at first).

My new workaround was to convert the output from my non-threaded standard
extension module build into a shell script that I can use to build the
threaded version.  Now I only get two additional failures versus the
non-threaded version:

    test_popen2
    test_socket

> >    test___all__
> this does NOT report failure

My results are now the same as the above.

> >    test_popen2
> this does but runs when tested by itself

My results are now the same as the above.

> >    test_socket
> same as popen2

My results are now the same as the above.

> >    test_sundry
> fails with no module named bsddb

I no longer get test_sundry failures -- it is skipped as expected due to
the missing bsddb module.

> >See attached for details.  Are you getting the same or similar 
> >failures?
> 
> Some are the same but see attached

Why did you send me cyg_py_nhv.tgz:

dr-xr-xr-x admins/admins     0 2001-06-28 13:36:29 plat-cygwin_nt-5.01/
-rw-r--r-- nhv/admins     8806 2001-06-23 07:58:40 plat-cygwin_nt-5.01/FCNTL.py
..

Did you mean to attach your regression test results instead?  Anyway, do
your test_popen2 and test_socket fail as follows:

D:\home\jt\src\Python-2.1\threads\python.exe: *** couldn't release memory 0x1A02C000(5074944) for 'D:\home\jt\src\Python-2.1\threads\build\lib.cygwin_nt-4.0-1.3.3-i686-2.1\gdbm.dll' alignment, Win32 error 487
 
      0 [main] python 293 sync_with_child: child 452(0x2B8) died before initialization with status code 0x1
    227 [main] python 293 sync_with_child: *** child state child loading dlls
test test_popen2 crashed -- exceptions.OSError: [Errno 11] Resource temporarily unavailable


> I bet there is a NT - Win2k difference responsible for your hanging

I guess this is possible, but I would not expect such a difference.

> FWIW - are you using the newest cygwin make ??

This is not relevant since make is out of the picture while the shared
extension modules are being built.

Thanks,
Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com

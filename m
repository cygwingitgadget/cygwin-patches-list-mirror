From: "Norman Vine" <nhv@cape.com>
To: <Jason.Tishler@dothill.com>
Cc: <cygwin-patches@sources.redhat.com>
Subject: FW: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Thu, 28 Jun 2001 12:02:00 -0000
Message-id: <010501c10005$ac2ab100$a300a8c0@nhv>
X-SW-Source: 2001-q2/msg00366.html

Jason wrote:

>I see that you have further isolated where test_poll is hanging.  Can
>you debug why something in poll_unit_tests() is hanging?

Not yet :-(

>Why did you send me cyg_py_nhv.tgz:

I have added this directory and these files to the stock 2-1 distribution
and you wanted to know if I was running a 'stock' system

>Anyway, do
>your test_popen2 and test_socket fail as follows:
>
>D:\home\jt\src\Python-2.1\threads\python.exe: *** couldn't
>release memory 0x1A02C000(5074944) for
>'D:\home\jt\src\Python-2.1\threads\build\lib.cygwin_nt-4.0-1.3.
>3-i686-2.1\gdbm.dll' alignment, Win32 error 487
>
>      0 [main] python 293 sync_with_child: child 452(0x2B8)
>died before initialization with status code 0x1
>    227 [main] python 293 sync_with_child: *** child state
>child loading dlls
>test test_popen2 crashed -- exceptions.OSError: [Errno 11]
>Resource temporarily unavailable

Yes
But they succeed for me when tested individually
Do they for you ??

./python Lib/test/test_popen2.py
./python Lib/test/test_socket.py

Months ago Chris < Rob > mentioned that this could be do to some
inner workings in Cygwin.
FWIW -- I think that this is due to the 'funky' way the individual tests are
'exec()'d' by test_all().
I can do some further research but not today,

>> I bet there is a NT - Win2k difference responsible for your hanging
>
>I guess this is possible, but I would not expect such a difference.
>
>> FWIW - are you using the newest cygwin make ??
>
>This is not relevant since make is out of the picture while the shared
>extension modules are being built.

Not completely in that make is still the controlling process here
ie python setup.py is launched by make, but you are right it probably
won't make any difference in that this also worked for me with the earlier
make.

Cheers

Norman


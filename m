From: "Norman Vine" <nhv@cape.com>
To: "'Jason Tishler'" <Jason.Tishler@dothill.com>, "'Python-Dev'" <python-dev@python.org>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: Threaded Cygwin Python Import Problem
Date: Sat, 30 Jun 2001 06:12:00 -0000
Message-id: <015601c10166$eb79bb00$a300a8c0@nhv>
References: <20010628171715.P488@dothill.com>
X-SW-Source: 2001-q2/msg00387.html

Jason Tishler
>
>Thanks to Rob Collins (implementer) and Greg Smith (profiler), Cygwin now
>provides enough pthreads support so that Cygwin Python builds OOTB *and*
>functions reasonably well even with threads enabled.  Unfortunately,
>there are still a few issues that need to be resolved.
>
>The one that I would like to address in this posting prevents a threaded
>Cygwin Python from building the standard extension modules (without some
>kind of intervention).  :,(  Specifically, the build would frequently
>hang during the Distutils part when Cygwin Python is attempting to execvp
>a gcc process.
>
>See the first attachment, test.py, for a minimal Python script that
>exhibits the hang.  See the second attachment, test.c, for a rewrite
>of test.py in C.  Since test.c did not hang, I was able to conclude that
>this was not just a straight Cygwin problem.
>
>Further tracing uncovered that the hang occurs in _execvpe() (in os.py),
>when the child tries to import tempfile.  If I apply the third >attachment,
>os.py.patch, then the hang is avoided.  Hence, it appears that importing a
>module (or specifically the tempfile module) in a threaded Cygwin Python
>child cause a hang.
>
>I saw the following comment in _execvpe():
>
>    #  Process handling (fork, wait) under BeOS (up to 5.0)
>    #  doesn't interoperate reliably with the thread interlocking
>    #  that happens during an import.  The actual error we need
>    #  is the same on BeOS for posix.open() et al., ENOENT.
>
>The above makes me think that possibly Cygwin is having a
>similar problem.
>
>Can anyone offer suggestions on how to further debug this problem?

I was experiencing the same problems as Jason with Win2k sp1 and
had used the same work-around successfully.
< I believe Jason is working with NT 4.0 sp 5 >

Curiously after applying the Win2k sp2 I no longer need to do this
and the original Python code works fine.

Leading me to believe that this may be but a symptom of a another
Windows mystery.

Regards

Norman Vine

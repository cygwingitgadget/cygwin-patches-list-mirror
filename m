From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandlers codebase, magic dirs, etc.
Date: Sun, 30 Sep 2001 13:23:00 -0000
Message-id: <20010930162427.A1004@redhat.com>
References: <007501c149c1$867d29f0$01000001@lifelesswks> <NFBBLOMHALONCDMPGBLFCENKCCAA.info@rlsystems.net>
X-SW-Source: 2001-q3/msg00249.html

On Sun, Sep 30, 2001 at 10:02:40PM +0200, Ronald Landheer wrote:
>NB: Just a small question: how does one go about debugging the Cygwin 
>DLL? I mean: ye can't have two of them at the same time, so I could just 
>put one aside in a gzip, but bugs in things like this might leave gdb 
>broken as well. I can brew up a whole bunch of testcases and see which 
>ones fail, but it would be nice to be able to step through the source.. 
>Is it possible?

Check out the how-to-debug-cygwin.txt file in the winsup/cygwin directory.

cgf

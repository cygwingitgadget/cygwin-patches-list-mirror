From: Corinna Vinschen <corinna@vinschen.de>
To: Chris Faylor <cgf@cygnus.com>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>, Mumit Khan <khan@NanoTech.Wisc.EDU>
Subject: Re: cross compiling patches
Date: Fri, 31 Mar 2000 10:58:00 -0000
Message-id: <38E4F650.7AE6F8EE@vinschen.de>
References: <200003300046.SAA27482@hp2.xraylith.wisc.edu> <38E30C2A.7B962DE8@vinschen.de> <38E3D5F2.15B2E3A0@vinschen.de> <20000330192529.A29634@cygnus.com>
X-SW-Source: 2000-q1/msg00029.html

Chris Faylor wrote:
> >- In winsup/cygwin/Makefile.in `cygrun.exe' has to be compiled with
> >  $(COMPILE_CC) because the linker stage results in the error
> >  `-lcygwin not found.'
> 
> Are you saying that the change I made to winsup/cygwin/Makefile.in
> doesn't solve this?  cygrun.o *is* being compiled via COMPILE_CC.

I see. It's a bit complicated: My patch was a mess but a change is
needed, actually. The missing part is the link path for the cygwin
directory itself. xgcc is grumbling

	`-lcygwin' not found.

cygrun.exe : cygrun.o $(DLL_IMPORTS) $(w32api_lib)/libuser32.a \
             $(w32api_lib)/libshell32.a
        $(CC) -o $@ -L$(w32api_lib) -L$(objdir) ${word 1,$^}
                                    ^^^^^^^^^^^
                                    THAT is the missing part.

I don't insist to make the patch _this_ way but the path is needed,
though.

Corinna

From: Mumit Khan <khan@NanoTech.Wisc.EDU>
To: Chris Faylor <cgf@cygnus.com>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: New warnings building cygwin: AF_INET6 redefined 
Date: Sat, 13 May 2000 17:39:00 -0000
Message-id: <200005140039.TAA29122@hp2.xraylith.wisc.edu>
References: <20000513183024.A22491@cygnus.com>
X-SW-Source: 2000-q2/msg00058.html

Chris Faylor <cgf@cygnus.com> writes:
> i686-pc-cygwin-gcc -c -g -O2 -o ./hinfo.o hinfo.cc
> In file included from /cygnus/src/sourceware/winsup/w32api/include/windows.h:
> 123,
>                  from /cygnus/src/sourceware/winsup/cygwin/winsup.h:53,
>                  from /cygnus/src/sourceware/winsup/cygwin/hinfo.cc:22:
> /cygnus/src/sourceware/winsup/w32api/include/winsock.h:308: warning: `AF_INET
> 6' redefined
> /cygnus/src/sourceware/winsup/cygwin/include/cygwin/socket.h:69: warning: thi
> s is the location of the previous definition
> 
> Is this due to your recent change, Mumit?
> 

My fault -- forgot that winsock2 specs already define AF_INET6. I'll sync 
the winsock and winsup that later in the evening. Till then it's harmless, 
even if annoying.

Mumit

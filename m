From: Chris Faylor <cgf@cygnus.com>
To: Mumit Khan <khan@xraylith.wisc.EDU>, cygwin-patches@sourceware.cygnus.com
Subject: New warnings building cygwin: AF_INET6 redefined
Date: Sat, 13 May 2000 15:30:00 -0000
Message-id: <20000513183024.A22491@cygnus.com>
X-SW-Source: 2000-q2/msg00057.html

i686-pc-cygwin-gcc -c -g -O2 -o ./hinfo.o hinfo.cc
In file included from /cygnus/src/sourceware/winsup/w32api/include/windows.h:123,
                 from /cygnus/src/sourceware/winsup/cygwin/winsup.h:53,
                 from /cygnus/src/sourceware/winsup/cygwin/hinfo.cc:22:
/cygnus/src/sourceware/winsup/w32api/include/winsock.h:308: warning: `AF_INET6' redefined
/cygnus/src/sourceware/winsup/cygwin/include/cygwin/socket.h:69: warning: this is the location of the previous definition

Is this due to your recent change, Mumit?

cgf

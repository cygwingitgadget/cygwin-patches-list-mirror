From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin half of pthread update
Date: Thu, 12 Apr 2001 15:52:00 -0000
Message-id: <20010412185303.B20673@redhat.com>
References: <03f001c0c2ed$3b89acd0$0200a8c0@lifelesswks> <20010411232520.C32524@redhat.com> <05df01c0c305$d4bef0f0$0200a8c0@lifelesswks> <20010412113539.A5879@redhat.com> <00d201c0c3a2$5fcc0ba0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00048.html

On Fri, Apr 13, 2001 at 08:46:06AM +1000, Robert Collins wrote:
>I checked it in as
>cvs -z9 ci -F pthread.ChangeLog configure.in cygwin.din pthread.cc
>sched.cc thread.cc thread.h include/pthread.h include/sched.h
>include/cygwin/types.h
>
>where pthread.ChangeLog was the updated version of the changelog entry I
>had emailed out to the patches list.
>
>The -F should have inserted the ChangeLog entry as the commit message.
>
>Or do you manually update the ChangeLog file?

The ChangeLog file is updated by hand, yes.  There is nothing special
about it at all.

cgf

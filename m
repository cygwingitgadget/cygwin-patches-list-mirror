From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: Cygwin half of pthread update
Date: Thu, 12 Apr 2001 15:46:00 -0000
Message-id: <00d201c0c3a2$5fcc0ba0$0200a8c0@lifelesswks>
References: <03f001c0c2ed$3b89acd0$0200a8c0@lifelesswks> <20010411232520.C32524@redhat.com> <05df01c0c305$d4bef0f0$0200a8c0@lifelesswks> <20010412113539.A5879@redhat.com>
X-SW-Source: 2001-q2/msg00045.html

I checked it in as
cvs -z9 ci -F pthread.ChangeLog configure.in cygwin.din pthread.cc
sched.cc thread.cc thread.h include/pthread.h include/sched.h
include/cygwin/types.h

where pthread.ChangeLog was the updated version of the changelog entry I
had emailed out to the patches list.

The -F should have inserted the ChangeLog entry as the commit message.

Or do you manually update the ChangeLog file?

Rob

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, April 13, 2001 1:35 AM
Subject: Re: Cygwin half of pthread update


> On Thu, Apr 12, 2001 at 02:05:30PM +1000, Robert Collins wrote:
> >Committed.
>
> What happened to the ChangeLog?  You shouldn't check in stuff without
> a ChangeLog entry.
>
> cgf
>

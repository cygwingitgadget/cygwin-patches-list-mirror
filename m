From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin half of pthread update
Date: Thu, 12 Apr 2001 09:51:00 -0000
Message-id: <20010412125123.A14738@redhat.com>
References: <03f001c0c2ed$3b89acd0$0200a8c0@lifelesswks> <20010411232520.C32524@redhat.com> <05df01c0c305$d4bef0f0$0200a8c0@lifelesswks> <20010412113539.A5879@redhat.com> <20010412180758.A30816@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00042.html

On Thu, Apr 12, 2001 at 06:07:58PM +0200, Corinna Vinschen wrote:
>On Thu, Apr 12, 2001 at 11:35:39AM -0400, Christopher Faylor wrote:
>> On Thu, Apr 12, 2001 at 02:05:30PM +1000, Robert Collins wrote:
>> >Committed.
>> 
>> What happened to the ChangeLog?  You shouldn't check in stuff without
>> a ChangeLog entry.
>
>Why is there a symbol `mkfifo' in cygwin.din but nowhere is the function?
>I can't link the dll anymore. Sure I can but I have to patch cygwin.din
>then.

We agreed a while ago that mkfifo would be a stub.  I assume that Robert
probably has a mkfifo stub in his personal sandbox.

I've added a stub to syscalls.cc and cygwin now should compile ok.

I also added a ChangeLog entry and regenerated configure from configure.in.

cgf

From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Fri, 04 May 2001 08:30:00 -0000
Message-id: <20010504112909.A17458@redhat.com>
References: <20010503093508.13491.qmail@sourceware.cygnus.com> <132246850181.20010503140017@logos-m.ru> <20010503130608.B24200@cygbert.vinschen.de> <20010503131328.C24200@cygbert.vinschen.de> <9258490099.20010503171417@logos-m.ru> <20010503110333.A4579@redhat.com> <20010503110454.B4579@redhat.com> <177268099516.20010503195427@logos-m.ru> <20010503131150.C4579@redhat.com> <96322539597.20010504110148@logos-m.ru>
X-SW-Source: 2001-q2/msg00191.html

On Fri, May 04, 2001 at 11:01:48AM +0400, egor duda wrote:
>Hi!
>
>Thursday, 03 May, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>>>>>>2001-05-03  Egor Duda  <deo@logos-m.ru>
>>>>>>
>>>>>>        * fhandler_socket.cc (set_connect_secret): Use /dev/random to
>>>>>>        generate secret cookie.
>>>>>
>>>>>What happens to the buf that you allocate here?  It looks like a memory
>>>>>leak.
>>>
>>>CF> Just to be a little clearer:  It looks like a memory leak in execed proceses.
>>>CF> ccalloced memory is copied to execed processes.
>>>
>>>ok. take 2.
>
>CF> That looks better but I would prefer malloc/free rather than
>CF> malloc/delete.
>
>malloc/new/delete, not malloc/delete. delete assures that destructor
>(if any) is called for entropy_source.

Ok.  You're right.

This looks ok.  Please check it in.

cgf

From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin build SEGV
Date: Wed, 05 Sep 2001 13:57:00 -0000
Message-id: <20010905225702.D18845@cygbert.vinschen.de>
References: <3B950F1E.80008@ece.gatech.edu> <114122083636.20010904223654@logos-m.ru> <3B958C2F.6040003@ece.gatech.edu> <20010904225434.A12398@redhat.com> <3B9598F0.8050008@ece.gatech.edu> <20010904234003.A13012@redhat.com> <20010905000529.A13237@redhat.com> <3B95AA46.5090000@ece.gatech.edu> <20010905011923.A17984@redhat.com> <8425103266.20010906002344@logos-m.ru>
X-SW-Source: 2001-q3/msg00105.html

On Thu, Sep 06, 2001 at 12:23:44AM +0400, egor duda wrote:
> Hi!
> 
> Wednesday, 05 September, 2001 Christopher Faylor cgf@redhat.com wrote:
> 
> ok, i've reproduced something similar and i believe i know the reason.
> in my case set_nt_attribute is called with alloca()ed buffer of size
> 256, but actual security descriptor is 268 bytes long. Bang. Stack
> corrupted. This is a workaround, though i think alloc_sd should check
> buffer size, but i cannot produce a patch for this right now.
> hopefully, 4k is enough for any sd. And yes, i think it's a
> show-stopper.

Gosh! I was pretty sure that 256 is always enough in these cases.
In my own tests I got always _168_ byte SDs. Am I assuming right
that bigger SDs are caused by propagating additional user rights
from the parent dir?

Since other function are using 4K SD buffers as well I don't
think it's useful to develop something new here for now. The
4K should be enough for a while. I will keep that problem in
mind, though.

Thanks for tracking that down. Go ahead and check it in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin build SEGV  -- checked in, but...
Date: Wed, 05 Sep 2001 20:40:00 -0000
Message-id: <20010905234033.A10849@redhat.com>
References: <114122083636.20010904223654@logos-m.ru> <3B958C2F.6040003@ece.gatech.edu> <20010904225434.A12398@redhat.com> <3B9598F0.8050008@ece.gatech.edu> <20010904234003.A13012@redhat.com> <20010905000529.A13237@redhat.com> <3B95AA46.5090000@ece.gatech.edu> <20010905011923.A17984@redhat.com> <8425103266.20010906002344@logos-m.ru> <20010905225702.D18845@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00106.html

On Wed, Sep 05, 2001 at 10:57:02PM +0200, Corinna Vinschen wrote:
>Thanks for tracking that down. Go ahead and check it in.

I did this in the hopes that I could release cygwin 1.3.3 tonight.

Alas, I found a show stopper with ttys.  Try running vim in rxvt
or under bash when CYGWIN=tty.  It don't work well.

cgf

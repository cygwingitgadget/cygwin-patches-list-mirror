From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin/newlib types patchs
Date: Wed, 21 Mar 2001 14:30:00 -0000
Message-id: <20010321173020.F9775@redhat.com>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com> <000b01c0b24c$43e45530$0200a8c0@lifelesswks> <20010321170610.C9775@redhat.com> <026301c0b255$8982d130$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00231.html

On Thu, Mar 22, 2001 at 09:23:19AM +1100, Robert Collins wrote:
>On the technical side the newlib maintainers are facing the same problem
>I did with pthreads (Changing at this date may break ABI and or existing
>#if code. Secondly they may have users who have used the fact that the
>userland includes allowed access to the internal elements of the *_t
>types. (Which is a bad thing). I understand newlib exists because
>proprietary software can be linked to it when it's sold under the second
>licence... so the maintainers may well have contractual issues crop up
>if they start fixing these things up.

I think that all of the pthreads stuff was added by external contributors,
actually.

Would you mind raising this issue on the newlib mailing list?  If no one
seems interested then we'll pursue a cygwin-only solution.

cgf

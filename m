From: Christopher Faylor <cgf@redhat.com>
To: cygwin-developers@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: hierarchy in setup (category stuff)
Date: Fri, 29 Jun 2001 20:14:00 -0000
Message-id: <20010629231541.A12500@redhat.com>
References: <20010629172912.A8991@redhat.com> <032001c100fe$d62310c0$806410ac@local> <20010629205735.K9607@redhat.com> <034701c10106$34f6b6e0$806410ac@local> <036501c10108$b55383c0$806410ac@local> <20010629221309.A11334@redhat.com> <038301c1010a$bab7e840$806410ac@local> <039201c1010b$856f0c80$806410ac@local> <20010629223227.C11334@redhat.com> <03cb01c1010e$6d809dc0$806410ac@local>
X-SW-Source: 2001-q2/msg00382.html

On Sat, Jun 30, 2001 at 12:43:20PM +1000, Robert Collins wrote:
>I think this gets them all. I thought I'd not trashed Michael's whate space
>changes - although where code moved between functions, they would have been
>lost regardless.
>
>I'm happy if rolling back is easier for you, but I suspect that its the same
>effort either way.

This wasn't all of them either.  Some of my changes affected your new code so
there was some hand-applying necessary.

I have checked in something that seems to work.

I'm still not completely satisfied with the Skip/Keep stuff, though.
Your code was assuming that you could just set Skip and that was ok but
my changes made Skip an invalid state if the package was installed.  So,
"Keep" is appropriate in those cases.

I think that I got that working again but I don't like the way that I did it.

I think I have to sleep on this.

cgf

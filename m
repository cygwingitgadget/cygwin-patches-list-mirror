From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: pthreads works, sorta
Date: Wed, 27 Jun 2001 07:07:00 -0000
Message-id: <00c701c0ff12$94c35f60$806410ac@local>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F09E@itdomain002.itdomain.net.au> <20010627012932.I19058@redhat.com> <20010627013502.K19058@redhat.com> <008201c0ff0d$8fe3c2a0$806410ac@local> <009701c0ff0e$4d796400$806410ac@local>
X-SW-Source: 2001-q2/msg00352.html

Theres a problem with the path.cc code. I'm tracking it down :[.

I suspect gcc optimisation at the moment.

Rob

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Robert Collins" <robert.collins@itdomain.com.au>; <cygwin@cygwin.com>;
<cygwin-patches@cygwin.com>
Sent: Wednesday, June 27, 2001 11:37 PM
Subject: Re: pthreads works, sorta


> The last patch was bad - sorry! (path.cc had a copy-n-pasto).
>
> Rob
> ----- Original Message -----
> From: "Robert Collins" <robert.collins@itdomain.com.au>
> To: <cygwin@cygwin.com>; <cygwin-patches@cygwin.com>
> Sent: Wednesday, June 27, 2001 11:32 PM
> Subject: Re: pthreads works, sorta
>
>
> > changelog:
> >
> > Wed Jun 27 23:30:00 2001  Robert Collins <rbtcollins@hotmail.com>
> >
> >     * path.cc (check_null_empty_path): Change from VirtualQuery to
> > IsBadWritePtr.
> >     * resource.cc (getrlimit): Ditto.
> >     (setrlimit): Ditto.
> >     * thread.cc (check_valid_pointer): Ditto.
> >
> >
> > What about the other instances of virtualQuery? Or are the appropriate..
> >
> > Rob (Your humble delegate).
> >
> >
> >
> > ----- Original Message -----
> > From: "Christopher Faylor" <cgf@redhat.com>
> > To: <cygwin@cygwin.com>
> > Sent: Wednesday, June 27, 2001 3:35 PM
> > Subject: Re: pthreads works, sorta
> >
> >
> > > On Wed, Jun 27, 2001 at 01:29:32AM -0400, Christopher Faylor wrote:
> > > >On Wed, Jun 27, 2001 at 01:10:35PM +1000, Robert Collins wrote:
> > > >>> -----Original Message-----
> > > >>> From: Greg Smith [ mailto:gsmith@nc.rr.com ]
> > > >>
> > > >>>
> > > >>> More experimenting with my home computer, dual pIII 850:
> > > >>>
> > > >>> 1. 117  157 328
> > > >>> 2. 822 1527 ---
> > > >>> 3. 194  240 453
> > > >>> 4. 169  181 516
> > > >>>
> > > >>As usual, I write a missive, then solve the puzzle.
> > > >>
> > > >>try this:
> > > >>
> > > >>
> > > >>int __stdcall
> > > >>check_valid_pointer (void *pointer)
> > > >>{
> > > >>  if (!pointer || IsBadWritePtr(pointer, sizeof
(verifyable_object)))
> > > >>    return EFAULT;
> > > >>  return 0;
> > > >>}
> > > >
> > > >This is not quite the same thing as VirtualQuery.  This verifies that
> the
> > > >process can write to memory.  It doesn't verify that it is
accessible.
> > > >
> > > >Maybe that is not important but I would have to think about this.
> > > >
> > > >Nice find, though, Rob.
> > >
> > > I've thought about it.  IsBadWritePtr should be fine in both
> > check_null_empty_path
> > > and check_valid_pointer.
> > >
> > > Could you submit a patch, Rob?  If you are motivated, I'd appreciate a
> > cleanup
> > > patch for resource.cc, too.
> > >
> > > cgf
> > >
> > > --
> > > Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
> > > Bug reporting:         http://cygwin.com/bugs.html
> > > Documentation:         http://cygwin.com/docs.html
> > > FAQ:                   http://cygwin.com/faq/
> > >
> > >
> >
>

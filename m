From: Joel Sherrill <joel.sherrill@OARcorp.com>
To: "J. Johnston" <jjohnstn@cygnus.com>, Robert Collins <robert.collins@itdomain.com.au>, cygwin-patches@cygwin.com, newlib@sources.redhat.com
Subject: Re: cygwin/newlib types patchs
Date: Wed, 28 Mar 2001 09:24:00 -0000
Message-id: <3AC21E12.17F10166@OARcorp.com>
References: <008101c0b1e6$d2b92f80$0200a8c0@lifelesswks> <20010321090559.F3149@redhat.com> <20010321091547.I3149@redhat.com> <000b01c0b24c$43e45530$0200a8c0@lifelesswks> <20010321170610.C9775@redhat.com> <026301c0b255$8982d130$0200a8c0@lifelesswks> <20010321173020.F9775@redhat.com> <029301c0b258$06fb42d0$0200a8c0@lifelesswks> <3ABBA589.74CED71C@cygnus.com> <3AC21396.979DB2C7@OARcorp.com>
X-SW-Source: 2001-q1/msg00261.html

Just to make sure I understand .. What you intend to do for
structure is effectively this:

#ifdef __RTEMS_INSIDE__
typedef struct {
  int is_initialized;
  void *stackaddr;
  int stacksize;
  int contentionscope;
  int inheritsched;
  int schedpolicy;
  struct sched_param schedparam;

  /* P1003.4b/D8, p. 54 adds cputime_clock_allowed attribute.  */
#if defined(_POSIX_THREAD_CPUTIME)
  int  cputime_clock_allowed;  /* see time.h */
#endif
  int  detachstate;

} pthread_attr_t;
#else /* in user land */
typedef void * pthread_attr_t;
#endif

If this is not the case, then I need to be educated further to make
an intelligent decision. :)

--joel

Joel Sherrill wrote:
> 
> "J. Johnston" wrote:
> >
> > Robert Collins wrote:
> > >
> > > Hi,
> > >     Chris Faylor has asked to bring a discussion we've been having
> > > cygwin-developers to the newlib list. The topic it pthread type
> > > definitions && pthread defines.
> > >
> > > I've include a couple of extracts below, but the short summary and
> > > history is
> > > I'm attempting to extend the current cygwin pthreads support, going from
> > > specifications at www.opengroup.org. As part of that work I wanted to
> > > move the cygwin pthread*_t type definitions to sys/types.h which the
> > > standard says is appropriate.
> 
> Seems reasonable.  I think at the time this was done RTEMS owned
> pthread.h
> and we just used newlib's sys/types.h.  This is all an artifact of
> trying to
> add-on to newlib's .h files.  It was only recently that we integrated as
> much as possible.
> 
> The only RTEMS specific .h file in newlib is now direct.h.
> 
> > > When I did that I noticed that
> > > a) (minor) newlib has pthread DEFINES in sys/types - the specs I'm
> > > reading suggest they should be in pthreads.h and
> >
> > Yes, the PTHREAD_xxx defines should be in pthread.h.  Only the _t types should be in sys/types.h.
> 
> This is probably my fault.  opengroup must be clearer than the POSIX
> spec.
> 
> > > b) (major) new has typedef'd the pthread*_t types as structs, not
> > > pointers. IMO having theortically opaque types defined as structs is
> > > dangerous - both because you cannot extend the capabilities in the
> > > future without breaking the ABI and because it encourages userland
> > > programs to alter the contents directly rather than via the API.
> > >
> > > It should be safe from an ABI point of view to convert from structs to
> > > void* pointers, as long as dependent system libraries are able to use a
> > > different typedef at compile time (in cygwin I have a #ifndef
> > > __INSIDE_CYGWIN__ \ userland types \#else \system types\#endif). However
> > > if any user programs have 'peeked' inside the structures, they will need
> > > to be rebuilt when their system library gets updated..
> > >
> >
> > Again, I agree with you.
> 
> Sounds reasonable to me now.
> 
> > Joel, you are being cc'd  as these changes modify code added for RTEMS.  Any problems with making
> > these changes (i.e. does the RTEMS stuff have to be protected for the time-being)?
> 
> Are you asking if there needs to be an "__INSIDE_RTEMS__" conditional
> path to
> define the structures like __INSIDE_CYGWIN__?  We already use
> 
> AM_CPPFLAGS += -D__RTEMS_INSIDE__
> 
> inside RTEMS itself to share header files.  So if you use that define,
> I would think that neither RTEMS itself nor any apps will even notice.
> 
> > -- Jeff J.
> >
> > > Rob
> > >
> > > On Thu, Mar 22, 2001 at 08:16:57AM +1100, Robert Collins wrote:
> > > >Well we can't turn on _POSIX_THREADS. And I don't think we should...
> > > >a) I've read enough of the spec now to say fairly confidently that
> > > >cygwin will not be conformant for a very long time. (Setting the stack
> > > >address, setting a guard buffer for the stack...). So turning on
> > > >_POSIX_THREADS will be misleading. Autoconf feature tests find all the
> > > >functions quite well.
> > > >b) the newlib _POSIX_THREADS types are broken IMO. They are reasonable
> > > >structures and so forth but for userland includes they should be opaque
> > > >to the user, and not a struct but rather a struct pointer to allow
> > > >behind the scenes changes without breaking the ABI. (better yet, a void
> > > >* for real opaqueness).
> > > >c) the newlib includes have things in weird places- the pthreads
> > > >#defines should be in pthreads.h not sys/types.
> > >
> > > Ok.  I didn't know this.  I wonder how much should be handled by fixing
> > > newlib, though?  If there are changes that make things more conformant
> > > then they should go in newlib.  I am sure that the newlib maintainers
> > > would like to fix things if they're out of whack.
> > >
> > > cgf
> > >
> > > ----- Original Message -----
> > > From: "Christopher Faylor" <cgf@redhat.com>
> > > To: <cygwin-patches@cygwin.com>
> > > Sent: Thursday, March 22, 2001 9:30 AM
> > > Subject: Re: cygwin/newlib types patchs
> > >
> > > > On Thu, Mar 22, 2001 at 09:23:19AM +1100, Robert Collins wrote:
> > > > >On the technical side the newlib maintainers are facing the same
> > > problem
> > > > >I did with pthreads (Changing at this date may break ABI and or
> > > existing
> > > > >#if code. Secondly they may have users who have used the fact that
> > > the
> > > > >userland includes allowed access to the internal elements of the *_t
> > > > >types. (Which is a bad thing). I understand newlib exists because
> > > > >proprietary software can be linked to it when it's sold under the
> > > second
> > > > >licence... so the maintainers may well have contractual issues crop
> > > up
> > > > >if they start fixing these things up.
> > > >
> > > > I think that all of the pthreads stuff was added by external
> > > contributors,
> > > > actually.
> > > >
> > > > Would you mind raising this issue on the newlib mailing list?  If no
> > > one
> > > > seems interested then we'll pursue a cygwin-only solution.
> > > >
> > > > cgf
> > > >
> 
> --
> Joel Sherrill, Ph.D.             Director of Research & Development
> joel@OARcorp.com                 On-Line Applications Research
> Ask me about RTEMS: a free RTOS  Huntsville AL 35805
> Support Available                (256) 722-9985

-- 
Joel Sherrill, Ph.D.             Director of Research & Development
joel@OARcorp.com                 On-Line Applications Research
Ask me about RTEMS: a free RTOS  Huntsville AL 35805
Support Available                (256) 722-9985

Return-Path: <cygwin-patches-return-2376-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2595 invoked by alias); 10 Jun 2002 06:48:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2581 invoked from network); 10 Jun 2002 06:48:34 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Sun, 09 Jun 2002 23:48:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <robert.collins@syncretize.net>
cc: cygwin-patches@cygwin.com
Subject: RE: [PATCH] added locks in pthread code
In-Reply-To: <004801c21026$a34ba300$0200a8c0@lifelesswks>
Message-ID: <Pine.WNT.4.44.0206100835080.205-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q2/txt/msg00359.txt.bz2


I wanted to make sure that a thread can not be cancelled asynchronous when
it is in the cleanup push call, but i think it could be done better with
InterlockedExchangePointer.

I will review and send an update of my pending patches with the current
CVS sources tonight.

Thomas

On Mon, 10 Jun 2002, Robert Collins wrote:

> Oh, and I'm not 100% sure that the cleanup_handler_push needs the locks
> - shouldn't it be non cancellable? The IEEE P1003.1 reference I'm using
> does not list pthread_clean_push as being cancellable, and explicitly
> states that non listed functions (from the standard) are not
> cancellable.
>
> Rob
>
> > -----Original Message-----
> > From: cygwin-patches-owner@cygwin.com
> > [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Robert Collins
> > Sent: Monday, 10 June 2002 12:24 PM
> > To: 'Thomas Pfaff'; cygwin-patches@cygwin.com
> > Subject: RE: [PATCH] added locks in pthread code
> >
> >
> > I'm applying a variation on this. Again, mainly OOP style changes, but
> > also making the mutex an instance rather than pointer. (And where you
> > aware that you where leaking the mutex?)
> >
> > Rob
> >
> > > -----Original Message-----
> > > From: Thomas Pfaff [mailto:tpfaff@gmx.net]
> > > Sent: Thursday, 25 April 2002 7:33 PM
> > > To: cygwin-patches@cygwin.com
> > > Subject: [PATCH] added locks in pthread code
> > >
> > >
> > > The patch will add locks via mutex around critical code to
> > > protect against
> > > race conditions and fix __pthread_detach to cleanup when thread has
> > > already terminated. This an incremental update again.
> > >
> > > Greetings,
> > > Thomas
> > >
> > > 2002-04-25  Thomas Pfaff  <tpfaff@gmx.net>
> > >
> > > 	* thread.h (pthread::mutex): new member
> > > 	* thread.cc (pthread::pthread): Set mutex to NULL.
> > > 	(pthread::~pthread): Destroy mutex.
> > > 	(pthread::create): Initialize mutex.
> > > 	(thread_init_wrapper): Protect against race.
> > > 	(__pthread_cleanup_push): Ditto.
> > > 	(__pthread_exit): Ditto.
> > > 	(__pthread_join): Ditto
> > > 	(__pthread_detach): Protect against race and cleanup if
> > > thread has
> > > 	already terminated.
> > >
> >
> >
>

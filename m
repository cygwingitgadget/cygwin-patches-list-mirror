Return-Path: <cygwin-patches-return-2372-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29913 invoked by alias); 10 Jun 2002 02:29:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29899 invoked from network); 10 Jun 2002 02:29:20 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Thomas Pfaff'" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
Subject: RE: [PATCH] added locks in pthread code
Date: Sun, 09 Jun 2002 19:29:00 -0000
Message-ID: <004801c21026$a34ba300$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-reply-to: <004701c21025$d183b7e0$0200a8c0@lifelesswks>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00355.txt.bz2

Oh, and I'm not 100% sure that the cleanup_handler_push needs the locks
- shouldn't it be non cancellable? The IEEE P1003.1 reference I'm using
does not list pthread_clean_push as being cancellable, and explicitly
states that non listed functions (from the standard) are not
cancellable.

Rob

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Robert Collins
> Sent: Monday, 10 June 2002 12:24 PM
> To: 'Thomas Pfaff'; cygwin-patches@cygwin.com
> Subject: RE: [PATCH] added locks in pthread code
> 
> 
> I'm applying a variation on this. Again, mainly OOP style changes, but
> also making the mutex an instance rather than pointer. (And where you
> aware that you where leaking the mutex?)
> 
> Rob
> 
> > -----Original Message-----
> > From: Thomas Pfaff [mailto:tpfaff@gmx.net] 
> > Sent: Thursday, 25 April 2002 7:33 PM
> > To: cygwin-patches@cygwin.com
> > Subject: [PATCH] added locks in pthread code
> > 
> > 
> > The patch will add locks via mutex around critical code to 
> > protect against
> > race conditions and fix __pthread_detach to cleanup when thread has
> > already terminated. This an incremental update again.
> > 
> > Greetings,
> > Thomas
> > 
> > 2002-04-25  Thomas Pfaff  <tpfaff@gmx.net>
> > 
> > 	* thread.h (pthread::mutex): new member
> > 	* thread.cc (pthread::pthread): Set mutex to NULL.
> > 	(pthread::~pthread): Destroy mutex.
> > 	(pthread::create): Initialize mutex.
> > 	(thread_init_wrapper): Protect against race.
> > 	(__pthread_cleanup_push): Ditto.
> > 	(__pthread_exit): Ditto.
> > 	(__pthread_join): Ditto
> > 	(__pthread_detach): Protect against race and cleanup if 
> > thread has
> > 	already terminated.
> > 
> 
> 

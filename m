Return-Path: <cygwin-patches-return-3715-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19015 invoked by alias); 19 Mar 2003 10:56:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18932 invoked from network); 19 Mar 2003 10:56:50 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 19 Mar 2003 10:56:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] reorganize list handling of fixable pthread objects
In-Reply-To: <1048069802.5300.153.camel@localhost>
Message-ID: <Pine.WNT.4.44.0303191149350.264-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00364.txt.bz2


I think that the code could be simplified by making callback a pointer to
member function.

void forEach (void (ListNode::*callback) ())
{
  ListNode *aNode = head;
  while (aNode)
    {
      (aNode->*callback) ();
      aNode = aNode->next;
    }
}

With this change you do not need a static to member wrapper function like
pthread_key::saveAKey.

You could write

void pthread_key::fixup_before_fork()
{
  keys.forEach (&pthread_key::saveKeyToBuffer);
}

void pthread_key::fixup_after_fork()
{
  keys.forEach (&pthread_key::recreateKeyFromBuffer);
}

void pthread_key::runAllDestructors ()
{
  keys.forEach (&pthread_key::runDestructor);
}

instead.

I see no reason for your for_each change. Maybe you could clarify this a
bit.

Thomas

On Wed, 19 Mar 2003, Robert Collins wrote:

> Oh, here is a possible for_each I wrote for another non-STL using
> project:
>
> template <class L, class T>
> T& for_each(L const &start,, L const& finish, T& visitor)
> {
>     for (L current (start); current != finish; ++current)
>         visitor(*current);
>     return visitor;
> }
>
>
> On Fri, 2003-02-28 at 22:10, Thomas Pfaff wrote:
> > Reorganize the list handling of the pthreads objects by using the List
> > template class and remove a lot of duplicate code.
> >
> >
> > 2002-02-28  Thomas Pfaff  <tpfaff@gmx.net>
> >
> > 	* thread.h (class List): Move inline code inside of class
> > 	declaration.
> > 	(pthread_mutex::fixup_after_fork): Declare as static method.
> > 	(pthread_mutex::FixupAfterFork(pthread_mutex*): New static method.
> > 	(pthread_mutex::FixupAfterFork(void): New method.
> > 	(pthread_mutex::mutexes): New static member.
> > 	(pthread_cond::fixup_after_fork): Declare as static method.
> > 	(pthread_cond::FixupAfterFork(pthread_cond*): New static method.
> > 	(pthread_cond::FixupAfterFork(void): New method.
> > 	(pthread_cond::conds): New static member.
> > 	(pthread_rwlock::fixup_after_fork): Declare as static method.
> > 	(pthread_rwlock::FixupAfterFork(pthread_rwlock*): New static
> > 	method.
> > 	(pthread_rwlock::FixupAfterFork(void): New method.
> > 	(pthread_rwlock::rwlocks): New static member.
> > 	(semaphore::fixup_after_fork): Declare as static method.
> > 	(semaphore::FixupAfterFork(semaphore*): New static method.
> > 	(semaphore::FixupAfterFork(void): New method.
> > 	(semaphore::semaphores): New static member.
> > 	(MTinterface::mutexs): Remove.
> > 	(MTinterface::conds): Ditto.
> > 	(MTinterface::rwlocks): Ditto.
> > 	(MTinterface::semaphores): Ditto.
> > 	(MTinterface::MTinterface): Remove initialization of removed
> > 	member variables.
> > 	* thread.cc (MTinterface::fixup_after_fork): Change
> > 	fixup_after_fork for pthread objects.
> > 	(pthread_cond::conds): Instantiate.
> > 	(pthread_cond::pthread_cond): Use List::Insert rather than custom
> > 	list code.
> > 	(pthread_cond::~pthread_cond): Use List::Remove rather than custom
> > 	list code.
> > 	(pthread_cond::fixup:after_fork): Implement.
> > 	(pthread_cond::FixupAfterFork): Rename old fixup_after_fork
> > 	to FixupAfterFork.
> > 	(pthread_rwlock::rwlocks): Instantiate.
> > 	(pthread_rwlock::pthread_crwlock): Use List::Insert rather than
> > 	custom list code.
> > 	(pthread_rwlock::~pthread_rwlock): Use List::Remove rather than
> > 	custom list code.
> > 	(pthread_rwlock::fixup:after_fork): Implement.
> > 	(pthread_rwlock::FixupAfterFork): Rename old fixup_after_fork
> > 	to FixupAfterFork.
> > 	(pthread_mutex::mutexes): Instantiate.
> > 	(pthread_mutex::pthread_mutex): Use List::Insert rather than
> > 	custom list code.
> > 	(pthread_mutex::~pthread_mutex): Use List::Remove rather than
> > 	custom list code.
> > 	(pthread_mutex::fixup:after_fork): Implement.
> > 	(pthread_mutex::FixupAfterFork): Rename old fixup_after_fork
> > 	to FixupAfterFork.
> > 	(semaphore::conds): Instantiate.
> > 	(semaphore::semaphore): Use List::Insert rather than custom list
> > 	code.
> > 	(semaphores::~semaphore): Use List::Remove rather than custom list
> > 	code.
> > 	(semaphore::fixup:after_fork): Implement.
> > 	(semaphore::FixupAfterFork): Rename old fixup_after_fork to
> > 	FixupAfterFork.
> >
> >
> --
> GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.
>

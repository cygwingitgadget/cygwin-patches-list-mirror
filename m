Return-Path: <cygwin-patches-return-2824-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13525 invoked by alias); 15 Aug 2002 20:00:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13464 invoked from network); 15 Aug 2002 20:00:25 -0000
Date: Thu, 15 Aug 2002 13:00:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] new mutex implementation
Message-ID: <Pine.WNT.4.44.0208152047310.-376009@thomas.kefrig-pfaff.de>
X-X-Sender: thomas@gw.kefrig-pfaff.de
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by NGI Next Generation Internet (http://www.ngi.de/)
X-SW-Source: 2002-q3/txt/msg00272.txt.bz2


This patch contains a new mutex implementation.

The advantages are:

- Same code on Win9x and NT. Actual are critical sections used on NT and
kernel mutexes on 9x.
- Posix compliant error codes.
- State is preserved after fork as it should.
- Supports both errorchecking and recursive mutexes.
- Should be at least as fast as critical sections.
- Will make us all rich and happy.

Unfortunately the pthread_mutex_trylock call requires
InterlockedCompareExchange that is not available on Win95.
See my next patch for a workaround.

Just like critical sections it will use a counter and a semaphore to block
other threads. The semaphore is only used when at least one thread is
waiting, otherwise a kernel transition is not needed.

With these mutexes the default type has changed from recursive to
errorchecking, this is also the default on all other pthread platforms
that i know (except Linux where the default is FAST where you will not get
an EDEADLOCK on locking twice, it WILL deadlock instead).

With my previous 2 patches and this one i was able to build and run a
threaded perl that has passed all tests (to be true it failed 3 but these
were really not pthread related).

2002-08-15  Thomas Pfaff <tpfaff@gmx.net>

	* include/pthread.h: Added define for errorchecking mutexes,
	changed default mutex type.
	* thread.cc (pthread_mutex::pthread_mutex): New implemented.
	(pthread_mutex::~pthread_mutex): Ditto.
	(pthread_mutex::Lock): Ditto.
	(pthread_mutex::TryLock): Ditto.
	(pthread_mutex::UnLock): Ditto.
	(pthread_mutex::Destroy): New method.
	(pthread_mutex::SetOwner): Ditto.
	(pthread_mutex::fixup_after_fork): Preserve state after fork.
	(__pthread_mutex_destroy): Call pthread_mutex::Destroy to destroy
	mutex.
	(__pthread_mutexattr_settype): Allow errorchecking and recursive
	types.
	* thread.h (pthread_mutex::criticalsection): Removed.
	(pthread_mutex::lock_counter): New member.
	(pthread_mutex::recursion_counter): Ditto.
	(pthread_mutex::owner): Ditto.
	(pthread_mutex::type): Ditto.
	(pthread_mutex::Destroy): New method.
	(pthread_mutex::SetOwner): Ditto.

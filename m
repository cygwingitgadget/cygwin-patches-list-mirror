Return-Path: <cygwin-patches-return-3274-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15256 invoked by alias); 4 Dec 2002 10:00:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15247 invoked from network); 4 Dec 2002 10:00:46 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 04 Dec 2002 02:00:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_mutex patches
In-Reply-To: <Pine.WNT.4.44.0212041042090.185-200000@algeria.intern.net>
Message-ID: <Pine.WNT.4.44.0212041057520.283-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q4/txt/msg00225.txt.bz2


Changed spaces to tabs in Changelog. Sorry.

2002-12-04  Thomas Pfaff <tpfaff@gmx.net>

	* include/pthread.h: Add define for errorchecking mutexes.
	Change default mutex type.
	* thread.cc (pthread_cond::TimedWait): Update mutex unlock
	calls.
	(pthread_mutex::pthread_mutex): New implement.
	(pthread_mutex::~pthread_mutex): Ditto.
	(pthread_mutex::Lock): Ditto.
	(pthread_mutex::TryLock): Ditto.
	(pthread_mutex::UnLock): Ditto.
	(pthread_mutex::Destroy): Implement new method.
	(pthread_mutex::SetOwner): Ditto.
	(pthread_mutex::LockRecursive): Ditto.
	(pthread_mutex::fixup_after_fork): Restore locking state after
	fork.
	(__pthread_mutex_destroy): Call pthread_mutex::Destroy to destroy
	mutex.
	(__pthread_mutexattr_settype): Allow errorchecking and recursive
	types.
	* thread.h (MUTEX_LOCK_COUNTER_INITIAL): New define.
	(pthread_mutex::criticalsection): Remove.
	(pthread_mutex::lock_counter): New member.
	(pthread_mutex::recursion_counter): Ditto.
	(pthread_mutex::owner): Ditto.
	(pthread_mutex::type): Ditto.
	(pthread_mutex::Destroy): New method.
	(pthread_mutex::SetOwner): Ditto.
	(pthread_mutex::LockRecursive): Ditto.

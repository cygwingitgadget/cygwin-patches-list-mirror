Return-Path: <cygwin-patches-return-4579-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4730 invoked by alias); 25 Feb 2004 20:13:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4715 invoked from network); 25 Feb 2004 20:13:27 -0000
Date: Wed, 25 Feb 2004 20:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add support for non portable mutex initializers
Message-ID: <20040225201324.GA2653@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0402200811300.940-500000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0402200811300.940-500000@algeria.intern.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00069.txt.bz2

On Fri, Feb 20, 2004 at 08:47:43AM +0100, Thomas Pfaff wrote:
>This patch will add support for PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP,
>PTHREAD_NORMAL_MUTEX_INITIALIZER_NP and
>PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP (+ some small bugfixes).
>Attached are also testcases for these initializers.
>The initializer names are borrowed from linux nptl.
>
>These initializers can be used for example to enable thread safe stdio
>in newlib without moving __sinit. I really want to get this fixed.
>
>Thomas
>
>P.S.: I will be on winter vacation next week, no reply during that
>time.
>
>
>2004-02-20  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* winsup.api/pthread/mutex8e.c: New testcase.
>	* winsup.api/pthread/mutex8n.c: Ditto.
>	* winsup.api/pthread/mutex8r.c: Ditto.
>
>and
>
>2004-02-20  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* include/pthread.h (PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP):
>	New define.
>	(PTHREAD_NORMAL_MUTEX_INITIALIZER_NP): Ditto.
>	(PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP): Ditto.
>	* thread.cc (pthread_mutex::is_good_initializer):
>	Check for all posssible initializers
>	(pthread_mutex::is_good_initializer_or_object): Ditto.
>	(pthread_mutex::is_good_initializer_or_bad_object): Ditto.
>	(verifyable_object_isvalid): Support up to three static
>	initializers.
>	(verifyable_object_isvalid (void const *,long)): Remove.
>	(pthread_cond::is_good_initializer_or_bad_object): Remove
>	unneeded objectState var.
>	(pthread_cond::init): Condition remains unchanged when creation
>	has failed.
>	(pthread_rwlock::is_good_initializer_or_bad_object): Remove
>	unneeded objectState var.
>	(pthread_rwlock::init): Rwlock remains unchanged when creation
>	has failed.
>	(pthread_mutex::init): Remove obsolete comment.
>	Mutex remains unchanged when creation has failed. Add support
>	for new initializers.
>	(pthread_mutex_getprioceiling): Do not create mutex,
>	just return ENOSYS.
>	(pthread_mutex_lock): Simplify.
>	(pthread_mutex_trylock): Remove unneeded local themutex.
>	(pthread_mutex_unlock): Just return EPERM if mutex is not
>	initialized.
>	(pthread_mutex_setprioceiling): Do not create mutex,
>	just return ENOSYS.
>	* thread.h (verifyable_object_isvalid): Support up to three
>	static initializers.
>	(verifyable_object_isvalid (void const *,long)): Remove
>	prototype.
>	(pthread_mutex::init): Add optional initializer to parameter
>	list.

This looks like it simplifies mutex handling a lot.  I haven't investigated
in great detail but since you've provided some test cases, feel free to
check in.

Thanks,
cgf

Return-Path: <cygwin-patches-return-5370-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17146 invoked by alias); 7 Mar 2005 03:59:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17115 invoked from network); 7 Mar 2005 03:59:42 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 7 Mar 2005 03:59:42 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 5D3C21B55F; Sun,  6 Mar 2005 23:00:15 -0500 (EST)
Date: Mon, 07 Mar 2005 03:59:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Timer functions
Message-ID: <20050307040015.GA31395@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
User-Agent: Mutt/1.4.2.1i
X-SW-Source: 2005-q1/txt/msg00073.txt.bz2

On Thu, Mar 03, 2005 at 11:45:45PM -0500, Pierre A. Humblet wrote:
>The attached patch implements the alarm, ualarm, setitimer and
>getitimer with the timer_xxx calls created by Chris last year.
>
>It has two objectives, both motivated by exim.
>- The current implementation of alarm() opens a hidden window.
>Thus, on Win9X, services calling alarm do not survive user logouts.
>- When running exim as a service under a privileged (non system)
>account on XP (trying out what's necessary on Win2003), I have hit
>api_fatal ("couldn't create window, %E") with error 5.
>
>The implementation of getitimer has necessitated the development
>of timer_gettime (not yet exported) and some changes to the logic
>of the timer_thread. I have also fixed a FIXME about race condition
>and two bugs: 
>- the initial code was not reusing the cygthreads (see attachment).
>The fix involves using "auto_release" in the timer thread instead of 
>"detach" in the calling function.
>- the mu_to was not reinitialized on forks (non-inheritable event).

I've fixed the above two problems in the current code and am going
through your patch trying to separate what looks like bug fixes from
what looks like enhanced functionality.

I am puzzled by a couple of things.

Why did you decide to forego using th->detach in favor of (apparently)
a:

      while (running)
	low_priority_sleep (0);

?

I never liked the idea that a muto had to be allocated for the timer
functions regardless of whether they were going to be used.  You have
extended this so that now an event will be allocated and a more
complicated constructor will be called to fill out ttstart.  Is that
really necessary?

FWIW, I checked in a change to muto initialization which protects the
initialization with a CRITICAL_SECTION since I thought that I might be
able to gain back the extra handle by protecting the initialization with
a critical section but it looks like a critical section is more
expensive than I thought it was, so I'll probably revert that change.

cgf

Return-Path: <cygwin-patches-return-5371-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18391 invoked by alias); 7 Mar 2005 04:40:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18354 invoked from network); 7 Mar 2005 04:40:32 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.219.218)
  by sourceware.org with SMTP; 7 Mar 2005 04:40:32 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id ICYSJK-0002PO-4E
	for cygwin-patches@cygwin.com; Sun, 06 Mar 2005 23:40:15 -0500
Message-Id: <3.0.5.32.20050306234015.00b5a598@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 07 Mar 2005 04:40:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Timer functions
In-Reply-To: <20050307040015.GA31395@trixie.casa.cgf.cx>
References: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
 <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q1/txt/msg00074.txt.bz2

At 11:00 PM 3/6/2005 -0500, Christopher Faylor wrote:
>On Thu, Mar 03, 2005 at 11:45:45PM -0500, Pierre A. Humblet wrote:
>>The attached patch implements the alarm, ualarm, setitimer and
>>getitimer with the timer_xxx calls created by Chris last year.
>>
>>It has two objectives, both motivated by exim.
>>- The current implementation of alarm() opens a hidden window.
>>Thus, on Win9X, services calling alarm do not survive user logouts.
>>- When running exim as a service under a privileged (non system)
>>account on XP (trying out what's necessary on Win2003), I have hit
>>api_fatal ("couldn't create window, %E") with error 5.
>>
>>The implementation of getitimer has necessitated the development
>>of timer_gettime (not yet exported) and some changes to the logic
>>of the timer_thread. I have also fixed a FIXME about race condition
>>and two bugs: 
>>- the initial code was not reusing the cygthreads (see attachment).
>>The fix involves using "auto_release" in the timer thread instead of 
>>"detach" in the calling function.
>>- the mu_to was not reinitialized on forks (non-inheritable event).
>
>I've fixed the above two problems in the current code and am going
>through your patch trying to separate what looks like bug fixes from
>what looks like enhanced functionality.
>
>I am puzzled by a couple of things.
>
>Why did you decide to forego using th->detach in favor of (apparently)
>a:
>
>      while (running)
>	low_priority_sleep (0);

These are not directly related. I got into this issue because of the bug
where cygthreads were not reused. I replaced th->detach by self_release
because that seemed to be the most natural and efficient way
to fix the problem. I admit this is the first time ever that I looked
at cygthread.cc, and not everything is clear. Comments in detach() refer
to a "read thread", which is probably related to select. The correspondence
wasn't clear to me, and the code is complex. self_release is trivial.
With using self_release, I initially kept the old method where the
timer thread clears protect just before going away. But then I ran
into the issue discussed in the next paragraph.
 
The low_priority sleep waits for the timer cygthread to go away. This is
cleaner e.g. when deleting the timer. The thread still has a pointer
to the timer, and there was FIXME about that. Rightly so, the pointer
could point to deallocated memory.
When rearming a timer, the wait loop also insures that there is no race
to update sleepto_us (the timer thread could just start a new loop at
the time where settimer is called).
It's important to have external access to sleepto_us because gettime needs 
it. That wasn't the case before, the timer thread didn't need to
communicate back..
 
>I never liked the idea that a muto had to be allocated for the timer
>functions regardless of whether they were going to be used. 

Initially the muto was only used for the timer linked list. That seems
legitimate and hard to avoid. 
I also use it for something else, although I went back and forth on this:
do we need to handle the case where two different threads try to arm the 
same timer at the same time? I decided to be rather safe than sorry.
That's why the muto is used around the wait loop. That will serialize
access and avoid the creation of two timer threads for the same timer.

>You have
>extended this so that now an event will be allocated and a more
>complicated constructor will be called to fill out ttstart.  Is that
>really necessary?

Not really. The event has always been there. It used to be created/deleted
each time a timer was (re)armed. Now the event is created/deleted once
for every timer. That seems more efficient.
The constructor is slightly more complicated, but there is only one when
there used to be two (there was one for ttstart and one for the dynamic
timers).

>FWIW, I checked in a change to muto initialization which protects the
>initialization with a CRITICAL_SECTION since I thought that I might be
>able to gain back the extra handle by protecting the initialization with
>a critical section but it looks like a critical section is more
>expensive than I thought it was, so I'll probably revert that change.

Not sure what you are talking about. I thought that muto's where always
created at process startup time (from dcrt0), so there is no need for
protection.

Pierre

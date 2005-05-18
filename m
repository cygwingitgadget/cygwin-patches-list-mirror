Return-Path: <cygwin-patches-return-5471-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19539 invoked by alias); 18 May 2005 19:48:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19320 invoked from network); 18 May 2005 19:48:32 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 May 2005 19:48:32 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 633A313C197; Wed, 18 May 2005 15:48:45 -0400 (EDT)
Date: Wed, 18 May 2005 19:48:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com, cygwin-developers@cygwin.com
Subject: Re: gcc4 and local statics
Message-ID: <20050518194845.GD4502@trixie.casa.cgf.cx>
Reply-To: cygwin-developers@cygwin.com, cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	cygwin-developers@cygwin.com
References: <428A7520.7FD9925C@dessent.net> <20050518080133.GA25438@calimero.vinschen.de> <428B8ECB.957836A6@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B8ECB.957836A6@dessent.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00067.txt.bz2

On Wed, May 18, 2005 at 11:51:55AM -0700, Brian Dessent wrote:
>Corinna Vinschen wrote:
>
>> While this might help to avoid... something, I'm seriously wondering
>> what's wrong with this expression.  Why does each new version of gcc
>> add new incompatibilities?
>
>I think I've figured this out.  PR/13684 added thread safety to
>initialization of local statics.[1]  It does this by wrapping the call
>to the contructor around __cxa_guard_acquire and __cxa_guard_release,
>which are supposed to prevent two threads from both calling the
>constructor at the same time.
>
>The problem is that in Cygwin, these functions are defined as no-ops in
>cxx.cc.  That means that GCC calls the function and expects a nonzero
>return value if it was able to acquire the mutex, but in our case the
>function always returns zero (or rather, it does nothing and eax
>contained zero before the function call) and so gcc never tries to call
>the constructor.
>
>There seem to be several possible ways to go here:
>
>1. Compile with -fno-threadsafe-statics.
>2. Implement an actual muto in __cxa_guard_*.
>3. Remove Cygwin's no-op __cxa_guard_* and rely on the libstdc++
>provided ones.
>4. Move the variable to file/global scope.
>
>This recently came up on an Apple list[2], apparently in the context of
>a vendor trying to compile their kernel driver against Tiger using
>gcc4.  It looks like they're going with either #4 or #1.
>
>I tested #1 and it indeed cures the failing mmap testsuites.
>
>For Cygwin's purposes it seems that we need to decide if two threads
>could ever potentially call this function at the same time.  If so, then
>#1 is out.  Correct me if I'm wrong but Cygwin does not use anything
>from libstdc++ so #3 is out as well.  In this particular case of
>'granularity' it seems rather trivial to spend much time implementing
>actual locking.  But then you have to determine if there are any other
>local statics that will be suffering from the same fate, and if so then
>#2 starts to become reasonable, otherwise I'd say #4.

Now that we know what's causing this, I guess I'd have to say that 4.
is the way to go.  The expense of a mutex for this case doesn't seem
worth it.

cgf

Return-Path: <cygwin-patches-return-5470-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17639 invoked by alias); 18 May 2005 18:52:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17475 invoked from network); 18 May 2005 18:52:01 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 18 May 2005 18:52:01 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYTe9-0003Dt-BP; Wed, 18 May 2005 18:51:57 +0000
Message-ID: <428B8ECB.957836A6@dessent.net>
Date: Wed, 18 May 2005 18:52:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-developers@cygwin.com
CC: cygwin-patches@cygwin.com
Subject: gcc4 and local statics
References: <428A7520.7FD9925C@dessent.net> <20050518080133.GA25438@calimero.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00066.txt.bz2

Corinna Vinschen wrote:

> While this might help to avoid... something, I'm seriously wondering
> what's wrong with this expression.  Why does each new version of gcc
> add new incompatibilities?

I think I've figured this out.  PR/13684 added thread safety to
initialization of local statics.[1]  It does this by wrapping the call
to the contructor around __cxa_guard_acquire and __cxa_guard_release,
which are supposed to prevent two threads from both calling the
constructor at the same time.

The problem is that in Cygwin, these functions are defined as no-ops in
cxx.cc.  That means that GCC calls the function and expects a nonzero
return value if it was able to acquire the mutex, but in our case the
function always returns zero (or rather, it does nothing and eax
contained zero before the function call) and so gcc never tries to call
the constructor.

There seem to be several possible ways to go here:

1. Compile with -fno-threadsafe-statics.
2. Implement an actual muto in __cxa_guard_*.
3. Remove Cygwin's no-op __cxa_guard_* and rely on the libstdc++
provided ones.
4. Move the variable to file/global scope.

This recently came up on an Apple list[2], apparently in the context of
a vendor trying to compile their kernel driver against Tiger using
gcc4.  It looks like they're going with either #4 or #1.

I tested #1 and it indeed cures the failing mmap testsuites.

For Cygwin's purposes it seems that we need to decide if two threads
could ever potentially call this function at the same time.  If so, then
#1 is out.  Correct me if I'm wrong but Cygwin does not use anything
from libstdc++ so #3 is out as well.  In this particular case of
'granularity' it seems rather trivial to spend much time implementing
actual locking.  But then you have to determine if there are any other
local statics that will be suffering from the same fate, and if so then
#2 starts to become reasonable, otherwise I'd say #4.

Brian

[1] http://gcc.gnu.org/bugzilla/show_bug.cgi?id=13684
[2]
http://lists.apple.com/archives/darwin-drivers/2005/May/msg00066.html

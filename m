Return-Path: <cygwin-patches-return-2570-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23503 invoked by alias); 1 Jul 2002 21:42:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23489 invoked from network); 1 Jul 2002 21:42:25 -0000
Date: Mon, 01 Jul 2002 14:42:00 -0000
From: David Euresti <davie@MIT.EDU>
X-X-Sender:  <davie@this>
To: <cygwin-patches@cygwin.com>
Subject: Re: Patch to pass file descriptors
Message-ID: <Pine.LNX.4.33.0207011735010.2716-100000@this>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00018.txt.bz2

Oops. I posted this to the wrong list.  Here it is in context.

So,
        There's the option of keeping full BSD semantics if the cygserver
is running.  I like that.  I can require users to run the cygserver.  I
don't mind.
        Unfortunately the whole net.cc has been refactored so I'll have to
regenerate my patch.
        The question is, can you incorporate my code and then you guys
deal with the case when the cygserver isn't running?  I don't really have
a use for a non cygserver solution because my program depends on full BSD
semantics.  Such as closing the handle after sending it, or exiting the
process after sending it.  I don't see how to solve this second problem
without the cygserver.
        I'm sure other people will want full BSD semantics also so why not
allow them to have it if the cygserver is running.

By the way, I thought about how to solve the problem of the program
closing the handle after sending it.  Assuming that you'll spawn a thread
with your shared memory stuff.  You can dup the handle in that thread.
Then the sender can do whatever it wants with it's copy (Close it), and
when the receiver has it, it can tell the sender to release it.
Unfortunately this won't help the situation where the sender process
exits before the receiver receives.

        Also should this discussion be moved to cygwin-developers?

David



Return-Path: <cygwin-patches-return-2093-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27805 invoked by alias); 22 Apr 2002 14:15:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27744 invoked from network); 22 Apr 2002 14:15:15 -0000
From: "Gerald S. Williams" <gsw@agere.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] minor pthread fixes
Date: Mon, 22 Apr 2002 07:15:00 -0000
Message-ID: <GBEGLOMMCLDACBPKDIHFOEPBCHAA.gsw@agere.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
In-Reply-To: <20020419114850.GD1540@tishler.net>
X-SW-Source: 2002-q2/txt/msg00077.txt.bz2

I've held off on chiming in on this, mostly because I can
only speculate at this point (and partly because this is
probably the wrong list for this discussion). :-)

There is a race condition documented in the comments in the
condition variable code. I followed it through and at one
point was pretty convinced this is the root cause. I believe
this race condition should eventually be resolved, and would
like to help out (still working out the legal details). :-(
What I don't know yet is how much impact this would have on
Rob's code, thread performance, etc. The services you'd LIKE
to use aren't available to all Windows versions, so you may
have to add a thread or something similar.

Anyway, once the new thread code and Python are available, I
figured I'd at least try it out with threaded Python. Even a
seemingly-unrelated change might eliminate the failure if it
changes the timing. Simply undefing _POSIX_SEMAPHORES will
enable the old code, so it's easy to try.

-Jerry

-O Gerald S. Williams, 55A-134A-E   : mailto:gsw@agere.com O-
-O AGERE SYSTEMS, 6755 SNOWDRIFT RD : office:610-712-8661  O-
-O ALLENTOWN, PA, USA 18106-9353    : mobile:908-672-7592  O-

> -----Original Message-----
> From: Jason Tishler [mailto:jason@tishler.net]
> Sent: Friday, April 19, 2002 7:49 AM
> To: Robert Collins
> Cc: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] minor pthread fixes
> 
> 
> Rob,
> 
> On Fri, Apr 19, 2002 at 09:37:04PM +1000, Robert Collins wrote:
> > From memory - no. Alsothe symptoms are wrong - the test hangs, not
> > prematurely exiting. Anyway, it shouldn't be too hard to build a test
> > .dll and give it a try. If you want I can shoot such a  beast over to
> > you.
> 
> No, that's OK.  Thanks to Gerald Williams' related Python patch this
> issue has been obviated.  I was just trying to finally put this Cygwin
> pthreads problem to bed...
> 
> Jason
> 

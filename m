Return-Path: <cygwin-patches-return-2836-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3782 invoked by alias); 16 Aug 2002 08:37:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3768 invoked from network); 16 Aug 2002 08:37:50 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 16 Aug 2002 01:37:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_fork
In-Reply-To: <1029460264.1058.16.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0208161020400.191-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00284.txt.bz2



On Fri, 16 Aug 2002, Robert Collins wrote:

> On Fri, 2002-08-16 at 04:27, Thomas Pfaff wrote:
> >
> > This patch will fix the pthread key related problems with fork (key value
> > is restored after fork) and some minor fork related fixes.
>
> Thomas, Some feedback on this. (I know, less than a week - wow!)
>
> Some general things:
> MTinterface::init_pthread is breaking encapsulation of pthread, please
> correct this.

Agreed. First it was used only in MTinterface but then i discovered that
it would make sense in pthread_self too if the thread has been created
outside the pthread scope.

>
> You have moved more class specific code in to MTinterface. This further
> breaks abstraction FWICS. Can you enlarge on your reasons for that?

Aside from init_pthread i do not see any code that breaks abstraction. You
have decided to handle the mutex and conds lists in MTinterface, i did the
same with keys. I do not think that handling key destructors requires its
own class and list if you have already a list with all keys.

>
> Finally it seems to me that the pthread_before_fork new call could
> (should) be called from pthread_atfork_prepare.

Sure.

>
> This is a rather big patch, covering several different things -
> refactoring list code, altering initialisation of pthread classes,
> handling fork better for pthreads, handling fork for pthead_key's. I'd
> really like to see it as as series of smaller patches to debate more
> specifcally.

I will try to break the patch into smaller ones. I am just looking where
to start.

Thomas


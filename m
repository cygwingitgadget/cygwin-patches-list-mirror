Return-Path: <cygwin-patches-return-3060-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2627 invoked by alias); 17 Oct 2002 09:31:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2590 invoked from network); 17 Oct 2002 09:31:43 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 17 Oct 2002 02:31:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix segv in pthread_mutex::init
In-Reply-To: <1034844379.11145.41.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0210171124090.320-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q4/txt/msg00011.txt.bz2



On Thu, 17 Oct 2002, Robert Collins wrote:

> On Thu, 2002-10-17 at 18:11, Thomas Pfaff wrote:
> >
> > This patch should fix the segfault in pthread_mutex::init by changing the
> > test order for a valid object and checking for valid initializer object
> > first..
>
> I'm happy with the verifyable_object change. I'm not happy with the
> pthread_mutex::init change (yet).
>
> I've checked in the verifyable_object stuff, along with a
> pthread_mutex::init change I am happy with.
>
> The reason I wasn't happy with your change was threefold:
> 1) there is no need to add scoping to static calls within a class. Doing
> so reduces readability, and should be avoided.

I am sorry, but i have first created the patch in my 1.3.12-4 version and
than ported to the CVS version. I have corrected it in my second posting.

I am still using 1.3.12-4 until i have ported my MTinterface and mutex
patches to the latest version.

> 2) The test was no longer *obvious* at first read, whereas (IMO) what
> I've checked in is.
>

The isGoodInitializerOrBadObject method looks good.

Thomas

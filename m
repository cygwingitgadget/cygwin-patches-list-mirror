Return-Path: <cygwin-patches-return-2975-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2157 invoked by alias); 16 Sep 2002 09:07:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2126 invoked from network); 16 Sep 2002 09:07:31 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 16 Sep 2002 02:07:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: Jason Tishler <jason@tishler.net>, <cygwin-developers@cygwin.com>,
        <cygwin-patches@cygwin.com>
Subject: Re: pthread_testcancel() causes SEGV
In-Reply-To: <1031671312.22457.19.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0209161054270.291-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00423.txt.bz2



On Tue, 10 Sep 2002, Robert Collins wrote:

> On Thu, 2002-08-08 at 04:54, Jason Tishler wrote:
> > Thomas,
> >
> > On Wed, Aug 07, 2002 at 09:34:14AM +0200, Thomas Pfaff wrote:
> > > Thanks for tracking it down.
> >
> > No problem.  Thanks for the quick turn around on the patch.  I tested it
> > and can confirm that it fixes the ipc-daemon service startup problem.
>
> Jason,
> sorry for the *cough* long delay.
>
> the attached patch is the 'right way' to deal with this issue IMO. It
> also gives us full pthread* support for threads created using the win32
> CreateThread call (although I won't officially support that at this
> point :}).
>

Rob,

you may have noticed that i have added similar code in my pending pthread
patches.
Anyway, since you return a NULL pointer in pthread_self if something went
wrong i vote for inclusion of my original patch regardless which patch
will be applied for pthread_self.

Thomas

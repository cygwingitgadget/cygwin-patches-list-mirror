Return-Path: <cygwin-patches-return-1611-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32368 invoked by alias); 19 Dec 2001 23:11:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32352 invoked from network); 19 Dec 2001 23:11:41 -0000
Message-ID: <071201c188e2$713045e0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKAEPOCHAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Wed, 07 Nov 2001 21:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 19 Dec 2001 23:11:40.0446 (UTC) FILETIME=[842AABE0:01C188E2]
X-SW-Source: 2001-q4/txt/msg00143.txt.bz2


===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Wednesday, December 19, 2001 11:20 PM
Subject: RE: [PATCH] Update - Setup.exe property sheet patch, properly
diffed.
> > :lets assume that chooser will subsume choose, can you please make
the
> > changes direct to choose. (I don't really want a short lived
migration
> > file - it seems pointless). (remember - CVS is smart). If you think
> > there really will be two classes for this (other than the working
inside
> > classes) then leave it as is.
> >
>
> Like I said, I don't know what the answer to this one is.  I do know
that simply
> putting choose in the property sheet will make all the other pages
ridiculously
> huge (they all end up being the size of the biggest one), and is not
an option
> because of that.  If the sheet can be resized programmatically on
Win95 on, I
> can put it in and adjust it that way (which I think would be the best
solution),
> but if not we'll need the two sheets, one basically as a "filler" (as
I have it
> now).  But even if the first way is possible, we're talking
considerably more
> time and work.  What I've got now works at least as good as it did
before WRT
> the chooser, so I see no reason for this to hold up the rest of the
changes.
> And you've already taken me to task on the size and scope of this
patch ;-).

Ok. Well correct me if I'm wrong but the current chooser.h does the
following:
it's a property page of the main window
it call do_chooser.

That's it (high level). All I'm suggesting is that until we know that we
will need a separate chooser (ie we won't just move choose.cc's contents
to chooser.cc) lets just do those two things in choose.cc.

That way if we do need a separate file later, it's not a problem.

I'm not religious on this, which is why I passed the decision to you -
but it sounds like the jury is still out for you as well.

Rob

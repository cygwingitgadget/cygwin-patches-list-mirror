Return-Path: <cygwin-patches-return-1912-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5580 invoked by alias); 27 Feb 2002 12:41:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5520 invoked from network); 27 Feb 2002 12:41:46 -0000
Message-ID: <008701c1bf8c$6d1872d0$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <20020227045945.5521.qmail@web20009.mail.yahoo.com><003301c1bf7e$ae2cca40$0100a8c0@advent02> <m3d6yr17zo.fsf@appel.lilypond.org>
Subject: Re: Copyright years (was Re: help/version patches)
Date: Wed, 27 Feb 2002 05:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00269.txt.bz2

> >> -   Copyright 1998, 1999, 2000, 2001 Red Hat, Inc.
> >> +   Copyright 1998-2002 Red Hat, Inc.
> > A quick note about changing Copyright years like this... don't do it!
The
> > two are *not* equivalent.
>
> No, but need they be?  The silly comma separated list will get out of
> hand, at some point in the future.  Each release should hold the (c)
> marker that's applicable to that release, why should later releases
> hold markers that are not applicable anyway?
>
> > Ranges are only allowed if development was carried out in that range
> > of years, but a version was completed for release only in the final
> > year of the range.
>
> If you get hold of, say, a 1999 release (tarball, cvs -D checkout),
> you'll see the range
>
>    1998-1999
>
> which will cover the only interesting thing: (c) over 1999 release.
> If you look at a 2002 tarball, you'll see
>
>    1998-2002
Since when have common sense and the law gone together. I would point out
that the GCC team have recently changed all their copyrights from the
incorrect range format to a list of years because this is simply the right
thing to do from a legal point of view. (see
http://gcc.gnu.org/ml/gcc-patches/2002-01/msg01192.html). Yes, the list of
years can become unweidly, but that's irrelevant.

Regards
Chris


Return-Path: <cygwin-patches-return-1724-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24861 invoked by alias); 17 Jan 2002 02:57:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24789 invoked from network); 17 Jan 2002 02:57:02 -0000
Message-ID: <188f01c19f02$870383b0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <911C684A29ACD311921800508B7293BA037D2A3B@cnmail> <20020117025454.GB15091@redhat.com>
Subject: Re: FW: fnmatch
Date: Wed, 16 Jan 2002 18:57:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 17 Jan 2002 02:57:01.0160 (UTC) FILETIME=[A2B4E680:01C19F02]
X-SW-Source: 2002-q1/txt/msg00081.txt.bz2

Mine isn't even feature complete. I took the approach that part of a pie
is better than none.

Mark, submit what you've got. That gets the ball rolling, then someone
motivated to have localised strptime can do the next bit. This is the
open source way :}.

Rob
===
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, January 17, 2002 1:54 PM
Subject: Re: FW: fnmatch


> On Wed, Jan 16, 2002 at 09:51:07PM -0500, Mark Bradshaw wrote:
> >I would, but it'd be kinda incomplete.  As I said, I would need some
> >guidance on getting locale specific strings.  At the moment, about
4-5
> >locations (if memory serves) have hard coded strings whereas in
OpenBSD
> >their locale specific.
> >
> >If we use yours, or I finish mine...I don't mind either way.  I
didn't pipe
> >up to push what I'd done.
>
> I'll wager (without looking at the code, in true !cygwin! style) that
> Robert's implementation doesn't take locales into consideration
either.
>
> cgf
>

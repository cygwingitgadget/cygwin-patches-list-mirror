Return-Path: <cygwin-patches-return-1477-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 5411 invoked by alias); 12 Nov 2001 22:32:10 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 5395 invoked from network); 12 Nov 2001 22:32:09 -0000
Message-ID: <02c901c16bca$1a7e5fa0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "CP List" <Cygwin-Patches@Cygwin.Com>
Cc: "Gareth Pearce" <tilps@hotmail.com>
References: <OE65oDk9X2VFyBUMeEk0000ecac@hotmail.com> <01fe01c16916$a920a350$0200a8c0@lifelesswks> <3BEBC8F6.3B150BA3@yahoo.com> <021401c16976$7a591380$0200a8c0@lifelesswks> <3BEFCB8E.C0507FBD@yahoo.com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Thu, 04 Oct 2001 18:19:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 12 Nov 2001 22:39:37.0242 (UTC) FILETIME=[E89047A0:01C16BCA]
X-SW-Source: 2001-q4/txt/msg00009.txt.bz2

----- Original Message -----
From: "Earnie Boyd" <earnie_boyd@yahoo.com>


> Robert Collins wrote:
>
> > There was an earlier thread on skip vs keep, and what they mean.
> >
> > It was on cyg-apps IIRC.
> >
>
> That's fine, I half recall the thread and at the time didn't have time
to
> voice an opinion.  I know skip is intended for the not-installed
packages
> and keep is intended for the already-installed packages.  However, in
the
> current invocation skip is relative to both and IMO should still be
relative
> to both.  Skip for the not-installed means leave it not-installed
(i.e.:
> leave it as is) and skip for the already-installed means don't update
what I
> have (i.e.: leave it as is).  Setup does this now, there isn't a
coding
> change for it.  IMHO, keep should be removed in favor of skip.  As I
said,
> it may be too late to say anything but...
>

At this point, I'm against any code changes that aren't release
critical.

I'm happy for this to be debated to death for the HEAD branch though.
I'm not convinced that having a separate skip/keep for the user makes
sense, but then I'm not convinced that a spin control is best their
either..

Certainly the innards of choose.cc need reworking, and I'd kinda like to
do that before bit twiddling choose.cc's gui.

Rob

Return-Path: <cygwin-patches-return-2537-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22287 invoked by alias); 28 Jun 2002 22:18:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22273 invoked from network); 28 Jun 2002 22:18:05 -0000
Message-ID: <008401c21ef1$a6cefd90$1800a8c0@LAPTOP>
From: "Robert Collins" <robert.collins@syncretize.net>
To: "Darik Horn" <dajhorn@uwaterloo.ca>,
	<cygwin-patches@cygwin.com>
References: <Pine.SOL.4.44.0206281540050.25309-200000@maddison.math.uwaterloo.ca>
Subject: Re: sem_getvalue patch revisited
Date: Sat, 29 Jun 2002 00:36:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00520.txt.bz2

Actually neither of them are quite right.

Yours calls __sem_post, which is definately wrong.

Sam Robb's I've properly reviewed now, and it's also not quite there.

The pthread.cc file is nearly a waste of space at the moment. All recent
patches to it have been converting the call tree from

pthread.cc: foo (thing*
thread.cc:     __foo (thing*
thread.cc:        thing->foo

to
pthread.cc: foo (thing *
thread.cc:      thing->foo

Sam's approach of reading the value directly is wrong (breaks
encapsulation), but your double bounce approach is also wasteful. And yes
there are many examples like that in the threads code, which I inherited and
have been (slowly) whittling away.

Cheers,
Rob

----- Original Message -----
From: "Darik Horn" <dajhorn@uwaterloo.ca>
To: <cygwin-patches@cygwin.com>
Sent: Saturday, June 29, 2002 5:58 AM
Subject: sem_getvalue patch revisited


>
> Sam Robb posted a semaphore getvalue patch on June 7th, 2002:
>
> http://cygwin.com/ml/cygwin-patches/2002-q2/msg00339.html
>
> I had been working on the same problem, but I produced a different
> solution.  Please see the attachment, which was written against 1.3.10-1
> but also applies to 1.3.11-3 cleanly.
>
> In particular, Rob's patch returns `(*sem)->currentvalue` directly from
> inside the new __sem_ function, whereas my patch adds a GetValue method to
> the semaphore class.  (I was trying to follow the style of the existing
> Cygwin semaphore.)
>
> I am wondering whether Sam's patch is functionally equivalent to my own,
> and whether one is more or less correct than the other.
>
> []
>

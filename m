Return-Path: <cygwin-patches-return-1794-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21812 invoked by alias); 25 Jan 2002 22:53:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21683 invoked from network); 25 Jan 2002 22:53:38 -0000
Message-ID: <014f01c1a5f3$1eb048f0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "J. Johnston" <jjohnstn@redhat.com>
Cc: "Thomas Fitzsimmons" <fitzsim@redhat.com>,
	<cgf@redhat.com>,
	<newlib@sources.redhat.com>,
	<cygwin-patches@cygwin.com>
References: <1011834535.1278.46.camel@toggle>	<02ce01c1a488$156d32b0$0200a8c0@lifelesswks>	<1011892037.16026.53.camel@toggle>  <20020124174949.GA3123@redhat.com> 	<1011901690.1187.55.camel@toggle> <1011914014.18203.5.camel@lifelesswks> <3C50A86B.93F06373@redhat.com>
Subject: Re: patch to allow newlib to compile when winsup not present
Date: Fri, 25 Jan 2002 14:53:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 25 Jan 2002 22:53:37.0733 (UTC) FILETIME=[201A8750:01C1A5F3]
X-SW-Source: 2002-q1/txt/msg00151.txt.bz2


===
----- Original Message -----
From: "J. Johnston" <jjohnstn@redhat.com>

> No overwhelming reason, however, historically there are already
precedences for
> this.  Newlib already contains system-specific and machine-specific
header
> files and a system for overriding the common ones.  It supposed to be
the
> C library.  It is not supposed to be 1/nth of a C library.  Look at
glibc if
> you want an example.  It has multiple directories for system-dependent
code.
> It is a very reasonable design.

I'll accept that you may have system-dependent code that is part of the
C library. If you are implementing user-land threads for instance, then
that is quite clearly a C library, probably system dependent set of
code. However, in this instance, we are implementing 'kernel' threads,
and the typedef will change as that implementation changes, without any
other changes being needed (or appropriate) in newlib.

I'm not suggesting that newlib be a 1/nth C library, just like I presume
you aren't suggesting it become a kernel :}.

> That said, the line between newlib and winsup has not been drawn
particularly
> well.

I agree. I recently suggested that winsup have it's binary reorganised
to have more a more explict C library, math libray, and porting layer
approach, which (if accepted :}) will likely help draw the line.
Ideally, the two are orthogonal to each other. But realiy is often more
messy than that.

> A simple solution is to have the header file in question for newlib
(possibly
> some
> additional ones) have a #error message if Cygwin is being compiled and
the
> header file
> has not been overridden properly because winsup headers have not been
brought
> in.

Hmm, I wonder if
#ifndef pthread_t
#error pthread_t hasn't be specified for this platform, do you have the
kernel includes available?
#endif

will catch a missing typedef correctly? Assuming it won't, the correct
define to check for in this case is _CYGWIN_TYPES_H.

Rob

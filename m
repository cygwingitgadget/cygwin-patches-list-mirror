Return-Path: <cygwin-patches-return-1605-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5425 invoked by alias); 19 Dec 2001 09:15:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5407 invoked from network); 19 Dec 2001 09:15:39 -0000
Message-ID: <035e01c1886d$a5d9c610$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKEEPJCHAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Setup.exe in a property sheet
Date: Wed, 07 Nov 2001 06:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 19 Dec 2001 09:15:38.0889 (UTC) FILETIME=[B98C7F90:01C1886D]
X-SW-Source: 2001-q4/txt/msg00137.txt.bz2


===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Wednesday, December 19, 2001 7:42 PM
Subject: RE: [PATCH] Setup.exe in a property sheet


> > Ok, first glance:
> >
> > You've diffed across versions - please update both the clean dir and
> > your working dir for the next patch. Thats a major reason the patch
is
> > so big.
> >
> > * please use win32 thread API calls, not _beginthread et al.
>
> I don't think we can do that, at least not everywhere.  The threads
call many
> CRT functions, and MS warns you not to use CreateThread if you're
using the CRT
> in your thread.  Note that the threads are now "backwards" from what
they used
> to be - the UI (which IIRC isn't using much if any CRT) now runs
entirely in the
> main thread, and a few of the do_xxx()'s are split off of that main
thread soas
> to not block the UI updating/responsiveness.

This:
A thread that uses functions from the C run-time libraries should use
the _beginthread and _endthread C run-time functions for thread
management rather than CreateThread and ExitThread. Failure to do so
results in small memory leaks when ExitThread is called.

Is the reference I remember. Up to you at the end of the day. I think
it's a shame mingw still suffers from this.

Rob

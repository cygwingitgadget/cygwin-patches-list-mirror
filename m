Return-Path: <cygwin-patches-return-1881-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24745 invoked by alias); 24 Feb 2002 10:42:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24688 invoked from network); 24 Feb 2002 10:42:37 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Percent complete in Setup.exe window title.
Date: Sun, 24 Feb 2002 03:01:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKKEOLCKAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA760014AE7@itdomain003.itdomain.net.au>
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00238.txt.bz2

> -----Original Message-----
> From: Robert Collins [mailto:robert.collins@itdomain.com.au]
> Sent: Sunday, February 24, 2002 2:26 AM
> To: Gary R. Van Sickle
> Cc: cygwin-patches@cygwin.com
> Subject: RE: [PATCH] Percent complete in Setup.exe window title.
>
>
> Looks nice. I'll commit to HEAD shortly.
>
> Why the discardable stringtable?
>

Something VC++'s resource editor decided to add for reasons known only to it.
I'm having trouble finding anything on what it actually means right now, does it
make any difference?  It sounds like a remnant of Win3.x.

--
Gary R. Van Sickle
Brewer.  Patriot.

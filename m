Return-Path: <cygwin-patches-return-1820-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16051 invoked by alias); 29 Jan 2002 07:05:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15992 invoked from network); 29 Jan 2002 07:05:03 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 23:05:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKIEMOCJAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <066001c1a88a$ed36f680$0200a8c0@lifelesswks>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00177.txt.bz2

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com
> [mailto:cygwin-patches-owner@cygwin.com]On Behalf Of Robert Collins
> Sent: Tuesday, January 29, 2002 12:05 AM
> To: Michael A Chase; cygwin-patches@cygwin.com
> Subject: Re: [PATCH]Reduce messages in setup.log
>
>
> Ok, I've looked at the patch.
>
> Most of the methods are stubs that should warn when used. Some aren't,
> and I'll try and merge those changes in by hand tonight. Don't bother
> reissuing the patch - I'm about to cause everyone heartache by removing
> much of the char * usage (I got sick of memleaks)

Yeah, I'm cryin' my eyes out here. ;-)

> for a
> quick-and-dirtyish String class. Sigh, still no STL.

Rob, would you care to just graft more functionality onto my embryonic
"cistring" class?  Or was that the plan?

--
Gary R. Van Sickle
Brewer.  Patriot.


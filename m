Return-Path: <cygwin-patches-return-1600-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6053 invoked by alias); 17 Dec 2001 05:14:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6032 invoked from network); 17 Dec 2001 05:13:59 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Wed, 07 Nov 2001 05:06:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKAEPACHAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <15c601c1868b$543c7930$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/txt/msg00132.txt.bz2

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com
> [mailto:cygwin-patches-owner@cygwin.com]On Behalf Of Robert Collins
> Sent: Sunday, December 16, 2001 5:43 PM
> To: cygwin-patches@cygwin.com; Jan Nieuwenhuizen
> Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf
> packages]
>
>
> Strangely enough, building from CVS works fine for me - w32api seems
> fine.
>

With the exception of <cstdlib> that gcc isn't finding for me in the generated
inilex.cc, I can second that emotion.  I think you must have something pretty
badly broken in your build environment somehow, Jan.  Are you sure you have both
the current "mingw runtime" stuff and a current *full* CVS tree of cygwin?  The
setup build pulls in a bunch of header directories from the cygwin tree as well
as your regular mingw stuff, so it might be some issue there.

--
Gary R. Van Sickle
Brewer.  Patriot.

Return-Path: <cygwin-patches-return-1612-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24253 invoked by alias); 20 Dec 2001 03:31:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24237 invoked from network); 20 Dec 2001 03:31:03 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Thu, 08 Nov 2001 05:02:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKMEAECIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <071201c188e2$713045e0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/txt/msg00144.txt.bz2

[snip]

> Ok. Well correct me if I'm wrong but the current chooser.h does the
> following:
> it's a property page of the main window
> it call do_chooser.
>
> That's it (high level). All I'm suggesting is that until we know that we
> will need a separate chooser (ie we won't just move choose.cc's contents
> to chooser.cc) lets just do those two things in choose.cc.
>
> That way if we do need a separate file later, it's not a problem.
>
> I'm not religious on this, which is why I passed the decision to you -
> but it sounds like the jury is still out for you as well.
>
> Rob

Ah, OK, I almost completely misunderstood you there.  Makes sense now; will do
barring any unforseen craziness, which I don't forsee.

--
Gary R. Van Sickle
Brewer.  Patriot.

Return-Path: <cygwin-patches-return-1609-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4480 invoked by alias); 19 Dec 2001 11:30:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4452 invoked from network); 19 Dec 2001 11:30:50 -0000
Message-ID: <040a01c18880$877afbe0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKOEPMCHAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Wed, 07 Nov 2001 07:42:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 19 Dec 2001 11:30:48.0234 (UTC) FILETIME=[9B1858A0:01C18880]
X-SW-Source: 2001-q4/txt/msg00141.txt.bz2

Ok, I'll get nitty-gritty now.

ChangeLog presentation:
:The changelog is formatted wrongly - you have extra lines.
:When you have
(foo): Did bar.
(foo): Did barf.
write it as
(foo): Did bar.
Did barf.
:in the main entry you have a tab halfway through the line

Regarding the patch:
:Please remove the #if 0'd items. If its a mistake to remove them, then
we can get them back from CVS.
:Please remove your package_meta.h (sdesc) workaround. It's not the
right answer. (We can discuss what is instead if you like).
:lets assume that chooser will subsume choose, can you please make the
changes direct to choose. (I don't really want a short lived migration
file - it seems pointless). (remember - CVS is smart). If you think
there really will be two classes for this (other than the working inside
classes) then leave it as is.

Cheers,
Rob

Return-Path: <cygwin-patches-return-1618-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25719 invoked by alias); 20 Dec 2001 21:17:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25705 invoked from network); 20 Dec 2001 21:17:40 -0000
Message-ID: <03f301c1899b$ae6deb60$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R Van Sickle" <tiberius@braemarinc.com>,
	<cygwin-patches@sourceware.cygnus.com>
References: <000601c18994$10e82920$2101a8c0@BRAEMARINC.COM>
Subject: Re: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Thu, 08 Nov 2001 14:52:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 20 Dec 2001 21:17:38.0447 (UTC) FILETIME=[C06E39F0:01C1899B]
X-SW-Source: 2001-q4/txt/msg00150.txt.bz2

----- Original Message -----
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
>
> "Once virtual, always virtual", i.e., it isn't necessary to add
"virtual" to
> any overridden virtual functions, and in fact it's not possible to
> "unvirtualize" once virtualized.  I do try to maintain them as a
stylistic
> convention, but even I fall short sometimes ;-).  Thanks for patching
that.

My understanding is that this is not 100% the case. Or more
pedantically - in a class derived from a a class with virtual functions,
those virtual functions wil get overriden, but if not declared virtual
themselves, any further derivations will not. I believe that the
technique of doing this to allow inlining of code calling references to
an object is called 'final classes'.

> > 2) See download.cc - is next_dialog still used, and should a
> > fail result
> > in the previous behaviour?
> >
>
> I believe it is still used in a few places (some of the "do_xxx"'s).
That
> whole mechanism is one of the next things to go.  As far as behavior
is
> concerned, I'm trying hard to specifically *not* change any at this
point,
> but simply to get the new property page and class foundation laid
("simply"
> he sez ;-)).  So you're saying that a download failure isn't being
handled
> properly?

I think that 2 things are broken:
1) A local install doesn't.
2) A failure during download may not behave correctly - but I don't
know.

Rob

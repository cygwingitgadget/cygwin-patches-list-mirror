Return-Path: <cygwin-patches-return-1642-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18066 invoked by alias); 31 Dec 2001 11:06:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18052 invoked from network); 31 Dec 2001 11:06:06 -0000
Message-ID: <006f01c191eb$24df7190$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKOECACIAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Fri, 09 Nov 2001 07:59:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 31 Dec 2001 11:06:01.0320 (UTC) FILETIME=[21C84680:01C191EB]
X-SW-Source: 2001-q4/txt/msg00174.txt.bz2

----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
> Ah, ok.  If you already hadn't noticed, indent's "Midas Touch" is
doing that to
> me in every file I send to you (dives for cover ;-)).

:] Lol.

> Actually, it looks like it's not just me either; take a look at this
from
> log.cc/log_save:
>
> This may or may not look OK to you, but what's happening is that it's
mixing
> tabs and spaces for some reason: "for" is spaced, "if" is tabbed.
With tabs==4
> spaces, they'll line right up.

Hmm, For me indent replaces 8 spaces with a tab. I believe thats the
default in the absence of environment and command line options.

> "Here" being indent 2.2.7 on Linux, or on Cygwin?  I just changed my
Cygwin

Cygwin. I've never observed a difference between linux and cygwin indent
to date.

> I'll copy this to the cygwin list in the hope it will help Charles and
anybody
> else struggling with this.
> >
>
> Without thinking about it too hard, this sounds both very cool and a
potential
> nightmare.  What happens if a "malicious mirror" somehow makes it onto
the
> distributed list and starts spreading trojans or something?

MD5 package verification + GPG signing by the maintainer would solve
that :}. And yes that's in my master plan, but it needs careful thought,
and plenty of cygwin-apps discussion first. Also, the malicious mirror
scenario is present today - via mirrors.lst. If the distributed
setup.ini's containing mirrors is seen as a serious problem (in the
interim absence of the signing solution) then we can simply have the
cached mirror list refreshed from the sources.redhat site every x days.
Please note that if any official mirror were to diddle setup.ini's
mirror list, then they could just replace packages with trojans anyway.

> > As far as UI goes, I think the combobox + a text box for the new
site is
> > fine. But rather than a radio button to choose which is used, have
an
> > Add button to the right of the textbox, and also make Enter in the
> > textbox trigger an add. Remove can be done by a button 'Delete
selected
> > sites' that does just that.
> >
>
> Yeah, that's what I'm thinking (and working on) right now.  How about
an "Are
> you sure you want to add <Insert URL here>?" MessageBox at least until
"Remove"
> is implemented (assuming "Remove" is more work than I want to do for
this
> patch)?

Nyahh. Don't bother - that list could handle many many garbage entries
without giving the user trouble.

Rob

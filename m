Return-Path: <cygwin-patches-return-1733-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28571 invoked by alias); 17 Jan 2002 16:50:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28549 invoked from network); 17 Jan 2002 16:50:25 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A4E@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: FW: fnmatch
Date: Thu, 17 Jan 2002 08:50:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q1/txt/msg00090.txt.bz2

Here's the full text of what Chuck sent me.  Maybe it'll help:

"Bad news.  The stuff you took from OpenBSD is licensed under the BSD 
w/advertising clause.  And, since it is owned by Klaus Klein and/or "The 
NetBSD Foundation" it does NOT fall under the blanket changeover (from 
w/advert clause to NO advert clause) issued by the UCalBerkeley folks.

Since the BSD+advert license is incompatible with the GPL, you CANNOT 
legally mix the two -- you can't even link a BSD+advert library with a 
GPL executable.  You can't link a BSD+advert .o with a GPL .o.  And you 
*definitely* can't mix BSD+advert code with GPL code in the same .c file."

> -----Original Message-----
> From: Corinna Vinschen [mailto:cygwin-patches@cygwin.com]
> Sent: Thursday, January 17, 2002 11:49 AM
> To: 'Corinna Vinschen'
> Subject: Re: FW: fnmatch
> 
> 
> On Thu, Jan 17, 2002 at 11:16:02AM -0500, Mark Bradshaw wrote:
> > Oops.  Chuck caught a licensing problem with the openbsd version of
> > strptime...
> > 
> > Bad news.  The stuff you took from OpenBSD is licensed 
> under the BSD 
> > w/advertising clause.  And, since it is owned by Klaus 
> Klein and/or "The 
> > NetBSD Foundation" it does NOT fall under the blanket 
> changeover (from 
> > w/advert clause to NO advert clause) issued by the 
> UCalBerkeley folks.
> 
> I (still) don't exactly understand the implications of that clause.
> And the fnmatch.c code is copyrighted by UCB...
> 
> Corinna
> 
> -- 
> Corinna Vinschen                  Please, send mails 
> regarding Cygwin to
> Cygwin Developer                                
> mailto:cygwin@cygwin.com
> Red Hat, Inc.
> 

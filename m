Return-Path: <cygwin-patches-return-5760-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29427 invoked by alias); 16 Feb 2006 17:46:10 -0000
Received: (qmail 29417 invoked by uid 22791); 16 Feb 2006 17:46:10 -0000
X-Spam-Check-By: sourceware.org
Received: from smtpout11-02.prod.mesa1.secureserver.net (HELO smtpout11-02.prod.mesa1.secureserver.net) (68.178.232.2)     by sourceware.org (qpsmtpd/0.31) with SMTP; Thu, 16 Feb 2006 17:46:08 +0000
Received: (qmail 26998 invoked from network); 16 Feb 2006 17:46:07 -0000
Received: from unknown (HELO gem-wbe14.prod.mesa1.secureserver.net) (64.202.189.101)   by smtpout11-02.prod.mesa1.secureserver.net with SMTP; 16 Feb 2006 17:46:07 -0000
Received: (qmail 17111 invoked by uid 99); 16 Feb 2006 17:46:07 -0000
Date: Thu, 16 Feb 2006 17:46:00 -0000
From: "Jerry D. Hedden" <jerry@hedden.us>
Subject: RE: [PATCH] Add -p option to ps command
To: cygwin-patches@cygwin.com
Message-ID: <20060216104607.fb30e530d17747c2b054d625b8945d88.ac8efb9ae7.wbe@email.secureserver.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00069.txt.bz2

> -------- Original Message --------
> Subject: Re: [PATCH] Add -p option to ps command
> From: Corinna Vinschen <corinna-cygwin@cygwin.com>
> Date: Thu, February 16, 2006 10:09 am
> To: cygwin-patches@cygwin.com
> 
> On Feb 16 07:58, Jerry D. Hedden wrote:
> > Thanks.  I realized one minor oversight.  Using -p should imply -a so
> > that even if the PID is not owned by the current user, it will still
> > get listed.  I've attached a patch for this (just a one line addition)
> > that builds on top of the previous patch (i.e., apply it against
> > version 1.20 of ps.cc).  Thanks again.
> 
> > Index: src/winsup/utils/ps.cc
> > ===================================================================
> > --- ps.cc  1.20
> > +++ ps.cc
> > @@ -286,6 +286,7 @@
> >  	break;
> >        case 'p':
> >  	proc_id = atoi (optarg);
> > +	aflag = 1;
> >  	break;
> >        case 's':
> >  	sflag = 1;
> 
> What about the ChangeLog entry?  http://cygwin.com/contrib.html

I'll get this right one of these days.  Thanks for your patience.

Changelog entry:

2006-02-16  Jerry D. Hedden  <jerry@hedden.us>

	* ps.cc (main): -p implies -a



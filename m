Return-Path: <cygwin-patches-return-7235-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13155 invoked by alias); 1 Apr 2011 08:28:09 -0000
Received: (qmail 13108 invoked by uid 22791); 1 Apr 2011 08:27:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 01 Apr 2011 08:27:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CA9032C0302; Fri,  1 Apr 2011 10:27:46 +0200 (CEST)
Date: Fri, 01 Apr 2011 08:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] /proc/loadavg: add running/total processes
Message-ID: <20110401082746.GD25000@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301445133.756.11.camel@YAAKOV04> <20110330081341.GA28987@calimero.vinschen.de> <1301475242.5552.28.camel@YAAKOV04> <20110330102741.GA10712@calimero.vinschen.de> <1301642508.692.5.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301642508.692.5.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00001.txt.bz2

On Apr  1 02:21, Yaakov (Cygwin/X) wrote:
> On Wed, 2011-03-30 at 12:27 +0200, Corinna Vinschen wrote:
> > On Mar 30 03:54, Yaakov (Cygwin/X) wrote:
> > > On Wed, 2011-03-30 at 10:13 +0200, Corinna Vinschen wrote:
> > > > On Mar 29 19:32, Yaakov (Cygwin/X) wrote:
> > > > > This patch adds the fourth component of Linux's /proc/loadavg[1], the
> > > > > current running/total processes count.  My only question is if states
> > > > > other than 'O' and 'R' should be considered "running" for this purpose.
> > > > 
> > > > That looks right.  But I don't see that get_process_state will ever
> > > > generate an 'O'.
> > > 
> > > Good point.  get_process_state() returns only R/S/Z, but
> > > format_process_status() has a case for a few other states.  Why?
> > 
> > Dunno.  The code has been contributed by Christopher January in 2002
> > and is essentially unchanged since then.  I don't think anybody would
> > be angry with you if you're going to pick it up and dust it off a bit...
> 
> That's alright, I think I'll leave that alone for now; I have other
> patches waiting in my queue to deal with.
> 
> Bottom line: should I remove the case 'O' since get_process_state
> doesn't (yet?) return it, or leave it in as in format_process_status()?

Leave it and check in your patch.  Could you please also add a FIXME
comment to get_process_state, somewhere around the lines which generate
the 'R' flag, to explain that we might want to revist this code to
generate an 'O' flag at one point?

> Then I would like to leave the fifth column for a later time.

Ok.  Go ahead.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

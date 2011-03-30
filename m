Return-Path: <cygwin-patches-return-7225-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2551 invoked by alias); 30 Mar 2011 10:28:00 -0000
Received: (qmail 2520 invoked by uid 22791); 30 Mar 2011 10:27:49 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 30 Mar 2011 10:27:45 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E34602C0302; Wed, 30 Mar 2011 12:27:41 +0200 (CEST)
Date: Wed, 30 Mar 2011 10:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] /proc/loadavg: add running/total processes
Message-ID: <20110330102741.GA10712@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301445133.756.11.camel@YAAKOV04> <20110330081341.GA28987@calimero.vinschen.de> <1301475242.5552.28.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301475242.5552.28.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00080.txt.bz2

On Mar 30 03:54, Yaakov (Cygwin/X) wrote:
> On Wed, 2011-03-30 at 10:13 +0200, Corinna Vinschen wrote:
> > On Mar 29 19:32, Yaakov (Cygwin/X) wrote:
> > > This patch adds the fourth component of Linux's /proc/loadavg[1], the
> > > current running/total processes count.  My only question is if states
> > > other than 'O' and 'R' should be considered "running" for this purpose.
> > 
> > That looks right.  But I don't see that get_process_state will ever
> > generate an 'O'.
> 
> Good point.  get_process_state() returns only R/S/Z, but
> format_process_status() has a case for a few other states.  Why?

Dunno.  The code has been contributed by Christopher January in 2002
and is essentially unchanged since then.  I don't think anybody would
be angry with you if you're going to pick it up and dust it off a bit...

> > What about the last column in /proc/loadavg, the last pid?  Shouldn't
> > this be added and set to 0 as well?
> 
> I don't think using a 0 is a good idea, in case some software scanf()s
> this file and tries to do something with the information (division by
> zero comes to mind).
> 
> As for actually implementing the fifth column, I wasn't sure as to the
> true significance of this number: is it really just the pid of the last
> process or the number of processes launched since startup?  On Linux,
> AFAICS these are one and the same, as pids are allocated sequentially,
> but not on Cygwin.  I know the wording implies the former but the
> purpose of this file makes me suspect the latter.  Insight, anyone?

Not me.  I only know what the URL you sent is saying.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

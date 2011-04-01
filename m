Return-Path: <cygwin-patches-return-7234-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32191 invoked by alias); 1 Apr 2011 07:22:00 -0000
Received: (qmail 32160 invoked by uid 22791); 1 Apr 2011 07:21:58 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 01 Apr 2011 07:21:50 +0000
Received: by iyi20 with SMTP id 20so4212557iyi.2        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2011 00:21:49 -0700 (PDT)
Received: by 10.43.60.211 with SMTP id wt19mr788453icb.468.1301642509658;        Fri, 01 Apr 2011 00:21:49 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id uk4sm1131167icb.9.2011.04.01.00.21.46        (version=SSLv3 cipher=OTHER);        Fri, 01 Apr 2011 00:21:47 -0700 (PDT)
Subject: Re: [PATCH] /proc/loadavg: add running/total processes
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110330102741.GA10712@calimero.vinschen.de>
References: <1301445133.756.11.camel@YAAKOV04>	 <20110330081341.GA28987@calimero.vinschen.de>	 <1301475242.5552.28.camel@YAAKOV04>	 <20110330102741.GA10712@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 07:22:00 -0000
Message-ID: <1301642508.692.5.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00000.txt.bz2

On Wed, 2011-03-30 at 12:27 +0200, Corinna Vinschen wrote:
> On Mar 30 03:54, Yaakov (Cygwin/X) wrote:
> > On Wed, 2011-03-30 at 10:13 +0200, Corinna Vinschen wrote:
> > > On Mar 29 19:32, Yaakov (Cygwin/X) wrote:
> > > > This patch adds the fourth component of Linux's /proc/loadavg[1], the
> > > > current running/total processes count.  My only question is if states
> > > > other than 'O' and 'R' should be considered "running" for this purpose.
> > > 
> > > That looks right.  But I don't see that get_process_state will ever
> > > generate an 'O'.
> > 
> > Good point.  get_process_state() returns only R/S/Z, but
> > format_process_status() has a case for a few other states.  Why?
> 
> Dunno.  The code has been contributed by Christopher January in 2002
> and is essentially unchanged since then.  I don't think anybody would
> be angry with you if you're going to pick it up and dust it off a bit...

That's alright, I think I'll leave that alone for now; I have other
patches waiting in my queue to deal with.

Bottom line: should I remove the case 'O' since get_process_state
doesn't (yet?) return it, or leave it in as in format_process_status()?

> > > What about the last column in /proc/loadavg, the last pid?  Shouldn't
> > > this be added and set to 0 as well?
> > 
> > I don't think using a 0 is a good idea, in case some software scanf()s
> > this file and tries to do something with the information (division by
> > zero comes to mind).
> > 
> > As for actually implementing the fifth column, I wasn't sure as to the
> > true significance of this number: is it really just the pid of the last
> > process or the number of processes launched since startup?  On Linux,
> > AFAICS these are one and the same, as pids are allocated sequentially,
> > but not on Cygwin.  I know the wording implies the former but the
> > purpose of this file makes me suspect the latter.  Insight, anyone?
> 
> Not me.  I only know what the URL you sent is saying.

Then I would like to leave the fifth column for a later time.


Yaakov


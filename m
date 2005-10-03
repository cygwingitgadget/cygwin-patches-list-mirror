Return-Path: <cygwin-patches-return-5659-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18416 invoked by alias); 3 Oct 2005 17:25:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18376 invoked by uid 22791); 3 Oct 2005 17:25:42 -0000
Received: from mailgw02.flightsafety.com (HELO mailgw02.flightsafety.com) (66.109.90.21)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 03 Oct 2005 17:25:42 +0000
Received: from mailgw02.flightsafety.com (localhost [127.0.0.1])
	by mailgw02.flightsafety.com (8.13.1/8.13.1) with ESMTP id j93HOGQO026948
	for <cygwin-patches@cygwin.com>; Mon, 3 Oct 2005 13:24:16 -0400 (EDT)
Received: from VXS1.flightsafety.com (internal-31-145.flightsafety.com [192.168.31.145])
	by mailgw02.flightsafety.com (8.13.1/8.13.1) with ESMTP id j93HOGgZ026945
	for <cygwin-patches@cygwin.com>; Mon, 3 Oct 2005 13:24:16 -0400 (EDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Oct 2005 13:25:39 -0400
Received: from PC1163-8460-XP.flightsafety.com ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 3 Oct 2005 12:25:38 -0500
Date: Mon, 03 Oct 2005 17:25:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: IP_MULTICAST_IF et all / Winsock[2] value conflict
In-Reply-To: <20051003165358.GA4436@calimero.vinschen.de>
Message-ID: <Pine.CYG.4.58.0510031213250.1904@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0509291103421.2244@PC1163-8460-XP.flightsafety.com>
 <20050929165053.GU12256@calimero.vinschen.de>
 <Pine.CYG.4.58.0509291152490.2244@PC1163-8460-XP.flightsafety.com>
 <20050930081701.GB27423@calimero.vinschen.de>
 <Pine.CYG.4.58.0509300947210.2244@PC1163-8460-XP.flightsafety.com>
 <20050930200048.GE12256@calimero.vinschen.de>
 <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com>
 <20051003165358.GA4436@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q4/txt/msg00001.txt.bz2

On Mon, 3 Oct 2005, Corinna Vinschen wrote:

> On Sep 30 18:39, Brian Ford wrote:
> > On Fri, 30 Sep 2005, Corinna Vinschen wrote:
> > > Actually we have two states, applications built before we changed the
> > > header file and applications built after we changed the header file.
> >
> > Let's just not change it ;-).
>
> No, let's change it.  Winsock2 is the way to go.  Winsock1 is just old
> stuff.  Since Cygwin is using Winsock2 when running on a 98 system or
> above, and since applications using the old/wrong Winsock1 values are
> broken right now anyway, there's no gain to keep the old values and
> force all new (and supposed to be working) applications to go through
> a translation stage.  Let the old applications suffer, not the new ones.

That's a reasonably convincing argument.  I just wish fixing this didn't
require an application recompile.  I didn't think that was the Cygwin
philosophy...<time passes>  Oh, you mean do the translation only for older
apps?  That sounds good.

> > > This is visible by an internal version number maintained by Cygwin.
> >
> > Ok, I'm not aware of how that works.
>
> vi winsup/cygwin/include/cygwin/version.h
> /CYGWIN_VERSION_CHECK

Thanks, I'll look into that.

> > Ok, here's an untested (as yet) patch:

After thinking about this over the weekend, the untested part of this
bothers me.  I've noticed that IP_MULTICAST_IF isn't working, but I've
also seen that IP_ADD_MEMBERSHIP appears to be working.  That doesn't make
any sense from the MSDN KB article, and I am checking the error status of
setsockopt.  Let me actually test this to see how I can explain the
appearant discrepency.

> Er... didn't you say somthing along the lines of "concept first, code later"?

I was trying to approach this from the trivial bug fix point of view
instead.  I was hoping if you saw the non-intrusive nature of the fix,
it might be considered before 1.5.21 :-).

> > > I want to drop Winsock1 support nevertheless.  It only complicates the
> > > code and has no real gain.
> >
> > I think I'll let you handle that one ;-).
>
> Sigh.

What's the big deal?  Isn't it just deleting a bunch of code and changing
the headers then?  I guess I have to figure out how to use the version
magic to determine when old apps need the translation...

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...

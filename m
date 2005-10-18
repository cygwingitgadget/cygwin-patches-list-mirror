Return-Path: <cygwin-patches-return-5663-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3765 invoked by alias); 18 Oct 2005 14:32:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3693 invoked by uid 22791); 18 Oct 2005 14:32:18 -0000
Received: from mailgw02.flightsafety.com (HELO mailgw02.flightsafety.com) (66.109.90.21)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 18 Oct 2005 14:32:18 +0000
Received: from mailgw02.flightsafety.com (localhost [127.0.0.1])
	by mailgw02.flightsafety.com (8.13.1/8.13.1) with ESMTP id j9IEUnZH011492
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2005 10:30:49 -0400 (EDT)
Received: from VXS3.flightsafety.com (internal-31-147.flightsafety.com [192.168.31.147])
	by mailgw02.flightsafety.com (8.13.1/8.13.1) with ESMTP id j9IEUmpD011489
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2005 10:30:49 -0400 (EDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Oct 2005 10:32:15 -0400
Received: from PC1163-8460-XP.flightsafety.com ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Oct 2005 09:32:14 -0500
Date: Tue, 18 Oct 2005 14:32:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: IP_MULTICAST_IF et all / Winsock[2] value conflict
In-Reply-To: <20051017212639.GA19398@calimero.vinschen.de>
Message-ID: <Pine.CYG.4.58.0510180920540.3344@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0509291103421.2244@PC1163-8460-XP.flightsafety.com>
 <20050929165053.GU12256@calimero.vinschen.de>
 <Pine.CYG.4.58.0509291152490.2244@PC1163-8460-XP.flightsafety.com>
 <20050930081701.GB27423@calimero.vinschen.de>
 <Pine.CYG.4.58.0509300947210.2244@PC1163-8460-XP.flightsafety.com>
 <20050930200048.GE12256@calimero.vinschen.de>
 <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com>
 <20051003165358.GA4436@calimero.vinschen.de>
 <Pine.CYG.4.58.0510031213250.1904@PC1163-8460-XP.flightsafety.com>
 <20051017212639.GA19398@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q4/txt/msg00005.txt.bz2

On Mon, 17 Oct 2005, Corinna Vinschen wrote:
> On Oct  3 12:25, Brian Ford wrote:
> > On Mon, 3 Oct 2005, Corinna Vinschen wrote:
> > > No, let's change it.  Winsock2 is the way to go.  Winsock1 is just old
> > > stuff.  Since Cygwin is using Winsock2 when running on a 98 system or
> > > above,

In some ways, I now believe this was not exactly true.

It appeared that [set|get]sockopt was formerly autoloaded from wsock32, so
maybe the values were correct.  When I tried to investigate this further,
I got really confused about how this was supposed to work together.

Neither of the two possible values for IP_MULTICAST_IF seemed to work
correctly in my limited testing.  But, at the same time, changing the
values for IP_ADD_MEMBERSHIP did not exhibit the failure described in the
MSDN KB article either?  At this point, I ran out of time and my test
system was shipped to a demo :-(.

> > > and since applications using the old/wrong Winsock1 values are
> > > broken right now anyway, there's no gain to keep the old values and
> > > force all new (and supposed to be working) applications to go through
> > > a translation stage.  Let the old applications suffer, not the new ones.
> >
> > That's a reasonably convincing argument.  I just wish fixing this didn't
> > require an application recompile.  I didn't think that was the Cygwin
> > philosophy...<time passes>  Oh, you mean do the translation only for older
> > apps?  That sounds good.
>
> I've just applied a patch, which does all of that, removing the last remains
> of Winsock1 support, as well as changing the IPPROTO_IP values in
> include/cygwin/socket.h to the new Winsock2 values, as well as checking
> for the applications ABI version number so that older applications get
> the values translated into the new Winsock2 values in setsockopt/getsockopt
> on the fly.

Thank you.  I didn't really mean for you to have to do it, but I haven't
had time to get back into the confusion.

> This still needs some testing.

As soon as my demo system comes back (next week or the week after), I'll
do so.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...

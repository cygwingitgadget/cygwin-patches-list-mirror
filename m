Return-Path: <cygwin-patches-return-5658-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23248 invoked by alias); 3 Oct 2005 16:54:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23239 invoked by uid 22791); 3 Oct 2005 16:54:04 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 03 Oct 2005 16:54:04 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 45DF0245DA
	for <cygwin-patches@cygwin.com>; Mon,  3 Oct 2005 18:54:00 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id 6F9BAAB130
	for <cygwin-patches@cygwin.com>; Mon,  3 Oct 2005 18:53:59 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F3896544122; Mon,  3 Oct 2005 18:53:58 +0200 (CEST)
Date: Mon, 03 Oct 2005 16:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: IP_MULTICAST_IF et all / Winsock[2] value conflict
Message-ID: <20051003165358.GA4436@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0509291103421.2244@PC1163-8460-XP.flightsafety.com> <20050929165053.GU12256@calimero.vinschen.de> <Pine.CYG.4.58.0509291152490.2244@PC1163-8460-XP.flightsafety.com> <20050930081701.GB27423@calimero.vinschen.de> <Pine.CYG.4.58.0509300947210.2244@PC1163-8460-XP.flightsafety.com> <20050930200048.GE12256@calimero.vinschen.de> <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q4/txt/msg00000.txt.bz2

On Sep 30 18:39, Brian Ford wrote:
> On Fri, 30 Sep 2005, Corinna Vinschen wrote:
> > On Sep 30 10:07, Brian Ford wrote:
> > > We can simply translate the current constant Winsock 1 values to Winsock 2
> > > ones when necessary in cygwin_[set|get]sockopt.  There are only 8 values
> > > that need changing, I think.
> >
> > Yeah, I think that we can basically do something like this.  But we
> > should not try to guess what the application really meant to do
> > based on the incoming value and the winsock version in use.
> 
> Why not?  There is no guessing involved if we do not change Cygwin's
> system headers.  If someone used a Windows header directly and called the
> Cygwin [set|get]sockopt, well then..., that's their fault.

That's not supported anyway.

> > Actually we have two states, applications built before we changed the
> > header file and applications built after we changed the header file.
> 
> Let's just not change it ;-).

No, let's change it.  Winsock2 is the way to go.  Winsock1 is just old
stuff.  Since Cygwin is using Winsock2 when running on a 98 system or
above, and since applications using the old/wrong Winsock1 values are
broken right now anyway, there's no gain to keep the old values and
force all new (and supposed to be working) applications to go through
a translation stage.  Let the old applications suffer, not the new ones.

> > This is visible by an internal version number maintained by Cygwin.
> 
> Ok, I'm not aware of how that works.

vi winsup/cygwin/include/cygwin/version.h
/CYGWIN_VERSION_CHECK

> Ok, here's an untested (as yet) patch:
> 
> 2005-09-30  Brian Ford  <Brian.Ford@FlightSafety.com>
> 
> 	* net.cc (ws2ip_optname): New function to convert IP_* socket
> 	options from Winsock 1.1 values to Winsock 2 ones.
> 	(cygwin_setsockopt): Use it.
> 	(cygwin_getsockopt): Likewise.

Er... didn't you say somthing along the lines of "concept first, code later"?

> > I want to drop Winsock1 support nevertheless.  It only complicates the
> > code and has no real gain.
> 
> I think I'll let you handle that one ;-).

Sigh.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.

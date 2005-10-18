Return-Path: <cygwin-patches-return-5664-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13224 invoked by alias); 18 Oct 2005 14:45:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13166 invoked by uid 22791); 18 Oct 2005 14:45:01 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 18 Oct 2005 14:45:01 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 9B36E245CD
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2005 16:44:58 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id CF757AAFF8
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2005 16:44:57 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BA60E544122; Tue, 18 Oct 2005 16:44:57 +0200 (CEST)
Date: Tue, 18 Oct 2005 14:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: IP_MULTICAST_IF et all / Winsock[2] value conflict
Message-ID: <20051018144457.GJ32583@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050929165053.GU12256@calimero.vinschen.de> <Pine.CYG.4.58.0509291152490.2244@PC1163-8460-XP.flightsafety.com> <20050930081701.GB27423@calimero.vinschen.de> <Pine.CYG.4.58.0509300947210.2244@PC1163-8460-XP.flightsafety.com> <20050930200048.GE12256@calimero.vinschen.de> <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com> <20051003165358.GA4436@calimero.vinschen.de> <Pine.CYG.4.58.0510031213250.1904@PC1163-8460-XP.flightsafety.com> <20051017212639.GA19398@calimero.vinschen.de> <Pine.CYG.4.58.0510180920540.3344@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0510180920540.3344@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q4/txt/msg00006.txt.bz2

On Oct 18 09:32, Brian Ford wrote:
> On Mon, 17 Oct 2005, Corinna Vinschen wrote:
> > On Oct  3 12:25, Brian Ford wrote:
> > > On Mon, 3 Oct 2005, Corinna Vinschen wrote:
> > > > No, let's change it.  Winsock2 is the way to go.  Winsock1 is just old
> > > > stuff.  Since Cygwin is using Winsock2 when running on a 98 system or
> > > > above,
> 
> In some ways, I now believe this was not exactly true.
> 
> It appeared that [set|get]sockopt was formerly autoloaded from wsock32, so
> maybe the values were correct.  When I tried to investigate this further,
> I got really confused about how this was supposed to work together.
> 
> Neither of the two possible values for IP_MULTICAST_IF seemed to work
> correctly in my limited testing.  But, at the same time, changing the
> values for IP_ADD_MEMBERSHIP did not exhibit the failure described in the
> MSDN KB article either?  At this point, I ran out of time and my test
> system was shipped to a demo :-(.

I can't comment on your tests which would have required some debugging
*and* additionally looking into Microsoft's knowledge base.  Maybe
there's some similar registry tweak necessary as in the case of using
IP_TOS on Win2K and above.  Or something.

What I can comment about is what happened when loading set/getsockopt.
Regardless of being dynamically loaded from wsock32 or ws2_32, they
will always be the Winsock2 version on a Winsock2 system.  wsock32 is
more or less just a stub which redirects function calls to ws2_32.dll.

However, I hope that's a non-issue now that Winsock1 has been dropped.

> > I've just applied a patch, which does all of that, removing the last remains
> > of Winsock1 support, as well as changing the IPPROTO_IP values in
> > include/cygwin/socket.h to the new Winsock2 values, as well as checking
> > for the applications ABI version number so that older applications get
> > the values translated into the new Winsock2 values in setsockopt/getsockopt
> > on the fly.
> 
> Thank you.  I didn't really mean for you to have to do it, but I haven't
> had time to get back into the confusion.

No worries.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.

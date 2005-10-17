Return-Path: <cygwin-patches-return-5662-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16575 invoked by alias); 17 Oct 2005 21:26:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16556 invoked by uid 22791); 17 Oct 2005 21:26:43 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 17 Oct 2005 21:26:43 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id C3BE3245D3
	for <cygwin-patches@cygwin.com>; Mon, 17 Oct 2005 23:26:40 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id 25D1EAAFF5
	for <cygwin-patches@cygwin.com>; Mon, 17 Oct 2005 23:26:40 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F38D8544122; Mon, 17 Oct 2005 23:26:39 +0200 (CEST)
Date: Mon, 17 Oct 2005 21:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: IP_MULTICAST_IF et all / Winsock[2] value conflict
Message-ID: <20051017212639.GA19398@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0509291103421.2244@PC1163-8460-XP.flightsafety.com> <20050929165053.GU12256@calimero.vinschen.de> <Pine.CYG.4.58.0509291152490.2244@PC1163-8460-XP.flightsafety.com> <20050930081701.GB27423@calimero.vinschen.de> <Pine.CYG.4.58.0509300947210.2244@PC1163-8460-XP.flightsafety.com> <20050930200048.GE12256@calimero.vinschen.de> <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com> <20051003165358.GA4436@calimero.vinschen.de> <Pine.CYG.4.58.0510031213250.1904@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0510031213250.1904@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q4/txt/msg00004.txt.bz2

On Oct  3 12:25, Brian Ford wrote:
> On Mon, 3 Oct 2005, Corinna Vinschen wrote:
> 
> > On Sep 30 18:39, Brian Ford wrote:
> > > On Fri, 30 Sep 2005, Corinna Vinschen wrote:
> > > > Actually we have two states, applications built before we changed the
> > > > header file and applications built after we changed the header file.
> > >
> > > Let's just not change it ;-).
> >
> > No, let's change it.  Winsock2 is the way to go.  Winsock1 is just old
> > stuff.  Since Cygwin is using Winsock2 when running on a 98 system or
> > above, and since applications using the old/wrong Winsock1 values are
> > broken right now anyway, there's no gain to keep the old values and
> > force all new (and supposed to be working) applications to go through
> > a translation stage.  Let the old applications suffer, not the new ones.
> 
> That's a reasonably convincing argument.  I just wish fixing this didn't
> require an application recompile.  I didn't think that was the Cygwin
> philosophy...<time passes>  Oh, you mean do the translation only for older
> apps?  That sounds good.

I've just applied a patch, which does all of that, removing the last remains
of Winsock1 support, as well as changing the IPPROTO_IP values in
include/cygwin/socket.h to the new Winsock2 values, as well as checking
for the applications ABI version number so that older applications get
the values translated into the new Winsock2 values in setsockopt/getsockopt
on the fly.

This still needs some testing.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.

Return-Path: <cygwin-patches-return-5666-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16230 invoked by alias); 18 Oct 2005 19:15:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16207 invoked by uid 22791); 18 Oct 2005 19:15:12 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 18 Oct 2005 19:15:12 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 6F065245D3
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2005 21:15:07 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id 1D026AAFF8
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2005 21:15:07 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EE3DC544122; Tue, 18 Oct 2005 21:15:06 +0200 (CEST)
Date: Tue, 18 Oct 2005 19:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: IP_MULTICAST_IF et all / Winsock[2] value conflict
Message-ID: <20051018191506.GK32583@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050930081701.GB27423@calimero.vinschen.de> <Pine.CYG.4.58.0509300947210.2244@PC1163-8460-XP.flightsafety.com> <20050930200048.GE12256@calimero.vinschen.de> <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com> <20051003165358.GA4436@calimero.vinschen.de> <Pine.CYG.4.58.0510031213250.1904@PC1163-8460-XP.flightsafety.com> <20051017212639.GA19398@calimero.vinschen.de> <Pine.CYG.4.58.0510180920540.3344@PC1163-8460-XP.flightsafety.com> <20051018144457.GJ32583@calimero.vinschen.de> <Pine.CYG.4.58.0510181352240.3344@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0510181352240.3344@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q4/txt/msg00008.txt.bz2

On Oct 18 13:56, Brian Ford wrote:
> On Tue, 18 Oct 2005, Corinna Vinschen wrote:
> 
> > What I can comment about is what happened when loading set/getsockopt.
> > Regardless of being dynamically loaded from wsock32 or ws2_32, they
> > will always be the Winsock2 version on a Winsock2 system.  wsock32 is
> > more or less just a stub which redirects function calls to ws2_32.dll.
> 
> Agreed, but I was under the impression that the wsock32 stub should have
> been doing the translation for us.  Otherwise, an application designed
> to work with wsock32 would be using incorrect values.

Not really.  Just read the MSDN man page of WSAStartup and there will
be light :-)  (well, sort of.  The description is a bit... convoluted)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.

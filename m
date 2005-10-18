Return-Path: <cygwin-patches-return-5665-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28889 invoked by alias); 18 Oct 2005 18:56:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28870 invoked by uid 22791); 18 Oct 2005 18:56:39 -0000
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 18 Oct 2005 18:56:39 +0000
Received: from mailgw01n.flightsafety.com (localhost [127.0.0.1])
	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id j9IItoZM027505
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2005 14:55:51 -0400 (EDT)
Received: from VXS3.flightsafety.com (internal-31-147.flightsafety.com [192.168.31.147])
	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id j9IItocb027501
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2005 14:55:50 -0400 (EDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Oct 2005 14:56:36 -0400
Received: from PC1163-8460-XP.flightsafety.com ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Oct 2005 13:56:35 -0500
Date: Tue, 18 Oct 2005 18:56:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: IP_MULTICAST_IF et all / Winsock[2] value conflict
In-Reply-To: <20051018144457.GJ32583@calimero.vinschen.de>
Message-ID: <Pine.CYG.4.58.0510181352240.3344@PC1163-8460-XP.flightsafety.com>
References: <20050929165053.GU12256@calimero.vinschen.de>
 <Pine.CYG.4.58.0509291152490.2244@PC1163-8460-XP.flightsafety.com>
 <20050930081701.GB27423@calimero.vinschen.de>
 <Pine.CYG.4.58.0509300947210.2244@PC1163-8460-XP.flightsafety.com>
 <20050930200048.GE12256@calimero.vinschen.de>
 <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com>
 <20051003165358.GA4436@calimero.vinschen.de>
 <Pine.CYG.4.58.0510031213250.1904@PC1163-8460-XP.flightsafety.com>
 <20051017212639.GA19398@calimero.vinschen.de>
 <Pine.CYG.4.58.0510180920540.3344@PC1163-8460-XP.flightsafety.com>
 <20051018144457.GJ32583@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q4/txt/msg00007.txt.bz2

On Tue, 18 Oct 2005, Corinna Vinschen wrote:

> What I can comment about is what happened when loading set/getsockopt.
> Regardless of being dynamically loaded from wsock32 or ws2_32, they
> will always be the Winsock2 version on a Winsock2 system.  wsock32 is
> more or less just a stub which redirects function calls to ws2_32.dll.

Agreed, but I was under the impression that the wsock32 stub should have
been doing the translation for us.  Otherwise, an application designed
to work with wsock32 would be using incorrect values.

> However, I hope that's a non-issue now that Winsock1 has been dropped.

I hope so too.  I'll test as soon as it is possible.  Thanks again.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...

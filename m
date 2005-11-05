Return-Path: <cygwin-patches-return-5673-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13354 invoked by alias); 5 Nov 2005 21:28:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13343 invoked by uid 22791); 5 Nov 2005 21:28:41 -0000
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 05 Nov 2005 21:28:41 +0000
Received: from mailgw01n.flightsafety.com (localhost [127.0.0.1])
	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id jA5LRsU6029378
	for <cygwin-patches@cygwin.com>; Sat, 5 Nov 2005 16:27:54 -0500 (EST)
Received: from xgate2k3.flightsafety.com ([192.168.31.134])
	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id jA5LRrfs029375
	for <cygwin-patches@cygwin.com>; Sat, 5 Nov 2005 16:27:54 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 5 Nov 2005 16:28:37 -0500
Received: from PC1163-8460-XP.flightsafety.com ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 5 Nov 2005 15:28:37 -0600
Date: Sat, 05 Nov 2005 21:28:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Translate INSUFFICIENT_RESOURCES errno
In-Reply-To: <20051105191713.GA24715@trixie.casa.cgf.cx>
Message-ID: <Pine.CYG.4.58.0511051518280.508@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0511051037180.508@PC1163-8460-XP.flightsafety.com>
 <20051105191713.GA24715@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q4/txt/msg00015.txt.bz2

On Sat, 5 Nov 2005, Christopher Faylor wrote:
> On Sat, Nov 05, 2005 at 10:41:35AM -0600, Brian Ford wrote:
> >	* errno.cc (errmap): Handle INSUFFICIENT_RESOURCES.
>
> I don't see an ERROR_INSUFFICIENT_RESOURCES

Um..., nevermind.  Mea culpa.  Sorry to waste your time.

That corresponds to 1450 NO_SYSTEM_RESOURCES which is already present.
Tar must have gotten a different error (which I've seen before, but have
now forgotten :-().

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...

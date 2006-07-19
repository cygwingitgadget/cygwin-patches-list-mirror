Return-Path: <cygwin-patches-return-5933-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5723 invoked by alias); 19 Jul 2006 14:57:53 -0000
Received: (qmail 5711 invoked by uid 22791); 19 Jul 2006 14:57:52 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw03.flightsafety.com (HELO mailgw03.flightsafety.com) (66.109.93.20)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Jul 2006 14:57:42 +0000
Received: from mailgw03.flightsafety.com (localhost [127.0.0.1]) 	by mailgw03.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6JEtmrB012032 	for <cygwin-patches@cygwin.com>; Wed, 19 Jul 2006 09:55:48 -0500 (CDT)
Received: from xgate2k3.flightsafety.com ([192.168.31.134]) 	by mailgw03.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6JEtlY8012024 	for <cygwin-patches@cygwin.com>; Wed, 19 Jul 2006 09:55:48 -0500 (CDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 19 Jul 2006 10:57:58 -0400
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 19 Jul 2006 09:57:56 -0500
Date: Wed, 19 Jul 2006 14:57:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
In-Reply-To: <20060719025102.GA2980@trixie.casa.cgf.cx>
Message-ID: <Pine.CYG.4.58.0607190949460.3164@PC1163-8460-XP.flightsafety.com>
References: <20060713103431.GA17383@calimero.vinschen.de>  <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com>  <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com>  <20060714091601.GD8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com>  <20060714155523.GL8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com>  <20060717204739.GA27029@calimero.vinschen.de>  <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com>  <Pine.CYG.4.58.0607180814370.3164@PC1163-8460-XP.flightsafety.com>  <20060719025102.GA2980@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00028.txt.bz2

On Tue, 18 Jul 2006, Christopher Faylor wrote:

> On Tue, Jul 18, 2006 at 08:22:38AM -0500, Brian Ford wrote:
>
> >I guess I can infer from cgf's mail to cygwin-developers that this will
> >not make it into 1.5.21 :-(.
>
> I guess the fact that Corinna mentioned installing this into a branch
> wasn't a big enough hint?

On Tue, 18 Jul 2006, Brian Ford wrote:

> Appologies for the previous message being un-timely.  We had a network
> outage, and it got queued before your response.

The quoted your referred to Corinna's response saying she checked it into
the cv-branch.  No hint required.

BTW, I've given up trying extra hard to qualify and properly phrase
everything I say to you guys.  It's too hard and it doesn't work anyway.
Just understand that I never mean to be complaining, derogatory, or
stupid (although sometimes the latter happens anyway ;-).

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...

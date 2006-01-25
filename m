Return-Path: <cygwin-patches-return-5723-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21738 invoked by alias); 25 Jan 2006 14:51:15 -0000
Received: (qmail 21724 invoked by uid 22791); 25 Jan 2006 14:51:12 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw02.flightsafety.com (HELO mailgw02.flightsafety.com) (66.109.90.21)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 25 Jan 2006 14:51:11 +0000
Received: from mailgw02.flightsafety.com (localhost [127.0.0.1]) 	by mailgw02.flightsafety.com (8.13.1/8.13.1) with ESMTP id k0PEnWux023337 	for <cygwin-patches@cygwin.com>; Wed, 25 Jan 2006 09:49:32 -0500 (EST)
Received: from xgate2k3.flightsafety.com ([192.168.31.134]) 	by mailgw02.flightsafety.com (8.13.1/8.13.1) with ESMTP id k0PEnUOc023315 	for <cygwin-patches@cygwin.com>; Wed, 25 Jan 2006 09:49:32 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 25 Jan 2006 09:51:34 -0500
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 25 Jan 2006 08:51:33 -0600
Date: Wed, 25 Jan 2006 14:51:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
In-Reply-To: <Pine.GSO.4.63.0601250907210.2078@access1.cims.nyu.edu>
Message-ID: <Pine.CYG.4.58.0601250849500.3176@PC1163-8460-XP.flightsafety.com>
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de>  <Pine.GSO.4.63.0601250907210.2078@access1.cims.nyu.edu>
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
X-SW-Source: 2006-q1/txt/msg00032.txt.bz2

On Wed, 25 Jan 2006, Igor Peshansky wrote:

> I'm not aware of any program that does the reverse (hex dump->binary),
> but writing a perl script for that is trivial.

xxd -r ;-).

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...

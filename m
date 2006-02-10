Return-Path: <cygwin-patches-return-5741-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26536 invoked by alias); 10 Feb 2006 23:55:24 -0000
Received: (qmail 26525 invoked by uid 22791); 10 Feb 2006 23:55:23 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 10 Feb 2006 23:55:22 +0000
Received: from mailgw01n.flightsafety.com (localhost [127.0.0.1]) 	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id k1ANss7H011269 	for <cygwin-patches@cygwin.com>; Fri, 10 Feb 2006 18:54:54 -0500 (EST)
Received: from xgate2k3.flightsafety.com ([192.168.31.134]) 	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id k1ANsrtJ011263 	for <cygwin-patches@cygwin.com>; Fri, 10 Feb 2006 18:54:53 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 10 Feb 2006 18:56:09 -0500
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 10 Feb 2006 17:56:08 -0600
Date: Fri, 10 Feb 2006 23:55:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: clock_[get|set]res timespec conversions
In-Reply-To: <Pine.CYG.4.58.0602101743300.1780@PC1163-8460-XP.flightsafety.com>
Message-ID: <Pine.CYG.4.58.0602101755480.1780@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0602101743300.1780@PC1163-8460-XP.flightsafety.com>
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
X-SW-Source: 2006-q1/txt/msg00050.txt.bz2

I said it was late.  Oh, well.

Make that clock_[get|set]RES...

On Fri, 10 Feb 2006, Brian Ford wrote:

> It's late and I haven't had time to test this, but I thought it deserved a
> look.  There appears to be some confusion (at least in my head) about the
> units of gtod.resolution() and minperiod.
>
> 2006-02-10  Brian Ford  <Brian.Ford@FlightSafety.com>
>
> 	* times.cc (clock_getres): Properly convert ms period to struct
> 	timespec.
> 	(clock_setres): Likewise reverse convert.
>
> Let me know if I'm just crazy ;-).  Thanks.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...

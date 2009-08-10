Return-Path: <cygwin-patches-return-6591-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25568 invoked by alias); 10 Aug 2009 14:44:30 -0000
Received: (qmail 25449 invoked by uid 22791); 10 Aug 2009 14:44:28 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0 	tests=AWL,BAYES_05,J_CHICKENPOX_42
X-Spam-Check-By: sourceware.org
Received: from mailgw.c5altus.com (HELO mailgw02.flightsafety.com) (66.109.90.21)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 10 Aug 2009 14:44:21 +0000
Received: from mailgw02.flightsafety.com (localhost [127.0.0.1]) 	by localhost (Postfix) with SMTP id 39E532DACDA 	for <cygwin-patches@cygwin.com>; Mon, 10 Aug 2009 10:44:19 -0400 (EDT)
Received: from VXS2.flightsafety.com (unknown [192.168.31.146]) 	by mailgw02.flightsafety.com (Postfix) with ESMTP id 2795D2DACC3 	for <cygwin-patches@cygwin.com>; Mon, 10 Aug 2009 10:44:19 -0400 (EDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS2.flightsafety.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Mon, 10 Aug 2009 10:44:18 -0400
Received: from fordpc ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Mon, 10 Aug 2009 09:44:18 -0500
Date: Mon, 10 Aug 2009 14:44:00 -0000
From: Brian Ford <Brian.Ford@FlightSafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCHes] Misc aliasing fixes for building DLL with gcc-4.5.0
In-Reply-To: <4A7FA1E0.7070209@gmail.com>
Message-ID: <Pine.CYG.4.58.0908100940080.2736@PC1163-8460-XP.flightsafety.com>
References: <4A7F8FF5.5060701@gmail.com> <20090810040452.GB610@ednor.casa.cgf.cx>  <4A7FA1E0.7070209@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00045.txt.bz2

On Mon, 10 Aug 2009, Dave Korn wrote:

> Christopher Faylor wrote:
> > On Mon, Aug 10, 2009 at 04:11:49AM +0100, Dave Korn wrote:
> >
> >> 	* fork.cc (cygfork): New name with friendable C++ linkage for ...
> >> 	(fork): ... un-friendable extern "C" function becomes stub calling it.
> >> 	(class frok): Declare cygfork() friend, not fork(), avoiding PR41020.
> >
> > Also, referring to a bug without explaining what the problem either in
> > the source code or the ChangeLog is a guaranteed way to cause confusion
> > tomorrow after a memory cache refresh.
>
>   You mean the PR notation?  Hopefully GCC's bugzilla will still be there
> tomorrow!  Anyway, with a bit of luck we won't end up needing this one at all.

From my point of view, adding GCC in front of PR41020 would help someone
who tries to figure out what this means years down the road.  Without the
other context of this thread, I would not have any idea what software that
PR applied to.

-- 
Brian Ford
Staff Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...

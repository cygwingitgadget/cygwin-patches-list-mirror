Return-Path: <cygwin-patches-return-6027-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22292 invoked by alias); 3 Jan 2007 15:56:17 -0000
Received: (qmail 22281 invoked by uid 22791); 3 Jan 2007 15:56:17 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw02.flightsafety.com (HELO mailgw02.flightsafety.com) (66.109.90.21)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 03 Jan 2007 15:56:05 +0000
Received: from mailgw02.flightsafety.com (localhost [127.0.0.1]) 	by localhost (Postfix) with SMTP id 0FC0A4AF56 	for <cygwin-patches@cygwin.com>; Wed,  3 Jan 2007 10:54:38 -0500 (EST)
Received: from xgate2k3.flightsafety.com (unknown [192.168.31.134]) 	by mailgw02.flightsafety.com (Postfix) with ESMTP id B7CA04AF54 	for <cygwin-patches@cygwin.com>; Wed,  3 Jan 2007 10:54:37 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 3 Jan 2007 10:56:02 -0500
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 3 Jan 2007 09:56:01 -0600
Date: Wed, 03 Jan 2007 15:56:00 -0000
From: Brian Ford <Brian.Ford@FlightSafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
In-Reply-To: <20070103133557.GC4106@calimero.vinschen.de>
Message-ID: <Pine.CYG.4.58.0701030944070.2464@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com>  <20070102184551.GA18182@trixie.casa.cgf.cx>  <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com>  <20070103121620.GB4106@calimero.vinschen.de> <459BADB3.7080705@byu.net>  <20070103133557.GC4106@calimero.vinschen.de>
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
X-SW-Source: 2007-q1/txt/msg00008.txt.bz2

On Wed, 3 Jan 2007, Corinna Vinschen wrote:

> So it appears to make much sense to set the blocksize to 64K.

blocksize is not really the proper term here as it is very confusing.
Preferred or optimal I/O size is a better choice in my opinion.

> The only question would be whether to use getpagesize() or a hard coded
> value.  It seems to me that the 64K allocation granularity and using 64K
> as buffer size in disk I/O coincide so I tend to agree that it makes
> sort of sense to use getpagesize at this point.

More supporting evidence from
http://research.microsoft.com/BARC/Sequential_IO/Win2K_IO_MSTR_2000_55.doc :

...each (8KB) buffered random write is actually a 64KB random read and
then an 8KB write.  When a buffered write request is received, the cache
manager memory maps a 256KB view into the file. It then pages in the 64KB
frame continuing the changed 8KB, and modifies that 8KB of data.  This
means that for each buffered random write includes one or more 64KB reads.
The right side of Figure 11 shows this 100% IO penalty.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...


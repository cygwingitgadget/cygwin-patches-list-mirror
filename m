Return-Path: <cygwin-patches-return-5942-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27211 invoked by alias); 27 Jul 2006 00:15:30 -0000
Received: (qmail 27200 invoked by uid 22791); 27 Jul 2006 00:15:29 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw04.flightsafety.com (HELO mailgw04.flightsafety.com) (66.109.93.21)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 27 Jul 2006 00:15:20 +0000
Received: from mailgw04.flightsafety.com (localhost [127.0.0.1]) 	by mailgw04.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6R0AwCg001916 	for <cygwin-patches@cygwin.com>; Wed, 26 Jul 2006 20:10:58 -0400 (EDT)
Received: from VXS3.flightsafety.com ([192.168.93.147]) 	by mailgw04.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6R0AvHZ001911 	for <cygwin-patches@cygwin.com>; Wed, 26 Jul 2006 20:10:58 -0400 (EDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 26 Jul 2006 20:15:38 -0400
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 26 Jul 2006 19:15:37 -0500
Date: Thu, 27 Jul 2006 00:15:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: check_iovec cleanup
In-Reply-To: <20060726232029.GB5680@trixie.casa.cgf.cx>
Message-ID: <Pine.CYG.4.58.0607261823240.1740@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0607261730550.2352@PC1163-8460-XP.flightsafety.com>  <20060726232029.GB5680@trixie.casa.cgf.cx>
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
X-SW-Source: 2006-q3/txt/msg00037.txt.bz2

On Wed, 26 Jul 2006, Christopher Faylor wrote:

> Thanks for the patch,

Thanks for the review.

> but I'm not convinced that this patch duplicates the functionality that
> you eliminated from check_iovec.

It doesn't exactly, but the part it doesn't didn't seem correct.  See
below.

> And, the dummytest is actually there for a reason.

Ok, then what *is* the reason for checking only the last byte of each
iovec buffer for read or write-ability?  Doesn't it need to check a byte
on every system page to be complete (because buffers could start in or
span across invalid/protected virtual addresses)?  Should an error be
flagged if the readv wouldn't have actually accessed the invalid addresses
(I'm not sure here)?

After my patch, if the iovec buffer addresses are invalid, they will
either be flagged as such by the underlying Windows system call, or they
will trigger the fault handler installed above by all check_iovec callers
if the cygwin DLL code tries to access them, no?

> It is not "more straighforward" to move a check out of a function and
> duplicate it in callers of the function.

Agreed in general, and straight forward may have been a poor choice of
words.  However, the other two callers [send|recv]msg already needed this
type of fault handling for other reasons.  So, to avoid doubling up
there, and given the reasoning above, I thought that being consistent,
covering a few missed (but admittedly rare cases), and a minuscule
performance/elegance improvement to the general case justified the
change.

Maybe not.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...

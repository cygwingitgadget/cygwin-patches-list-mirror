Return-Path: <cygwin-patches-return-6021-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4714 invoked by alias); 2 Jan 2007 19:49:19 -0000
Received: (qmail 4701 invoked by uid 22791); 2 Jan 2007 19:49:19 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 02 Jan 2007 19:49:04 +0000
Received: from mailgw01n.flightsafety.com (localhost [127.0.0.1]) 	by localhost (Postfix) with SMTP id 6FBAC98C74 	for <cygwin-patches@cygwin.com>; Tue,  2 Jan 2007 14:49:27 -0500 (EST)
Received: from xgate2k3.flightsafety.com (unknown [192.168.31.134]) 	by mailgw01n.flightsafety.com (Postfix) with ESMTP id 2AF1898C73 	for <cygwin-patches@cygwin.com>; Tue,  2 Jan 2007 14:49:27 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 2 Jan 2007 14:49:01 -0500
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 2 Jan 2007 13:49:00 -0600
Date: Tue, 02 Jan 2007 19:49:00 -0000
From: Brian Ford <Brian.Ford@FlightSafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
In-Reply-To: <20070102184551.GA18182@trixie.casa.cgf.cx>
Message-ID: <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com>  <20070102184551.GA18182@trixie.casa.cgf.cx>
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
X-SW-Source: 2007-q1/txt/msg00002.txt.bz2

On Tue, 2 Jan 2007, Christopher Faylor wrote:

> I don't see how replacing the constant "S_BLKSIZE" with what seems to be
> an unrelated getpagesize () makes a lot of sense.

The st_blksize field represents the preferred I/O size (in bytes) for the
corresponding file system.  Generally, this is the same as, or a multiple
of the system page size for efficient cache management.  As such, I see
nothing unusual about using that function.

The following document confirms my suspicion that at least NTFS buffered
I/O is done in 64k chunks:

http://research.microsoft.com/BARC/Sequential_IO/seqio.doc

I believe this is a close enough parallel to the allocation granularity to
justify using it directly.

> Assuming that this is a good idea, should S_BLKSIZE be changed directly?

No, S_BLKSIZE represents the actual size of a physical block on disk,
and/or the size of the block units reported in the stat structure.
S_BLKSIZE has historically been 512 bytes.

These are actually two different things.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...


Return-Path: <cygwin-patches-return-6029-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3255 invoked by alias); 4 Jan 2007 09:19:59 -0000
Received: (qmail 3243 invoked by uid 22791); 4 Jan 2007 09:19:59 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 04 Jan 2007 09:19:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 666F16D42FF; Thu,  4 Jan 2007 10:19:51 +0100 (CET)
Date: Thu, 04 Jan 2007 09:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
Message-ID: <20070104091951.GA410@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com> <20070102184551.GA18182@trixie.casa.cgf.cx> <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com> <20070103121620.GB4106@calimero.vinschen.de> <459BADB3.7080705@byu.net> <20070103133557.GC4106@calimero.vinschen.de> <Pine.CYG.4.58.0701030944070.2464@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0701030944070.2464@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00010.txt.bz2

On Jan  3 09:56, Brian Ford wrote:
> On Wed, 3 Jan 2007, Corinna Vinschen wrote:
> 
> > So it appears to make much sense to set the blocksize to 64K.
> 
> blocksize is not really the proper term here as it is very confusing.
> Preferred or optimal I/O size is a better choice in my opinion.
> 
> > The only question would be whether to use getpagesize() or a hard coded
> > value.  It seems to me that the 64K allocation granularity and using 64K
> > as buffer size in disk I/O coincide so I tend to agree that it makes
> > sort of sense to use getpagesize at this point.
> 
> More supporting evidence from
> http://research.microsoft.com/BARC/Sequential_IO/Win2K_IO_MSTR_2000_55.doc :
> 
> ...each (8KB) buffered random write is actually a 64KB random read and
> then an 8KB write.  When a buffered write request is received, the cache
> manager memory maps a 256KB view into the file. It then pages in the 64KB
> frame continuing the changed 8KB, and modifies that 8KB of data.  This
> means that for each buffered random write includes one or more 64KB reads.
> The right side of Figure 11 shows this 100% IO penalty.

Interesting.  I just applied a patch along the lines of your patch and
what we discussed in this thread.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

Return-Path: <cygwin-patches-return-7345-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17323 invoked by alias); 12 May 2011 06:51:56 -0000
Received: (qmail 17220 invoked by uid 22791); 12 May 2011 06:51:31 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 06:51:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 320C02C0577; Thu, 12 May 2011 08:51:13 +0200 (CEST)
Date: Thu, 12 May 2011 06:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix /proc/meminfo and /proc/swaps for >4GB
Message-ID: <20110512065113.GA18135@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304708638.5504.5.camel@YAAKOV04> <20110509075514.GB2948@calimero.vinschen.de> <1305172698.4700.0.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1305172698.4700.0.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00111.txt.bz2

On May 11 22:58, Yaakov (Cygwin/X) wrote:
> On Mon, 2011-05-09 at 09:55 +0200, Corinna Vinschen wrote:
> > I'm not sure I understand this new format.  Why do you keep the Mem: and
> > Swap: lines?  Linux doesn't have them and top appears to work without
> > them.  And then, why do you print MemShared, HighTotal, and HighFree,
> > even though they are always 0, but not all the other ~40 lines Linux'
> > meminfo has, too?
> 
> Actually, my patch makes no attempt to change the actual format
> of /proc/meminfo; it changes only what is necessary to handle RAM or
> swap larger than 4GB by using ULLs instead of ULs.

That's fine and thanks for that.  I'm only puzzled what's actually
printed.

> As for modernizing/fixing the format, true, the Mem: and Swap: lines do
> not exist in modern Linux, nor does the MemShared: line.  I would like
> to actually define at least HighTotal and HighFree; I'll try to look
> into that further soon.  As for the rest of Linux's /proc/meminfo, I'll
> have to see how many other lines can be reasonably determined (if they
> would exist at all) on Windows.

That would be cool, but that wasn't what I meant.  I was just puzzled
that you added values which are always 0, but left out others which are
always 0, too.  I was missing a system, kind of.

> So with the ULL changes, if I remove the Mem, Swap, and MemShared lines,
> will that do for now?

Sure.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

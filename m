Return-Path: <cygwin-patches-return-6316-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11796 invoked by alias); 20 Mar 2008 10:35:55 -0000
Received: (qmail 11783 invoked by uid 22791); 20 Mar 2008 10:35:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 20 Mar 2008 10:35:34 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 0F84B6D430A; Thu, 20 Mar 2008 11:35:32 +0100 (CET)
Date: Thu, 20 Mar 2008 10:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
Message-ID: <20080320103532.GO19345@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47E05D34.FCC2E30A@dessent.net> <20080319030027.GC22446@ednor.casa.cgf.cx> <47E137C7.8AE02BC4@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47E137C7.8AE02BC4@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00090.txt.bz2

On Mar 19 08:56, Brian Dessent wrote:
> Christopher Faylor wrote:
> 
> > Sorry, but I don't like this concept.  This bloats the cygwin DLL for a
> > condition that would be better served by either using gdb or generating
> > a real coredump.
> 
> I hear you, but part of the motivation for writing this was a recent
> thread the other week on the gdb list where the poster asked how to get
> symbols in a Cygwin stackdump file.  I suggested the same thing, setting
> error_start=dumper to get a real core dump.  They did, and the result
> was completely useless.  Here is what dumper gives you for the same
> simple testcase:
> [...]
> addr2line also seems to be totally unequipped to deal with separate .dbg
> information, as I can't get it to output a thing even though both a.exe
> and cygwin1.dll have full debug symbols:
> 
> $ addr2line -e a.exe 0x610F74B1
> ??:0

Is it a big problem to fix addr2line to deal with .dbg files?

I like your idea to add names to the stackdump especially because of
addr2line's brokenness.  But, actually, if addr2line would work with
.dbg files, there would be no reason to add this to the stackdump file.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

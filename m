Return-Path: <cygwin-patches-return-6317-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23533 invoked by alias); 20 Mar 2008 14:23:31 -0000
Received: (qmail 23518 invoked by uid 22791); 20 Mar 2008 14:23:30 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-32.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.32)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Mar 2008 14:23:08 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id E64AF2D1D6A; Thu, 20 Mar 2008 10:23:06 -0400 (EDT)
Date: Thu, 20 Mar 2008 14:23:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
Message-ID: <20080320142306.GB28241@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47E05D34.FCC2E30A@dessent.net> <20080319030027.GC22446@ednor.casa.cgf.cx> <47E137C7.8AE02BC4@dessent.net> <20080320103532.GO19345@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080320103532.GO19345@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00091.txt.bz2

On Thu, Mar 20, 2008 at 11:35:32AM +0100, Corinna Vinschen wrote:
>On Mar 19 08:56, Brian Dessent wrote:
>> Christopher Faylor wrote:
>> 
>> > Sorry, but I don't like this concept.  This bloats the cygwin DLL for a
>> > condition that would be better served by either using gdb or generating
>> > a real coredump.
>> 
>> I hear you, but part of the motivation for writing this was a recent
>> thread the other week on the gdb list where the poster asked how to get
>> symbols in a Cygwin stackdump file.  I suggested the same thing, setting
>> error_start=dumper to get a real core dump.  They did, and the result
>> was completely useless.  Here is what dumper gives you for the same
>> simple testcase:
>> [...]
>> addr2line also seems to be totally unequipped to deal with separate .dbg
>> information, as I can't get it to output a thing even though both a.exe
>> and cygwin1.dll have full debug symbols:
>> 
>> $ addr2line -e a.exe 0x610F74B1
>> ??:0
>
>Is it a big problem to fix addr2line to deal with .dbg files?
>
>I like your idea to add names to the stackdump especially because of
>addr2line's brokenness.  But, actually, if addr2line would work with
>.dbg files, there would be no reason to add this to the stackdump file.

There's still the issue of dealing with the separate signal stack.  That
makes stack dumps less than useful.

However, I would really love it if gdb was able to decode this information
automatically.

The bottom line is that I think that rather than modifying cygwin to
work around the limitations of the tools we should be fixing the tools.

But, then, that puts the problem back on my shoulders as the gdb and
binutils maintainer.

PTC.

cgf

Return-Path: <cygwin-patches-return-5935-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7128 invoked by alias); 19 Jul 2006 16:21:28 -0000
Received: (qmail 7115 invoked by uid 22791); 19 Jul 2006 16:21:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 19 Jul 2006 16:21:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D98EF54C006; Wed, 19 Jul 2006 18:21:18 +0200 (CEST)
Date: Wed, 19 Jul 2006 16:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
Message-ID: <20060719162118.GC8056@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060714091601.GD8759@calimero.vinschen.de> <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com> <20060714155523.GL8759@calimero.vinschen.de> <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com> <20060717204739.GA27029@calimero.vinschen.de> <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com> <20060718140704.GC27029@calimero.vinschen.de> <Pine.CYG.4.58.0607181132320.3164@PC1163-8460-XP.flightsafety.com> <20060718201228.GG27029@calimero.vinschen.de> <Pine.CYG.4.58.0607190957540.3164@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607190957540.3164@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00030.txt.bz2

On Jul 19 10:12, Brian Ford wrote:
> On Tue, 18 Jul 2006, Corinna Vinschen wrote:
> > The answer is in list::try_map.  It tries to find a suitable, unused
> > record which can be reused for another mapping.  The idea here is to
> > accomodate old, non-standard implementations which assume that two
> > consecutive mappings are using consecutive pages in memory.  An example
> > are old autoconf tests.  This was more of a problem when getpagesize()
> > was 4K.  Today it will only be used on 9x due to the alignment bug I'm
> > referring to in mmap64.
> 
> Thanks for the constructive information; it is greatly appreciated.  I
> don't totally understand it yet, but I'll study it.

Some of the code has history.  It's not always nice history and, trust
me, I keep forgetting sometimes why I did something, too.  The older I
get, the more I add comments to the code to keep up with my degenerating
memory.  The last iteration of mmap has lots of comments, though.  It
shouldn't be as intransparent as earlier code.

However, if you have further questions about the code, ask on
cygwin-developers, ok?

> I wasn't sure that minor nits and code rearrangements would be accepted as
> patches, or would just be considered insulting.  If the former, I would be
> happy to submit patches that IMHO make the code more readable as I try to
> understand it myself.  (Things like assignments inside conditionals and
> repeated function calls, even if they are inlined, make it harder for me
> to see what's going on.)

Uh, it depends.

Doing stuff like (not) using assignments within conditionals, or (not)
using inline function calls heavily, or names of variables, are simply a
matter of taste.  For instance, I like assignments in conditionals and
they make the code clearer for me.  I won't take a patch which changes
no functionality, but only changes the source code to satisfy a
different coding taste.

If you can do stuff like getting rid of useless code (prove is
necessary) or if you can simplify code by moving something into a
function or method, or if you can optimize functionality by shuffling
code around, then that's almost always fine.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

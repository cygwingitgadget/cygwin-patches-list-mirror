Return-Path: <cygwin-patches-return-6068-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28429 invoked by alias); 18 Apr 2007 13:07:40 -0000
Received: (qmail 28310 invoked by uid 22791); 18 Apr 2007 13:07:38 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 18 Apr 2007 14:07:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D81166D4803; Wed, 18 Apr 2007 15:07:32 +0200 (CEST)
Date: Wed, 18 Apr 2007 13:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] support -gdwarf-2 when creating cygwin1.dbg
Message-ID: <20070418130732.GK5799@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <462612A9.20E19FEB@dessent.net> <20070418125857.GA4589@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070418125857.GA4589@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00014.txt.bz2

On Apr 18 08:58, Christopher Faylor wrote:
> On Wed, Apr 18, 2007 at 05:44:25AM -0700, Brian Dessent wrote:
> >The attached patch allows for dllfixdbg to copy DWARF-2 debug sections
> >into the .dbg file.  There was also an (accidently?) duplicated section
> >in the cygwin.sc linker script that I removed while I was there.
> >[...]
> Thanks for doing this.  Please check in.  Can we switch to dwarf-2 by
> default in the cygwin makefile(s)?

As long as we use a 3.x or 4.0.x gcc it should be ok.  Later gcc's
explicitely switch off the generation of a DW_CFA_offset column in the
.debug_frame CIE header information, which breaks backtracing in GDB.
There's an explicit

#define DWARF2_UNWIND_INFO 0

in gcc/config/i386/cygming.h right now.  The accompanying comment is

/* DWARF2 Unwinding doesn't work with exception handling yet.  To make
   it work, we need to build a libgcc_s.dll, and dcrt0.o should be
   changed to call __register_frame_info/__deregister_frame_info.  */

I didn't see any problem with using dwarf2 in Cygwin so far and actually
it lets GDB behave much better than with stabs.  I'm not fluent enough
with this low-level stuff so I don't quite understand what this
__register_frame_info/__deregister_frame_info stuff is about.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

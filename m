Return-Path: <cygwin-patches-return-7762-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3601 invoked by alias); 25 Oct 2012 08:49:02 -0000
Received: (qmail 3562 invoked by uid 22791); 25 Oct 2012 08:48:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 25 Oct 2012 08:48:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 087492C00AF; Thu, 25 Oct 2012 10:48:39 +0200 (CEST)
Date: Thu, 25 Oct 2012 08:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch cygwin]: Replace inline-assembler in string.h by C implementation
Message-ID: <20121025084839.GC30580@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZiqULxgATmLT02tvyGM+c=0AOdtvGePggJrWh4dUqEYw@mail.gmail.com> <50880443.2020701@cs.utoronto.ca> <20121024154231.GA4261@ednor.casa.cgf.cx> <CAEwic4Y+QovZOtTTwD9NG9ZB5zYx6pvraQcknu_jpPNMWukU4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEwic4Y+QovZOtTTwD9NG9ZB5zYx6pvraQcknu_jpPNMWukU4w@mail.gmail.com>
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
X-SW-Source: 2012-q4/txt/msg00039.txt.bz2

On Oct 24 18:02, Kai Tietz wrote:
> 2012/10/24 Christopher Faylor wrote:
> > On Wed, Oct 24, 2012 at 11:07:47AM -0400, Ryan Johnson wrote:
> >>On 24/10/2012 5:16 AM, Kai Tietz wrote:
> >>> Hello,
> >>>
> >>> this patch replaces the inline-assember used in string.h by C implementation.
> >>> There are three reasons why I want to suggest this.  First, the C-code might
> >>> be optimized further by fixed (constant) arguments.  Secondly, it is
> >>> architecture
> >>> independent and so we just need to maintain on code-path.  And as
> >>> third point, by
> >>> inspecting generated assembly code produced by compiler out of C code
> >>> vs. inline-assembler
> >>> it shows that compiler produces better code.  It handles
> >>> jump-threading better, and also
> >>> improves average executed instructions.
> >>Devil's advocate: better-looking code isn't always faster code.
> >>
> >>However, I'm surprised that code was inline asm in the first place -- no
> >>special instructions or unusual control flow -- and would not be at all
> >>surprised if the compiler does a better job.
> >>
> >>Also, the portability issue is relevant now that cygwin is starting the
> >>move toward 64-bit support.
> >
> > Yes, that's exactly why Kai is proposing this.
> >
> > I haven't looked at the code but I almost always have one response to
> > a "I want to rewrite a standard function" patches:
> >
> > Have you looked at other implementations?  The current one was based
> > on a linux implementation.  A C version of these functions has likely
> > been written before, possibly even in newlib.  Were those considered?
> >
> > cgf
> 
> Sure, I have looked up standard-implementation of
> stricmp/strnicmp/strchr as code-base.  We could of course simply use
> C-runtime-funktions here, but well, those wouldn't be inlined.  The
> latter seems to me the only cause why string.h implements them at all.
> They are defined there as 'static inline', which makes them pure
> inlines.

Right, that's what I forgot entirely in my reply.  From my POV they
are good to go.  Chris?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

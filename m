Return-Path: <cygwin-patches-return-7534-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26116 invoked by alias); 3 Nov 2011 17:18:36 -0000
Received: (qmail 26001 invoked by uid 22791); 3 Nov 2011 17:18:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 03 Nov 2011 17:17:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 47FF02C0485; Thu,  3 Nov 2011 18:17:48 +0100 (CET)
Date: Thu, 03 Nov 2011 17:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extend faq.using to discuss fork failures
Message-ID: <20111103171748.GJ9159@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E570031.4080800@cs.utoronto.ca> <20110830090020.GE30452@calimero.vinschen.de> <4E5CE899.4030605@cs.utoronto.ca> <4EB2C2CD.1080400@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4EB2C2CD.1080400@dronecode.org.uk>
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
X-SW-Source: 2011-q4/txt/msg00024.txt.bz2

Hi Jon,

On Nov  3 16:35, Jon TURNEY wrote:
> On 30/08/2011 14:41, Ryan Johnson wrote:
> >That sounds reasonable, though I suspect we'd want want to keep the concluding
> >bits in the FAQ as well. Unfortunately, summertime free time has come to an
> >end so I don't know when I'll get to this next. Perhaps a good compromise for
> >now would be for you to post only the first FAQ question? That would at least
> >cut traffic to the cygwin ML a bit.
> 
> I've updated Ryan's patch to hopefully address the comments made,
> polished the language a bit in places, and split it into a patch for
> the FAQ which just says how to fix problems and a patch for the UG
> which contains the technical details.

Thanks for doing that.  I looks good to me, with just one exception.

> +<listitem>Address space layout randomization (ASLR). Starting with
> +Vista, Windows implements ASLR, which means that thread stacks,
> +heap, memory-mapped files, and statically-linked dlls are placed
> +at different (random) locations in each process. This behaviour
> +interferes with a proper <literal>fork</literal>, and if an
> +unmovable object (process heap or system dll) ends up at the wrong
> +location, Cygwin can do nothing to compensate (though it will
> +retry a few times automatically). In a 64-bit system, marking
> +executables as large address-ware and rebasing dlls to high
> +addresses has been reported to help, as ASLR affects only the
> +lower 2GB of address space.</listitem>

Starting with "In a 64-bit system" it's getting a bit weird:

- Starting with 4.5.3, gcc marks executables as large address aware
  automatically, so this is going to be a lesser problem over time.  Is
  it worth to mention this at all?  I suppose so, but the user should be
  pointed to peflags to tests for this property first for the given
  reason.

- Starting with Cygwin 1.7.10, the high address area will be used for
  the application heap on 64 bit systems and large address aware
  executables.  Mmaps are located there, too.  This in turn leaves more
  room for DLLs in the normal 2 Gigs memory area.  Therefore I would not
  like to suggest rebasing DLLs into the high address area at all.  This
  should only be done by people who know what they are doing.  Usually
  there should be enough space in the lower 2 Gigs, especially when heap
  and mmaps are out of the way, and given that the more recent rebaseall
  will not create an arbitrary 64K hole between DLLs anymore when
  rebasing.

With these changes, feel free to check in the patch.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

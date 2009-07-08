Return-Path: <cygwin-patches-return-6567-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13018 invoked by alias); 8 Jul 2009 09:06:58 -0000
Received: (qmail 13006 invoked by uid 22791); 8 Jul 2009 09:06:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 08 Jul 2009 09:06:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 76D456D5598; Wed,  8 Jul 2009 11:06:38 +0200 (CEST)
Date: Wed, 08 Jul 2009 09:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
Message-ID: <20090708090638.GY12258@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com> <4A53BC5D.7010401@gmail.com> <4A53E449.4020504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A53E449.4020504@gmail.com>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00021.txt.bz2

On Jul  8 01:11, Dave Korn wrote:
> Dave Korn wrote:
> 
> >   It doesn't do anything about the reload failure, which is a bug in GCC-3,
> > since the usage is a standard usage supported by the documentation.  It's
> > possible that it may disappear as a side-effect, in which case all the better.
> 
>   Nope, no such luck.
> 
>   Also, the libstdc++ patch has really done for compiling it with gcc-3, which
> doesn't support the weak attribute.  It also has a bug that for some reason
> two of the wrapper functions in libstdcxx_malloc.cc are emitted under their
> real names, rather than the asm("__real__*") name specified.  There's also the
> inline asm bug and there's a number of other warnings about type conversions.
> 
>   All of these could in theory be worked around.  We could compile the files
> using the inline asm with -O0, and fix the type conversion warnings(*), and we
> would have to work around the lack of support for weaks in the compiler by
> providing the definition of the __cygwin_cxx_malloc struct in assembler
> source, and probably the same for the wrapper function names, but I'm not
> inclined to do so unless there's serious demand for it.

So we can't build Cygwin with gcc-3 anymore?  I'm wondering if I'm
concerned or annoyed or sad or angry about that...

[...time passes...]

Hmm, no, not really.  What was the problem again?

But seriously, I'm still using gcc 4.3.2 20080827 (alpha-testing) 1
for building Cygwin.  Is that sufficient for now or should I upgrade?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

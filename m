Return-Path: <cygwin-patches-return-7458-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13432 invoked by alias); 31 Jul 2011 08:27:01 -0000
Received: (qmail 13404 invoked by uid 22791); 31 Jul 2011 08:26:42 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 31 Jul 2011 08:26:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A038C2C0634; Sun, 31 Jul 2011 10:26:23 +0200 (CEST)
Date: Sun, 31 Jul 2011 08:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] workaround for sigproc_init
Message-ID: <20110731082623.GA23964@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E329C56.8090605@gmail.com> <20110730210453.GB31551@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110730210453.GB31551@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q3/txt/msg00034.txt.bz2

On Jul 30 17:04, Christopher Faylor wrote:
> On Fri, Jul 29, 2011 at 08:41:10PM +0900, jojelino wrote:
> >As sigproc_init is called during dll initialization, wait_sig thread is 
> >not created as soon as possible.(this is known in msdn createthread 
> >reference. http://msdn.microsoft.com/en-us/library/ms682453(v=vs.85).aspx)
> >And then wait_sig starts to wake up as sig_dispatch_pending enters 
> >waitforsingleobject. then main thread stops for few ms. and it shows 
> >poor performance.
> 
> Incidentally, the intent of the now-defunct wincap
> wincap.has_buggy_thread_startup was to avoid creating wait_sig during
> thread startup, moving it to dll_crt0_1() which is the code that
> eventually calls main().
> 
> (This was all rehashed back in August/September 2010)
> 
> Although I didn't fiddle with that myself, Corinna reported that having
> the value set had no effect in her test cases so I don't think your
> analysis here is 100% correct.

Erm, I tested on 32 bit.  The slowdown occured on all platforms, not
only 64 bit.  64 bit is still only half as fast in the date loop for
reason or reasons unknown.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

Return-Path: <cygwin-patches-return-6244-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5865 invoked by alias); 6 Feb 2008 22:11:00 -0000
Received: (qmail 5853 invoked by uid 22791); 6 Feb 2008 22:10:59 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 06 Feb 2008 22:10:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DEA736D430E; Wed,  6 Feb 2008 23:10:39 +0100 (CET)
Date: Wed, 06 Feb 2008 22:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] fix strfuncs-related breakage of cygserver
Message-ID: <20080206221039.GA25956@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47A6888D.5CF73D29@dessent.net> <20080204121016.GA18100@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080204121016.GA18100@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00018.txt.bz2

Hi Brian,

On Feb  4 13:10, Corinna Vinschen wrote:
> On Feb  3 19:37, Brian Dessent wrote:
> > 
> > The recent addition of the sys_{wcstombs,mbstowcs}_alloc() functions to
> > strfuncs.cc causes cygserver to no longer build.  The problem is simply
> > that we can't call ccalloc() from within cygserver, but cygserver needs
> > __small_vsprintf() which in turn calls sys_wcstombs_alloc(), which in
> > turn wants to call ccalloc().  To get around this, I just
> > conditionalized the foo_alloc() functions to always use plain calloc()
> > when inside cygserver, and changed cygserver's Makefile to rebuild
> > strfuncs.cc again instead of sharing the .o from the DLL.
> > 
> > There is also a small additional buglet in that the call to
> > sys_wcstombs_alloc() in __small_vsprintf() was passing PATH_MAX as the
> > heap type, and that is not a valid cygheap_types.  I changed it to
> > HEAP_NOTHEAP as that is the only value that makes sense here since this
> > pointer is subsequently free()'d and not cfree()'d.
> > 
> > Attached are two patches, one for cygwin/ and one in cygserver/.
> 
> Thanks, applied.

On second thought it occured to me that there's no good reason that
cygserver shouldn't use standard C functions instead of the internal
__small_printf stuff, given that it is linked against Cygwin anyway.

So what I did was to remove every trace of dependency to Cygwin sources,
except for the version information.

I'd be grateful if you could have a sanitizing look.  Maybe I missed
something.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

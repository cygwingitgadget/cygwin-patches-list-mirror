Return-Path: <cygwin-patches-return-7297-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25304 invoked by alias); 4 May 2011 11:19:08 -0000
Received: (qmail 25232 invoked by uid 22791); 4 May 2011 11:18:47 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 04 May 2011 11:18:29 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AB3122C0578; Wed,  4 May 2011 13:18:26 +0200 (CEST)
Date: Wed, 04 May 2011 11:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] psignal, psiginfo, sys_siglist
Message-ID: <20110504111826.GA32087@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304506369.820.15.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1304506369.820.15.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00063.txt.bz2

On May  4 05:52, Yaakov (Cygwin/X) wrote:
> This patch exports psignal() from newlib (once my corresponding patch is
> accepted) and implements psiginfo() and sys_siglist[].  The first two
> are POSIX.1-2008, the latter is in BSD and glibc.
> 
> Patches for winsup/cygwin and winsup/doc, and a test application,
> attached.
> 
> 
> Yaakov
> 

> 2011-05-04  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* cygwin.din (psiginfo): Export.
> 	(psignal): Export.
> 	(sys_siglist): Export.
> 	* posix.sgml (std-notimpl): Move psiginfo and psignal from here...
> 	(std-susv4): ... to here.
> 	(std-deprec): Add sys_siglist.
> 	* strsig.cc (sys_siglist): New array.
> 	(psiginfo): New function.
> 	* include/cygwin/signal.h (sys_siglist): Declare.
> 	(psiginfo): Declare.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Looks fine to me.  Chris, what do you think?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

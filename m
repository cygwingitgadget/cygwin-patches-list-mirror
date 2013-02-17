Return-Path: <cygwin-patches-return-7808-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10358 invoked by alias); 17 Feb 2013 17:42:16 -0000
Received: (qmail 10141 invoked by uid 22791); 17 Feb 2013 17:41:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 17 Feb 2013 17:41:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 24BA852034F; Sun, 17 Feb 2013 18:41:44 +0100 (CET)
Date: Sun, 17 Feb 2013 17:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix speclib for x86_64
Message-ID: <20130217174144.GA24198@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130217044622.1034ae22@YAAKOV04> <20130217134141.GA12844@calimero.vinschen.de> <20130217165227.GB2177@ednor.casa.cgf.cx> <20130217170944.GA23630@calimero.vinschen.de> <20130217171829.GF2177@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130217171829.GF2177@ednor.casa.cgf.cx>
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
X-SW-Source: 2013-q1/txt/msg00019.txt.bz2

On Feb 17 12:18, Christopher Faylor wrote:
> On Sun, Feb 17, 2013 at 06:09:44PM +0100, Corinna Vinschen wrote:
> >On Feb 17 11:52, Christopher Faylor wrote:
> >> On Sun, Feb 17, 2013 at 02:41:41PM +0100, Corinna Vinschen wrote:
> >> >On Feb 17 04:46, Yaakov wrote:
> >> >
> >> >> 2013-02-16  Yaakov Selkowitz  <yselkowitz@...>
> >> >> 
> >> >> 	* Makefile.in (libcygwin.a): Move --target flag from here...
> >> >> 	(toolopts): to here, to be used by both mkimport and speclib.
> >> >> 	* speclib: Omit leading underscore in symbol names on x86_64.
> >> >
> >> >The Makefile patch is fine, but for the speclib change I wonder why
> >> >we should omit the leading underscore.  If you remove the underscore,
> >> >you're polluting the application namespace.  Is there really a good
> >> >reason to do that?  Did I miss something?
> >> 
> >> Doesn't the x86_64 target forego leading underscores on normal variable
> >> names?
> >
> >My dictionary returns ambiguous results for the word "forego",
> >so I answer that generically:
> 
> I mispelled "forgo".
> 
> >On x86_64 there's no underscore prepended to symbols.
> 
> So, why would we add an underscore?  Does binutils add underscores to
> these *_dll_iname symbols anyway?

That's what I subsumed under "Did I miss something?"  The answer is
apparently "yes".  AFAICS, binutils does not prepend an underscore to
these iname symbols, so the patch to speclib is fine.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

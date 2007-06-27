Return-Path: <cygwin-patches-return-6123-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32507 invoked by alias); 27 Jun 2007 07:35:17 -0000
Received: (qmail 32493 invoked by uid 22791); 27 Jun 2007 07:35:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 27 Jun 2007 07:35:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4D5716D47F9; Wed, 27 Jun 2007 09:35:10 +0200 (CEST)
Date: Wed, 27 Jun 2007 07:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: C99 assert
Message-ID: <20070627073510.GC15182@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20070626T181404-544@post.gmane.org> <46816D73.8050202@redhat.com> <loom.20070626T220222-433@post.gmane.org> <4681B668.3010201@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4681B668.3010201@byu.net>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00069.txt.bz2

On Jun 26 18:59, Eric Blake wrote:
> > 	Support __func__ in assert, as required by C99.
> > 	* libc/stdlib/assert.c (__assert_func): New function.
> > 	(__assert): Use __assert_func.
> > 	* libc/include/assert.h (assert) [!NDEBUG]: Use __assert_func when
> > 	possible.
> 
> If I check in just the above newlib patch, CVS cygwin will be broken when
> trying to use assert (and simply exporting __assert_func won't help, since
> cygwin's assert.cc must provide all symbols present in newlib's assert.c).
>  Likewise, this patch without newlib would break (because assert.h is
> maintained by newlib).  So, is it OK to apply this patch at the same time
> as the newlib patch, to avoid breakage?
> 
> 2007-06-26  Eric Blake
> 
> 	* assert.cc (__assert_func): New function, to match newlib header
> 	change.
> 	* cygwin.din: Export __assert_func.
> 	* include/cygwin/version.h: Bump API minor number.

Yeees, barely.  This is on the verge of being non-trivial, however.
Any chance you can sign the copyright assignment?  Please?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

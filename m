Return-Path: <cygwin-patches-return-6598-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7134 invoked by alias); 13 Aug 2009 07:38:19 -0000
Received: (qmail 7105 invoked by uid 22791); 13 Aug 2009 07:38:17 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 13 Aug 2009 07:38:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9EF796D55BE; Thu, 13 Aug 2009 09:38:00 +0200 (CEST)
Date: Thu, 13 Aug 2009 07:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix dlopen vs cxx malloc bug.
Message-ID: <20090813073800.GG13438@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A8334E6.8010808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A8334E6.8010808@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00052.txt.bz2

On Aug 12 22:32, Dave Korn wrote:
> 	* cxx.cc (default_cygwin_cxx_malloc): Enhance commenting.
> 	* dll_init.cc (dll_dllcrt0_1): Likewise.
> 	* dlfcn.cc (dlopen): Prevent dlopen()'d DLL from installing any
> 	cxx malloc overrides.
> 	* include/cygwin/cygwin_dll.h (__dynamically_loaded): New variable.
> 	* lib/_cygwin_crt0_common.cc (_cygwin_crt0_common): Check it and only
> 	install cxx malloc overrides when statically loaded.  Extend comments.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

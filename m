Return-Path: <cygwin-patches-return-6557-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22486 invoked by alias); 7 Jul 2009 17:19:28 -0000
Received: (qmail 22460 invoked by uid 22791); 7 Jul 2009 17:19:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Jul 2009 17:19:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D0E236D5599; Tue,  7 Jul 2009 19:18:58 +0200 (CEST)
Date: Tue, 07 Jul 2009 17:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Libstdc++ support changes.
Message-ID: <20090707171858.GR12258@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A537645.1070004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A537645.1070004@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00011.txt.bz2

Hi Dave,

Thanks for doing that stuff!

On Jul  7 17:22, Dave Korn wrote:
> 
>     Hi all,
> 
>   I just got done doing a C/C++/libstdc++-v3 test run against GCC HEAD using
> the Cygwin DLL built with these patches, and everything worked.  In
> particular, it passed these tests:
> 
> > FAIL: g++.old-deja/g++.abi/cxa_vec.C execution test
> > FAIL: g++.old-deja/g++.brendan/new3.C execution test
> 
> ... which fail on current 4.3.2-2 using shared libstdc++ DLL precisely because
> they expect to be able to interpose libstdc++'s own internal calls to the
> allocation operators.  I've also been using it in daily use (and before that,
> the previous spin of this patch) for a while now and nothing unusual has been
> showing up.
> [...]

This looks pretty good to me.  I have just two formal nits.

In the ChangeLogs,

> 	* Makefile.common (COMPILE_CXX):  Add support for per-file overrides

please use just one space after the colon.

At some points you're using different comment types rather freely.
Here's an example.

> Index: winsup/cygwin/libstdcxx_wrapper.cc
> ===================================================================
> RCS file: winsup/cygwin/libstdcxx_wrapper.cc
> diff -N winsup/cygwin/libstdcxx_wrapper.cc
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ winsup/cygwin/libstdcxx_wrapper.cc	7 Jul 2009 15:21:57 -0000
> @@ -0,0 +1,91 @@
> +/* libstdcxx_wrapper.cc
> +
> +   Copyright 2009 Red Hat, Inc.
> +
> +This file is part of Cygwin.
> +
> +This software is a copyrighted work licensed under the terms of the
> +Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> +details.  */

^^^^^
That's ok.

> +
> +
> +/* We provide these stubs to call into a user's
> +   provided ONDEE replacement if there is one - otherwise
> +   it must fall back to the standard libstdc++ version.
> +*/

^^^^^
The comment closing */ should be at the end of the last line of comment,
rather than starting a new line.

> +#include "winsup.h"
> +#include "cygwin-cxx.h"
> +#include "perprocess.h"
> +
> +// We are declaring asm names for the functions we define here, as we want
> +// to define the wrappers in this file.  GCC links everything with wrappers
> +// around the standard C++ memory management operators; these are the wrappers,
> +// but we want the compiler to know they are the malloc operators and not have
> +// it think they're just any old function matching 'extern "C" _wrap_*'.

^^^^^
While we have a couple of // comments in Cygwin, it would be nice to at
least don't use them for multiline comments and comments on their own
line.  Use

  /* This is a comment. */
  /* This is
     another comment. */

instead.

Other than that it looks like you tested this a lot so it's fine with
me.  Maybe Chris has some additional comment.


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

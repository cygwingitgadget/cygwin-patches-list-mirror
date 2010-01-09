Return-Path: <cygwin-patches-return-6888-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15024 invoked by alias); 9 Jan 2010 13:36:07 -0000
Received: (qmail 15014 invoked by uid 22791); 9 Jan 2010 13:36:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 13:36:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 91D016D417D; Sat,  9 Jan 2010 14:35:53 +0100 (CET)
Date: Sat, 09 Jan 2010 13:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix maybe-used-uninitialised warning.
Message-ID: <20100109133553.GP23992@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B4868F7.1000100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B4868F7.1000100@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00004.txt.bz2

On Jan  9 11:31, Dave Korn wrote:
> 
>     Hi,
> 
>   Here are two small fixes shown up by more sensitive warnings in gcc-4.5.0.
> In hookapi.cc, it notices that the loop might not run even once; in
> fhandler_tty, it appears to miss that the loops can never exit.  That probably
> needs fixing upstream (but it may be some odd artifact of C++ language rules,
> since it only happens there, not in plain C; something to do with exceptional
> exits, maybe), but until then it seemed harmless to add a trivial return zero;
> it'll only add a handful of bytes to the dll.  (I tested attribute noreturn
> and it didn't help.)
> 
> winsup/cygwin/ChangeLog:
> 
> 	* hookapi.cc (hook_or_detect_cygwin): Initialise i earlier to avoid
> 	warning.
> 
>   OK?
> 
> winsup/cygwin/ChangeLog:
> 
> 	* fhandler_tty.cc (process_input): Add redundant final return to
> 	silence (bogus?) warning.
> 
>   OK, or wait to see what upstream says about it?

Looks ok to me, independently of upstream.  It's just an elaborate
no-op.  Chris?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

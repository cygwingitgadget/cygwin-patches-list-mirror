Return-Path: <cygwin-patches-return-6891-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17878 invoked by alias); 9 Jan 2010 16:40:37 -0000
Received: (qmail 17866 invoked by uid 22791); 9 Jan 2010 16:40:36 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-52-118.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.52.118)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 16:40:32 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 402E013C0C7 	for <cygwin-patches@cygwin.com>; Sat,  9 Jan 2010 11:40:23 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 32FCE2B35A; Sat,  9 Jan 2010 11:40:23 -0500 (EST)
Date: Sat, 09 Jan 2010 16:40:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix maybe-used-uninitialised warning.
Message-ID: <20100109164023.GB12815@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q1/txt/msg00007.txt.bz2

On Sat, Jan 09, 2010 at 11:31:03AM +0000, Dave Korn wrote:
>
>    Hi,
>
>  Here are two small fixes shown up by more sensitive warnings in gcc-4.5.0.
>In hookapi.cc, it notices that the loop might not run even once; in
>fhandler_tty, it appears to miss that the loops can never exit.  That probably
>needs fixing upstream (but it may be some odd artifact of C++ language rules,
>since it only happens there, not in plain C; something to do with exceptional
>exits, maybe), but until then it seemed harmless to add a trivial return zero;
>it'll only add a handful of bytes to the dll.  (I tested attribute noreturn
>and it didn't help.)
>
>winsup/cygwin/ChangeLog:
>
>	* hookapi.cc (hook_or_detect_cygwin): Initialise i earlier to avoid
>	warning.
>
>  OK?

I'd prefer i be initialized to zero.

>winsup/cygwin/ChangeLog:
>
>	* fhandler_tty.cc (process_input): Add redundant final return to
>	silence (bogus?) warning.

These are ok.  As usual, I hate that we have to make these pointless
accommodations.  But I've been hating that for many years so it's
nothing newo.

cgf

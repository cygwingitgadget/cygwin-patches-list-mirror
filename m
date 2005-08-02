Return-Path: <cygwin-patches-return-5604-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18074 invoked by alias); 2 Aug 2005 09:35:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18052 invoked by uid 22791); 2 Aug 2005 09:35:14 -0000
Received: from p54941596.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.21.150)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 02 Aug 2005 09:35:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6976B6D4256; Tue,  2 Aug 2005 11:35:12 +0200 (CEST)
Date: Tue, 02 Aug 2005 09:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix possible segfault creating detached thread
Message-ID: <20050802093512.GN14783@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.61.0508012001310.4694@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508012001310.4694@mgorse.dhs.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00059.txt.bz2

On Aug  1 20:05, Mike Gorse wrote:
> ARGH!  I really need to be more careful...  Sorry for all the emails.
> 
> One last correction...

> 2005-08-01 Michael Gorse <mgorse@alum.wpi.edu>
> 
>         * thread.cc (pthread::create(3 args)): Make bool.
>         (pthread_null::create): Ditto.
>         thread.h: Ditto.
> 
>         * thread.cc (pthread::create(4 args)): Check return of inner
>         create  rather than calling is_good_object().

Nope, sorry.  It should look like this:

2005-08-01 Michael Gorse <mgorse@alum.wpi.edu>

        * thread.cc (pthread::create(3 args)): Make bool.
        (pthread_null::create): Ditto.
        (pthread::create(4 args)): Check return of inner create rather than
	calling is_good_object().
        * thread.h: Ditto.

Can you please review your patch file?  I was unable to apply the patch,
even when using the -l option:

$ patch -l -p0 < ~/thread.diff
patching file thread.cc
Hunk #1 FAILED at 491.
Hunk #2 FAILED at 519.
Hunk #4 FAILED at 3265.

Dunno if that's related to your mail client but maybe it helps to
regenerate the patch file and attach it instead of sending it inline.
Sure, I could apply the changes manually, but that's not how it's
supposed to work, is it?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

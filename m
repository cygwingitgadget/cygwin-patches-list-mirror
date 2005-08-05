Return-Path: <cygwin-patches-return-5609-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8781 invoked by alias); 5 Aug 2005 16:16:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8765 invoked by uid 22791); 5 Aug 2005 16:16:22 -0000
Received: from pd95b12ea.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (217.91.18.234)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 05 Aug 2005 16:16:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 074AB544123; Fri,  5 Aug 2005 18:16:20 +0200 (CEST)
Date: Fri, 05 Aug 2005 16:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix possible segfault creating detached thread (fwd)
Message-ID: <20050805161619.GH14783@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.61.0508050831040.17631@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508050831040.17631@mgorse.dhs.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00064.txt.bz2

On Aug  5 08:31, Mike Gorse wrote:
> 2005-08-05 Michael Gorse <mgorse@alum.wpi.edu>
> 
>  * thread.cc (pthread::create(3 args)): Make bool.
>  (pthread_null::create): Ditto.
>  (pthread::create(4 args)): Check return of inner create rather than
>  calling is_good_object().
>  * thread.h: Ditto.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

Return-Path: <cygwin-patches-return-6464-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 916 invoked by alias); 3 Apr 2009 08:26:51 -0000
Received: (qmail 898 invoked by uid 22791); 3 Apr 2009 08:26:51 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 08:26:45 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 136866D554C; Fri,  3 Apr 2009 10:26:35 +0200 (CEST)
Date: Fri, 03 Apr 2009 08:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <asm/byteorder.h> missing prototypes warning
Message-ID: <20090403082635.GB27898@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D57E45.4000409@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D57E45.4000409@users.sourceforge.net>
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
X-SW-Source: 2009-q2/txt/msg00006.txt.bz2

On Apr  2 22:11, Yaakov S wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> This is similar in concept to the <stdio.h> patch I just posted to
> newlib@.  It looks like I mistakenly removed the prototypes when I was
> trying to fix the C99 inline issue in <asm/byteorder.h>.
> 
> Since this makes four lines which need the C99 inline workaround, I
> decided to make a macro similar to that in <stdio.h>.  I didn't use the
> same macro name, since I didn't want to deal with a possible collision
> with, or dependency on, <stdio.h>.  Perhaps there is a better way of
> dealing with this; I'm certainly open to ideas.
> 
> Patch attached.

Wouldn't it be better to move newlib's _ELIDABLE_INLINE definition to
some nicely matchin header like _ansi.h and then use it wherever it
fits?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

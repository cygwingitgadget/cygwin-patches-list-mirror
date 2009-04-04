Return-Path: <cygwin-patches-return-6481-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14780 invoked by alias); 4 Apr 2009 15:50:00 -0000
Received: (qmail 14764 invoked by uid 22791); 4 Apr 2009 15:49:59 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 15:49:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4422A6D5521; Sat,  4 Apr 2009 17:49:41 +0200 (CEST)
Date: Sat, 04 Apr 2009 15:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <asm/byteorder.h> missing prototypes warning
Message-ID: <20090404154941.GI852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D57E45.4000409@users.sourceforge.net> <20090403082635.GB27898@calimero.vinschen.de> <49D63467.2050506@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D63467.2050506@users.sourceforge.net>
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
X-SW-Source: 2009-q2/txt/msg00023.txt.bz2

On Apr  3 11:08, Yaakov S wrote:
> Corinna Vinschen wrote:
> > Wouldn't it be better to move newlib's _ELIDABLE_INLINE definition to
> > some nicely matchin header like _ansi.h and then use it wherever it
> > fits?
> 
> As I said, perhaps there is a better way of dealing with this.  The main
> reason I didn't go for that solution in the first place is that I didn't
> find other newlib/cygwin headers that would require this.  If there are
> indeed more, then centralizing this makes perfect sense.

I've applied this patch using the _ELIDABLE_INLINE macro.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

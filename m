Return-Path: <cygwin-patches-return-6463-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9671 invoked by alias); 3 Apr 2009 08:19:06 -0000
Received: (qmail 9427 invoked by uid 22791); 3 Apr 2009 08:19:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 08:18:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4FF7C6D554C; Fri,  3 Apr 2009 10:18:48 +0200 (CEST)
Date: Fri, 03 Apr 2009 08:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <asm/byteorder.h> missing prototypes warning
Message-ID: <20090403081848.GA27898@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D57E45.4000409@users.sourceforge.net> <49D5B44F.7030509@gmail.com> <49D5C5BA.1040308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D5C5BA.1040308@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00005.txt.bz2

On Apr  3 09:15, Dave Korn wrote:
> Dave Korn wrote:
> 
> >   Maybe we can call it __extern__ (so it looks like a c99-compatible extension
> > keyword and doesn't cause problems for non-GCC compilers)
> 
>   ENOCOFFEE.  That's not a c99 extension, it's a gcc extension.  Dur me!

Who on earth decided that a redundant declaration of an inline function
is necessary to avoid a useless warning?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

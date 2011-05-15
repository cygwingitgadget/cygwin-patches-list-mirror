Return-Path: <cygwin-patches-return-7364-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11370 invoked by alias); 15 May 2011 19:12:05 -0000
Received: (qmail 11296 invoked by uid 22791); 15 May 2011 19:11:41 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 15 May 2011 19:11:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A3ECC2C0577; Sun, 15 May 2011 21:11:23 +0200 (CEST)
Date: Sun, 15 May 2011 19:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] CPU-time clocks
Message-ID: <20110515191123.GC21667@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1305484641.6124.31.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1305484641.6124.31.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00130.txt.bz2

Hi Yaakov,

On May 15 13:37, Yaakov (Cygwin/X) wrote:
> The attached patches implement POSIX CPU-time clock support:

I just applied a patch to implement pthread_attr_setstack etc.
This affects your patch in that it won't apply cleanly anymore.
Would you mind to regenerate your patches relative to CVS HEAD?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

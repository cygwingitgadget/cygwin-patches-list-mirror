Return-Path: <cygwin-patches-return-7712-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10422 invoked by alias); 2 Sep 2012 10:27:56 -0000
Received: (qmail 10344 invoked by uid 22791); 2 Sep 2012 10:27:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 02 Sep 2012 10:27:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6FEBD2C00CA; Sun,  2 Sep 2012 12:27:18 +0200 (CEST)
Date: Sun, 02 Sep 2012 10:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
Message-ID: <20120902102718.GC13401@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <503982F3.9010004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <503982F3.9010004@gmail.com>
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
X-SW-Source: 2012-q3/txt/msg00033.txt.bz2

Hi Jin-woo,

On Aug 26 10:59, Jin-woo Ye wrote:
> This patch fixes the problem making pseudo-reloc too slow when there
> is many pseudo-reloc entries in rdata section by deciding when not
> to call Virtual{Query,Protect} to save overhead.
> I tested this patch and time taken for pseudo-reloc reduced 1800ms
> to 16ms for 3682 entries.
> Please review this patch.

Done.  The idea is good, but I wasn't quite happy with your code.  It's
hard to read and it's more complicated than necessary.  For instance,
you only handle one page at a time, but your code keeps an array for two
page information entries around for no good reason.

I checked in a simplified version of your patch.  Please have a look.
Since the code in question is in the public domain, it doesn't require
a Cygwin copyright assignment.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

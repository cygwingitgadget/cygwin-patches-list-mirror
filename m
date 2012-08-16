Return-Path: <cygwin-patches-return-7705-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19435 invoked by alias); 16 Aug 2012 16:23:36 -0000
Received: (qmail 19355 invoked by uid 22791); 16 Aug 2012 16:23:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 16 Aug 2012 16:22:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C73972C00CA; Thu, 16 Aug 2012 18:22:45 +0200 (CEST)
Date: Thu, 16 Aug 2012 16:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
Message-ID: <20120816162245.GC14163@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <502ABB77.2080502@towo.net> <20120816093334.GB20051@calimero.vinschen.de> <502CE384.8050709@towo.net> <20120816123033.GH17546@calimero.vinschen.de> <502D0199.6040203@towo.net> <502D10AF.1040501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <502D10AF.1040501@redhat.com>
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
X-SW-Source: 2012-q3/txt/msg00026.txt.bz2

On Aug 16 09:24, Eric Blake wrote:
> On 08/16/2012 08:20 AM, Thomas Wolff wrote:
> 
> >>> MB_CUR_MAX does not work because its value is 1 at this point
> >> So what about MB_LEN_MAX then?  There's no problem using a multiplier,
> >> but a symbolic constant is always better than a numerical constant.
> > I've now used _MB_LEN_MAX from newlib.h, rather than MB_LEN_MAX from
> > limits.h (note the "_" distinction :) ),
> > because the latter, by its preceding comment, reserves the option to be
> > changed into a dynamic function in the future, which could then possibly
> > have the same problems as MB_CUR_MAX.
> 
> POSIX requires MB_LEN_MAX to be a constant, only MB_CUR_MAX can be
> dynamic.  We cannot change MB_LEN_MAX to be dynamic in the future.

...also, Cygwin's include/limits.h doesn't mention to convert to
a function.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

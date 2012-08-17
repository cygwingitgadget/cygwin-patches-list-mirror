Return-Path: <cygwin-patches-return-7707-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32495 invoked by alias); 17 Aug 2012 09:23:22 -0000
Received: (qmail 32432 invoked by uid 22791); 17 Aug 2012 09:22:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 17 Aug 2012 09:22:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 83E1E2C00CA; Fri, 17 Aug 2012 11:22:39 +0200 (CEST)
Date: Fri, 17 Aug 2012 09:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
Message-ID: <20120817092239.GA11017@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <502ABB77.2080502@towo.net> <20120816093334.GB20051@calimero.vinschen.de> <502CE384.8050709@towo.net> <20120816123033.GH17546@calimero.vinschen.de> <502D0199.6040203@towo.net> <502D10AF.1040501@redhat.com> <20120816162245.GC14163@calimero.vinschen.de> <502E0451.3020609@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <502E0451.3020609@towo.net>
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
X-SW-Source: 2012-q3/txt/msg00028.txt.bz2

On Aug 17 10:44, Thomas Wolff wrote:
> On 16.08.2012 18:22, Corinna Vinschen wrote:
> >On Aug 16 09:24, Eric Blake wrote:
> >>On 08/16/2012 08:20 AM, Thomas Wolff wrote:
> >>
> >>>>>MB_CUR_MAX does not work because its value is 1 at this point
> >>>>So what about MB_LEN_MAX then?  There's no problem using a multiplier,
> >>>>but a symbolic constant is always better than a numerical constant.
> >>>I've now used _MB_LEN_MAX from newlib.h, rather than MB_LEN_MAX from
> >>>limits.h (note the "_" distinction :) ),
> >>>because the latter, by its preceding comment, reserves the option to be
> >>>changed into a dynamic function in the future, which could then possibly
> >>>have the same problems as MB_CUR_MAX.
> >>POSIX requires MB_LEN_MAX to be a constant, only MB_CUR_MAX can be
> >>dynamic.  We cannot change MB_LEN_MAX to be dynamic in the future.
> >...also, Cygwin's include/limits.h doesn't mention to convert to
> >a function.
> Not sure how to interpret exactly what it mentions.

This is from the time I was working on the extended locale support
in Cygwin 1.7.  I have not the faintest idea anymore what I was trying
to say with this comment.

>  Anyway, my
> updated patch (using MB_LEN_MAX) proposes a change here as well.

Thanks.  I dropped the hint that 4 is enough.  I'm not so sure about
that.  Linux, for instance, defines MB_LEN_MAX as 16.

Other than that, patch applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

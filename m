Return-Path: <cygwin-patches-return-7110-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9576 invoked by alias); 17 Sep 2010 07:41:40 -0000
Received: (qmail 9520 invoked by uid 22791); 17 Sep 2010 07:41:31 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 17 Sep 2010 07:41:27 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5F2826D4194; Fri, 17 Sep 2010 09:41:24 +0200 (CEST)
Date: Fri, 17 Sep 2010 07:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: Fw: res_send() doesn't work with osquery enabled]
Message-ID: <20100917074124.GI15121@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100826175510.GN6726@calimero.vinschen.de> <20100917070349.GG15121@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20100917070349.GG15121@calimero.vinschen.de>
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
X-SW-Source: 2010-q3/txt/msg00070.txt.bz2

On Sep 17 09:03, Corinna Vinschen wrote:
> ----- Forwarded message from "Pierre A. Humblet" -----
> > | Sorry, an earlier answer was rejected due to inappropriate subject.

In theory, that should be fixed.

> > | After thinking about it, I don't like mixing calls to the Windows resolver 
> > | for res_query and contacting DNS servers directly with res_send,
> > | as proposed. So I have a patch where res_send also uses the Windows
> > | resolver. 
> > | 
> > | Unfortunately although I can build cygwin1.dll fine, it's broken,
> > | something to do with a NULL stdout (this is from /bin/date)
> > |   1 thread 2588.0x4c0  fputc (ch=10, file=0x0)
> > |     at ../../../../../src/newlib/libc/stdio/fputc.c:101
> > | 
> > | Not sure what to do, I already did make clean for cygwin.

I don't know either.  I have no such problem with CVS HEAD.

> > | Also minires used to come with a README explaining the effect of
> > | an optional /etc/resolv.conf  (e.g. to bypass the Windows resolver).
> > | That information is not present currently [ and nobody asks for it :) ]
> > | I wonder if we should add it and where to place it. One option is the 
> > | User's Guide. Another option is a custom resolv.conf man page. 
> > | What do you think?

The User's Guide would be a good place, IMHO.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

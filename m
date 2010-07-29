Return-Path: <cygwin-patches-return-7048-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28003 invoked by alias); 29 Jul 2010 05:51:02 -0000
Received: (qmail 27984 invoked by uid 22791); 29 Jul 2010 05:51:00 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-4.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.4)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 29 Jul 2010 05:50:55 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 69DB613C061	for <cygwin-patches@cygwin.com>; Thu, 29 Jul 2010 01:50:53 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 6036E2B352; Thu, 29 Jul 2010 01:50:53 -0400 (EDT)
Date: Thu, 29 Jul 2010 05:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix build warnings for functions without return value
Message-ID: <20100729055053.GA18655@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <004d01cb2e99$7567c500$60374f00$@gmail.com> <20100728224433.GA11483@ednor.casa.cgf.cx> <000601cb2eab$52022a30$f6067e90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601cb2eab$52022a30$f6067e90$@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00008.txt.bz2

On Wed, Jul 28, 2010 at 04:19:22PM -0700, Daniel Colascione wrote:
>> From: cygwin-patches-owner
>>
>>I don't see why this is needed.  Cygwin uses -Werror by default so, if
>>gcc 4.3.4 emitted warnings we wouldn't be able to build a release or
>>make a snapshot.
>
>It's because Cygwin uses -Werror that I had to patch the source.  I'm
>compiling with '-Os -march=native',

That's prolly something you should have mentioned initially.  It would
have shortened this conversation.

If this really is a problem then it seems like the right way to fix it
is with __attribute__ ((noreturn)).  I'll check in a fix to do that.

>which must tickle a different part of the optimizer and thereby produce
>this warning.  (One of the nice things about clang is reportedly that
>it produces the same warnings no matter what the optimizer does.)

Sorry but this seems like a non-sequitur.  clang doesn't seem pertinent
to this discussion.

>Besides, the current code is technically undefined and the patch
>removes that undefined behavior --- which could start producing
>warnings for the current build at any time.

I don't believe that the behavior of a while (1) or for (;;) is
undefined.  I suspect that when compiling with -O2 the compiler is
actually smart enough to figure out that the function doesn't return and
to avoid a warning.  So, I'd say it's equally possible that the -Os
behavior could be fixed.

cgf

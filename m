Return-Path: <cygwin-patches-return-8338-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75822 invoked by alias); 19 Feb 2016 00:57:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75806 invoked by uid 89); 19 Feb 2016 00:57:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*r:8.12.11, completing, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Fri, 19 Feb 2016 00:57:29 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u1J0vCev012957	for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2016 16:57:13 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Fri, 19 Feb 2016 00:57:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: gprof profiling of multi-threaded Cygwin programs
In-Reply-To: <20160218104125.GB8575@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1602181654480.11717@m0.truegem.net>
References: <56C404FF.502@maxrnd.com> <20160217104241.GA31536@calimero.vinschen.de> <Pine.BSF.4.63.1602172218120.19332@m0.truegem.net> <20160218104125.GB8575@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00044.txt.bz2

On Thu, 18 Feb 2016, Corinna Vinschen wrote:
> On Feb 17 22:35, Mark Geisert wrote:
>> I do see that a case could be made for general profiling documentation in
>> winsup/doc/programming.xml but that's more than I want to take on at the
>> moment.
>
> It doesn't have to be part of the source patch.  It would just be nice
> if you could write a few words about profiling.  I'm *not* asking for
> a complete gprof doc or somehting like that, it's safe to assume that
> the users of the tool know how to read man or info pages.  Therefore,
> something short like gcc.xml or gdb.xml would be totally sufficient.
> Even shorter than those.  Just a few words about profiling in general,
> and an example would be cool.

Ah, OK.  That I can/will do after completing the source patch.

..mark

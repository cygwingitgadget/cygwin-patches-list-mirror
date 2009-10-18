Return-Path: <cygwin-patches-return-6787-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5768 invoked by alias); 18 Oct 2009 17:58:57 -0000
Received: (qmail 5750 invoked by uid 22791); 18 Oct 2009 17:58:56 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 17:58:53 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 7FF28B1FF7 	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2009 13:58:51 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Sun, 18 Oct 2009 13:58:51 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 1D8C5A592; 	Sun, 18 Oct 2009 13:58:51 -0400 (EDT)
Message-ID: <4ADB5757.4000807@cwilson.fastmail.fm>
Date: Sun, 18 Oct 2009 17:58:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm> <20091018084824.GA25560@calimero.vinschen.de> <4ADB22B8.5060108@cwilson.fastmail.fm> <4ADB3334.2080502@byu.net>
In-Reply-To: <4ADB3334.2080502@byu.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00118.txt.bz2

Eric Blake wrote:

> Well, that won't happen unless Keith starts a thread on the autoconf list
> giving suggestions on how he thinks it can be fixed.  Complaining on the
> subscriber-only mingw is the wrong approach to get autoconf to even be
> aware of his complaint or ideas for improvement (not that me replying on
> the cygwin-patches list is any better ;)

IMO, he wasn't really serious about that "proposal" -- and even if it
were, he wanted /me/ to run point on it, not himself.  It was more of a
"sure, I'll let you drive my car just as soon as you get a law passed by
every country in the world and the UN, granting me personal ownership of
the moon".

Data point: even Keith's "proposal":
> That said, I will offer you an 
> accommodation: you convince the automake maintainers to fix their 
> broken implementation, such that the paradigm becomes
> 
>   $(SYSDRIVE)$(DESTDIR)$(prefix)...
> 
> and so forth, the autoconf maintainers to provide a standard macro to 
> set SYSDRIVE appropriately for native Windows hosts, and both to 
> promote the use of this paradigm among those projects wishing to 
> support DESTDIR, and I will withdraw my objection.

won't solve the problem (for DESTDIR + mingw).  We've (the mingw team)
always recommended that users configure using "--prefix=`cd /posix/path
&& pwd -W`" under MSYS, which results in "$(prefix)=C:/mount/point/path"
(I don't know what Keith uses for --prefix when configuring in his
customary cross-build environment).  So, even if SYSDRIVE itself is
accommodated, you'd have to *rewrite* $prefix behind the user's back,
removing its X: component if present. Plus, if $DESTDIR also contains a
sysdrive, which one do you use?  Either choice will cause problems...

No way that sort of thing would fly with the auto* teams, and I reckon
Keith knows that.  Hence, not a serious proposal.

IMO, his real goal is to "encourage" (force) everyone to stop using
DESTDIR altogether. I admit, he has a point: the FSF only requires that
'make install prefix=/new/prefix' work; they impose no such requirement
concerning DESTDIR -- probably because it just doesn't work on some
platforms like mingw.  But I object to the 'leveraging' he's using here:
by refusing to allow DESTDIR in winsup/mingw, he makes it so that we
(cygwin) might as well expunge DESTDIR from winsup/*/ entirely --
because DESTDIR is useless from $(build)/i686-pc-cygwin/winsup.

But that's his unilateralism forcing /our/ decisions, and I object to
that, without a more grounded reason than, as Ralf put it, "when users
look at our (mingw's) makefiles, they might think it could work".

--
Chuck
